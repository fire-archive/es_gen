IF(UNIX)
ExternalProject_Add(Czmq
  GIT_REPOSITORY "https://github.com/fire/czmq.git"
  PREFIX "${CMAKE_CURRENT_BINARY_DIR}/Tools/Czmq"
  CONFIGURE_COMMAND ./autogen.sh && ./configure --with-libzmq=${CMAKE_CURRENT_BINARY_DIR}/Run --prefix=${CMAKE_CURRENT_BINARY_DIR}/Run
  BUILD_COMMAND make all
  INSTALL_COMMAND make install
  BUILD_IN_SOURCE 1
)
ENDIF(UNIX)

IF(WIN32)
ExternalProject_Add(Czmq
  DEPENDS Ogredeps
  GIT_REPOSITORY "https://github.com/fire/czmq.git"
  PREFIX "${CMAKE_CURRENT_BINARY_DIR}/Tools/Czmq"
  CMAKE_ARGS -DCMAKE_INSTALL_PREFIX=${CMAKE_BINARY_DIR}/Run/ -DWITH_LIBZMQ=${CMAKE_CURRENT_BINARY_DIR}/Run/include
)
ENDIF(WIN32)
