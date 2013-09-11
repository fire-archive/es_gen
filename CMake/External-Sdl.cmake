ExternalProject_Add(Sdl
  HG_REPOSITORY "https://hg.libsdl.org/SDL"
  PATCH_COMMAND hg update --clean && git apply --ignore-whitespace < ${CMAKE_CURRENT_SOURCE_DIR}/CMake/SDL-Cmake.patch
  PREFIX "${CMAKE_CURRENT_BINARY_DIR}/Tools/Sdl"
  CMAKE_ARGS -DCMAKE_INSTALL_PREFIX=${CMAKE_BINARY_DIR}/Run/
)
