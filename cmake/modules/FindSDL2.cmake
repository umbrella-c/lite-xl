# FindFreetype - attempts to locate the freetype rendering library.
#
# This module defines the following variables (on success):
# SDL2_INCLUDE_DIRS - where to find SDL.h
# SDL2_LIBRARY - the name of the library
# SDL2_FOUND - if the library was successfully located
#
# It is trying a few standard installation locations, but can be customized
# with the following variables:
# SDL2_ROOT - root directory of a freetype installation
# Headers are expected to be found in:
# <SDL2_ROOT>/include/SDL.h
# This variable can either be a cmake or environment
# variable. Note however that changing the value
# of the environment varible will NOT result in
# re-running the header search and therefore NOT
# adjust the variables set by this module.
#=============================================================================
# default search dirs

SET(_SDL2_HEADER_SEARCH_DIRS
"/usr/include"
"/usr/local/include"
"${CMAKE_SOURCE_DIR}/includes" )
set(_SDL2_LIB_SEARCH_DIRS
"/usr/lib"
"/usr/local/lib"
"${CMAKE_SOURCE_DIR}/lib" )

# check environment variable
SET(_SDL2_ENV_ROOT_DIR "$ENV{SDL2_ROOT}")
IF(NOT SDL2_ROOT AND _SDL2_ENV_ROOT_DIR)
	SET(SDL2_ROOT "${_SDL2_ENV_ROOT_DIR}")
ENDIF(NOT SDL2_ROOT AND _SDL2_ENV_ROOT_DIR)

# put user specified location at beginning of search
IF(SDL2_ROOT)
	list( INSERT _SDL2_HEADER_SEARCH_DIRS 0 "${SDL2_ROOT}/include" )
	list( INSERT _SDL2_LIB_SEARCH_DIRS 0 "${SDL2_ROOT}/lib" )
ENDIF(SDL2_ROOT)

# Search for the header
FIND_PATH(SDL2_INCLUDE_DIR "SDL.h"
PATHS ${_SDL2_HEADER_SEARCH_DIRS}
PATH_SUFFIXES "SDL2" )

# Search for the library
FIND_LIBRARY(SDL2_LIBRARY NAMES libSDL2 SDL2
PATHS ${_SDL2_LIB_SEARCH_DIRS} )
INCLUDE(FindPackageHandleStandardArgs)
FIND_PACKAGE_HANDLE_STANDARD_ARGS(SDL2 DEFAULT_MSG
SDL2_LIBRARY SDL2_INCLUDE_DIR)
