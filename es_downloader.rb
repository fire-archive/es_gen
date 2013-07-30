# -*- coding: utf-8 -*-
=begin
Copyright (c) 2013, K Ernest Lee
All rights reserved.

Redistribution and use in source and binary forms, with or without
modification, are permitted provided that the following conditions are met:
* Redistributions of source code must retain the above copyright
notice, this list of conditions and the following disclaimer.
* Redistributions in binary form must reproduce the above copyright
notice, this list of conditions and the following disclaimer in the
documentation and/or other materials provided with the distribution.
* Neither the name of K Ernest Lee nor the names of its contributors may be
used to endorse or promote products derived from this software without
specific prior written permission.

THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND
ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
DISCLAIMED. IN NO EVENT SHALL K Ernest Lee BE LIABLE FOR ANY
DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
(INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
(INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
=end

require 'fileutils'
require 'open-uri'
require 'rbconfig'

def os
  @os ||= (
    host_os = RbConfig::CONFIG['host_os']
    case host_os
    when /mswin|msys|mingw|cygwin|bccwin|wince|emc/
      :windows
    when /darwin|mac os/
      :macosx
    when /linux/
      :linux
    when /solaris|bsd/
      :unix
    else
      raise Error::WebDriverError, "unknown os: #{host_os.inspect}"
    end
  )
end

FileUtils.mkpath "Dev/Tools"
Dir.chdir "Dev/Tools"
system "git clone https://github.com/fire/es_core.git -b develop"
system "hg clone https://bitbucket.org/sinbad/ogre/"
system "git clone https://github.com/zeromq/zeromq3-x.git libzmq"
system "git clone git://github.com/zeromq/czmq.git"
system "hg clone http://hg.libsdl.org/SDL"
system "hg clone https://bitbucket.org/cabalistic/ogredeps"
system "git clone git://github.com/fire/tbb41_20130613oss tbb"
system "git clone https://chromium.googlesource.com/external/gyp.git"

Dir['./[^.]*'].select { |e| File.directory? e }.each do |e|
  Dir.chdir(e) { system "git pull" } if File.exist? File.join(e, '.git')
  Dir.chdir(e) { system "hg pull -u" } if File.exist? File.join(e, '.hg')
end

Dir.chdir "ogredeps"
FileUtils.mkpath "Build"
Dir.chdir "Build"

if os == :windows
  system "cmake -G \"Visual Studio 11\" .."
  system %q["%windir%\Microsoft.NET\Framework\v4.0.30319\MSBuild.exe" /nologo /property:Configuration=Debug ALL_BUILD.vcxproj]
  system %q["%windir%\Microsoft.NET\Framework\v4.0.30319\MSBuild.exe" /nologo /property:Configuration=Debug INSTALL.vcxproj]
  system %q["%windir%\Microsoft.NET\Framework\v4.0.30319\MSBuild.exe" /nologo /property:Configuration=Release ALL_BUILD.vcxproj]
  system %q["%windir%\Microsoft.NET\Framework\v4.0.30319\MSBuild.exe" /nologo /property:Configuration=Release INSTALL.vcxproj]
end

if os == :macosx
  system "cmake -G Xcode .."
  system "xcodebuild -configuration Release"
  system "xcodebuild -scheme install"
end

Dir.chdir "../../ogre"
FileUtils.mkpath "Build"
Dir.chdir "Build"

if os == :windows
  system "cmake -G \"Visual Studio 11\" -DOGRE_BUILD_RENDERSYSTEM_GL3PLUS=1 -DOGRE_BUILD_SAMPLES=0 -DCMAKE_INSTALL_PREFIX=../../../../Run -DTBB_HOME=\"#{Dir.pwd + "/../../tbb/"}\" -DOGRE_DEPENDENCIES_DIR=../../ogredeps/Build/ogredeps .."
  system %q["%windir%\Microsoft.NET\Framework\v4.0.30319\MSBuild.exe" /nologo /property:Configuration=RelWithDebInfo ALL_BUILD.vcxproj]
end

if os == :macosx
  system "cmake -G \"Xcode\" -DOGRE_BUILD_RENDERSYSTEM_-DOGRE_BUILD_SAMPLES=0 GL3PLUS=1 -DCMAKE_INSTALL_PREFIX=../../../../Run -DOGRE_DEPENDENCIES_DIR=../../ogredeps/Build/ogredeps .."
  system "xcodebuild -configuration Release"
end

# Build libzmq
# Build czmq
# Build es_core

Dir.chdir "../../.."
Dir.pwd

unless File.directory?("../Run/")
  FileUtils.mkdir_p("../Run/")
end

Dir.glob("Tools/ogre/Build/bin/relwithdebinfo/*.dll") {|f| FileUtils.cp File.expand_path(f), "../Run/" }
Dir.glob("Tools/ogre/Build/bin/relwithdebinfo/*.pdb") {|f| FileUtils.cp File.expand_path(f), "../Run/" }
Dir.glob("Tools/tbb/bin/ia32/vc11/*.dll") {|f| FileUtils.cp File.expand_path(f), "../Run/" }
Dir.glob("Tools/libzmq/bin/Win32/libzmq*") {|f| FileUtils.cp File.expand_path(f), "../Run/" }
FileUtils.cp_r "Tools/es_core/binaries/media", "../Run/"

Dir.chdir "Tools/czmq/"

system "git apply -p0 ../../Project/czmq-remove-inline.patch"

Dir.chdir "../.."

if os == :windows
  system %q["C:\Program Files (x86)\Microsoft Visual Studio 11.0\Common7\IDE\devenv.exe" Tools\libzmq\builds\msvc\msvc10.sln /upgrade]
  system %q["%windir%\Microsoft.NET\Framework\v4.0.30319\MSBuild.exe" /nologo /property:Configuration=Release  Tools\libzmq\builds\msvc\msvc10.sln]
  system %q["%windir%\Microsoft.NET\Framework\v4.0.30319\MSBuild.exe" /nologo /property:Configuration=Release Tools\czmq\builds\msvc\czmq.vcxproj]
end

Dir.chdir "./Project"

system "gyp --depth=." # Build es_core SDL

if os == :macosx
  system "xcodebuild -project es_core"
end

if os == :windows
  system %q["%windir%\Microsoft.NET\Framework\v4.0.30319\MSBuild.exe" /nologo es_core.sln]
end

Dir.chdir ".."

Dir.glob("Project/default/*.dll") {|f| FileUtils.cp File.expand_path(f), "../Run/" }
Dir.glob("Project/default/*.pdb") {|f| FileUtils.cp File.expand_path(f), "../Run/" }
Dir.glob("Project/default/*.exe") {|f| FileUtils.cp File.expand_path(f), "../Run/" }