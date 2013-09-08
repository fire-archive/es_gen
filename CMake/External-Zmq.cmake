IF(WIN32)
ExternalProject_Add(Zmq
  GIT_REPOSITORY "git@github.com:zeromq/libzmq.git"
  PREFIX "${CMAKE_CURRENT_BINARY_DIR}/Tools/libzmq"
  CMAKE_ARGS -DCMAKE_INSTALL_PREFIX=${CMAKE_CURRENT_BINARY_DIR}/Run
)
ENDIF(WIN32)

IF(UNIX)
ExternalProject_Add(Zmq
  GIT_REPOSITORY "git@github.com:zeromq/libzmq.git"
  PREFIX "${CMAKE_CURRENT_BINARY_DIR}/Tools/libzmq"
  CONFIGURE_COMMAND ./autogen.sh && ./configure --prefix=${CMAKE_CURRENT_BINARY_DIR}/Run
  BUILD_COMMAND make
  INSTALL_COMMAND make install
  BUILD_IN_SOURCE 1
)
ENDIF(UNIX)
