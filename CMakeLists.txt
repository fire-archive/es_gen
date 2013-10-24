# Build es_core

cmake_minimum_required(VERSION 2.8)

project(es_gen)

find_package(Git)
if(NOT GIT_FOUND)
  message(ERROR "Cannot find git. Git is required for building")
endif()

find_package(Hg)
if(NOT HG_FOUND)
  message(ERROR "Cannot find Mercurial. Mercurial is required for building")
endif()

include( ExternalProject )

include( ${CMAKE_SOURCE_DIR}/CMake/External-Ogredeps.cmake )
include( ${CMAKE_SOURCE_DIR}/CMake/External-Ogre.cmake )
include( ${CMAKE_SOURCE_DIR}/CMake/External-Zmq.cmake )
include( ${CMAKE_SOURCE_DIR}/CMake/External-Czmq.cmake )
include( ${CMAKE_SOURCE_DIR}/CMake/External-Sdl.cmake )
include( ${CMAKE_SOURCE_DIR}/CMake/External-es_core.cmake )
