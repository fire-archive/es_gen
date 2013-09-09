# Build es_core

cmake_minimum_required(VERSION 2.8)

project(es_builder)

find_package(Git)
if(NOT GIT_FOUND)
  message(ERROR "Cannot find git. Git is required for building")
endif()

find_package(Hg)
if(NOT HG_FOUND)
  message(ERROR "Cannot find Mercurial. Mercurial is required for building")
endif()

include( ExternalProject )

if( NOT OGREDEPS_LIBRARY )
  include( ${CMAKE_SOURCE_DIR}/CMake/External-Ogredeps.cmake )
  list( APPEND ES_CORE_DEPENDENCIES Ogredeps )
endif()

if( NOT TBB_LIBRARY )
  include( ${CMAKE_SOURCE_DIR}/CMake/External-TBB.cmake )
  list( APPEND ES_CORE_DEPENDENCIES TBB )
endif()

if( NOT OGRE_LIBRARY )
  include( ${CMAKE_SOURCE_DIR}/CMake/External-Ogre.cmake )
  list( APPEND ES_CORE_DEPENDENCIES Ogre )
endif()

if( NOT ZMQ_LIBRARY )
  include( ${CMAKE_SOURCE_DIR}/CMake/External-Zmq.cmake )
  list( APPEND ES_CORE_DEPENDENCIES Zmq )
endif()

if( NOT CZMQ_LIBRARY )
  include( ${CMAKE_SOURCE_DIR}/CMake/External-Czmq.cmake )
  list( APPEND ES_CORE_DEPENDENCIES Czmq )
endif()

if( NOT SDL_LIBRARY )
  include( ${CMAKE_SOURCE_DIR}/CMake/External-Sdl.cmake )
  list( APPEND ES_CORE_DEPENDENCIES Sdl )
endif()


include( ${CMAKE_SOURCE_DIR}/CMake/External-es_core.cmake )
add_dependencies( es_core ES_CORE_DEPENDENCIES) 

set( CMAKE_BUILD_TYPE Release CACHE STRING "Default cmake build type" )
