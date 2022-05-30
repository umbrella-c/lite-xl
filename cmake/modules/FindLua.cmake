# FindFreetype - attempts to locate the freetype rendering library.
#
# This module defines the following variables (on success):
# LUA_INCLUDE_DIRS - where to find lua.h
# LUA_LIBRARY - the name of the library
# LUA_FOUND - if the library was successfully located
#
# It is trying a few standard installation locations, but can be customized
# with the following variables:
# LUA_ROOT - root directory of a freetype installation
# Headers are expected to be found in:
# <LUA_ROOT>/include/lua.h
# This variable can either be a cmake or environment
# variable. Note however that changing the value
# of the environment varible will NOT result in
# re-running the header search and therefore NOT
# adjust the variables set by this module.
#=============================================================================
# default search dirs

SET(_LUA_HEADER_SEARCH_DIRS
"/usr/include"
"/usr/local/include"
"${CMAKE_SOURCE_DIR}/includes" )
set(_LUA_LIB_SEARCH_DIRS
"/usr/lib"
"/usr/local/lib"
"${CMAKE_SOURCE_DIR}/lib" )

# check environment variable
SET(_LUA_ENV_ROOT_DIR "$ENV{LUA_ROOT}")
IF(NOT LUA_ROOT AND _LUA_ENV_ROOT_DIR)
	SET(LUA_ROOT "${_LUA_ENV_ROOT_DIR}")
ENDIF(NOT LUA_ROOT AND _LUA_ENV_ROOT_DIR)

# put user specified location at beginning of search
IF(LUA_ROOT)
	list( INSERT _LUA_HEADER_SEARCH_DIRS 0 "${LUA_ROOT}/include" )
	list( INSERT _LUA_LIB_SEARCH_DIRS 0 "${LUA_ROOT}/lib" )
ENDIF(LUA_ROOT)

# Search for the header
FIND_PATH(LUA_INCLUDE_DIR "lua.h"
PATHS ${_LUA_HEADER_SEARCH_DIRS}
PATH_SUFFIXES "lua" )

# Search for the library
FIND_LIBRARY(LUA_LIBRARY NAMES liblua lua
PATHS ${_LUA_LIB_SEARCH_DIRS} )
INCLUDE(FindPackageHandleStandardArgs)
FIND_PACKAGE_HANDLE_STANDARD_ARGS(Lua DEFAULT_MSG
LUA_LIBRARY LUA_INCLUDE_DIR)
