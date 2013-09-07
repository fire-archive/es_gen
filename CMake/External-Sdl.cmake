IF(UNIX)
ExternalProject_Add(Sdl
  HG_REPOSITORY "https://hg.libsdl.org/SDL"
  PREFIX "${CMAKE_CURRENT_BINARY_DIR}/Tools/Sdl"
  CONFIGURE_COMMAND ./autogen.sh && ./configure --prefix=${CMAKE_CURRENT_BINARY_DIR}/Run
  BUILD_COMMAND make
  INSTALL_COMMAND make install
  BUILD_IN_SOURCE 1
)
ENDIF(UNIX)