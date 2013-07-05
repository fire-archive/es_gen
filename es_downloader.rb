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

FileUtils.mkpath "Dev/Tools"
Dir.chdir "Dev/Tools"
system "git clone git://github.com/TTimo/es_core.git"
system "hg clone http://bitbucket.org/sinbad/ogre/"
system "git clone git://github.com/zeromq/libzmq.git"
system "git clone git://github.com/zeromq/czmq.git"
system "hg clone http://hg.libsdl.org/SDL"
system "hg clone https://bitbucket.org/cabalistic/ogredeps"

Dir['./[^.]*'].select { |e| File.directory? e }.each do |e|
  Dir.chdir(e) { system "git pull" } if File.exist? File.join(e, '.git')
end

Dir['./[^.]*'].select { |e| File.directory? e }.each do |e|
  Dir.chdir(e) { system "hg pull -u" } if File.exist? File.join(e, '.hg')
end

# Download, unpack and build tbb

Dir.chdir "ogredeps"
FileUtils.mkpath "Build"
Dir.chdir "Build"
system "cmake -G \"Visual Studio 11\" .."
system %q["%windir%\Microsoft.NET\Framework\v4.0.30319\MSBuild.exe" /nologo /property:Configuration=Debug ALL_BUILD.vcxproj]
system %q["%windir%\Microsoft.NET\Framework\v4.0.30319\MSBuild.exe" /nologo /property:Configuration=Debug INSTALL.vcxproj]
system %q["%windir%\Microsoft.NET\Framework\v4.0.30319\MSBuild.exe" /nologo /property:Configuration=Release ALL_BUILD.vcxproj]
system %q["%windir%\Microsoft.NET\Framework\v4.0.30319\MSBuild.exe" /nologo /property:Configuration=Release INSTALL.vcxproj]

Dir.chdir "../../ogre"
FileUtils.mkpath "Build"
Dir.chdir "Build"
system "cmake -G \"Visual Studio 11\" -DOGRE_BUILD_RENDERSYSTEM_GL3PLUS=1 -DCMAKE_INSTALL_PREFIX=../../../../Run -DOGRE_DEPENDENCIES_DIR=../../ogredeps/Build/ogredeps .."
system %q["%windir%\Microsoft.NET\Framework\v4.0.30319\MSBuild.exe" /nologo /property:Configuration=RelWithDebInfo ALL_BUILD.vcxproj]
system %q["%windir%\Microsoft.NET\Framework\v4.0.30319\MSBuild.exe" /nologo /property:Configuration=RelWithDebInfo INSTALL.vcxproj]

# Build SDL
# Build libzmq
# Build czmq
# Build es_core