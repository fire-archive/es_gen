ExternalProject_Add(Zmq
  GIT_REPOSITORY "https://github.com/zeromq/libzmq.git"
  PATCH_COMMAND git apply < ${CMAKE_CURRENT_SOURCE_DIR}/CMake/zmq-Cmake.patch
  PREFIX "${CMAKE_CURRENT_BINARY_DIR}/Tools/libzmq"
  CMAKE_ARGS -DCMAKE_INSTALL_PREFIX=${CMAKE_CURRENT_BINARY_DIR}/Run -DBUILD_TESTING=0
)