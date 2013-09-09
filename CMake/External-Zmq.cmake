IF(WIN32)
ExternalProject_Add(Zmq
  GIT_REPOSITORY "https://github.com/zeromq/libzmq.git"
  PATCH_COMMAND git apply < ${CMAKE_CURRENT_SOURCE_DIR}/CMake/zmq-Cmake.patch
  PREFIX "${CMAKE_CURRENT_BINARY_DIR}/Tools/libzmq"
  CMAKE_ARGS -DCMAKE_INSTALL_PREFIX=${CMAKE_CURRENT_BINARY_DIR}/Run -DBUILD_TESTING=0
)
ENDIF(WIN32)

IF(UNIX)
ExternalProject_Add(Zmq
  GIT_REPOSITORY "https://github.com/zeromq/libzmq.git"
  PREFIX "${CMAKE_CURRENT_BINARY_DIR}/Tools/libzmq"
  CONFIGURE_COMMAND ./autogen.sh && ./configure --prefix=${CMAKE_CURRENT_BINARY_DIR}/Run
  BUILD_COMMAND make
  INSTALL_COMMAND make install
  BUILD_IN_SOURCE 1
)
ENDIF(UNIX)
