# Name of component under test
# (NAMING THE COMPONENT IS REQUIRED BY THE CPUUTEST MAKEFILE WORKER)
# Always name your component after the directory that the unit test is in
COMPONENT_NAME = kv_store

# Dynamically generate absolute paths
# CppUTest plays nicer if we supply it with absolute paths (no ".", "..", "//", etc in path)
# From https://matheusmbar.com/bugfree-robot/2019/04/05/makefile-first-test.html
MAKEFILE_DIR = $(dir $(realpath $(firstword $(MAKEFILE_LIST))))
PROJECT_DIR = $(realpath $(MAKEFILE_DIR)../..)
SRC_DIR = $(PROJECT_DIR)/src
TEST_DIR = $(PROJECT_DIR)/tests
# "MAKEFILE_LIST" is a make special variable that contains the name of each makefile that is parsed by make
# What the "PROJECT_DIR" line is doing is assigning the PROJECT_DIR variable with the grandparent directory of the current working directory of this particular makefile using the "../.." construct
#	i.e., if the Makefile is in :~/unittest_practice/tests/average, then the PROJECT_DIR is ~/unittest_practice

# Set home directory of CppUTest
CPPUTEST_HOME ?= $(PROJECT_DIR)/tools/cpputest

# Source and include files for component under test
# This is why naming helps a lot, we should name our component the same as the directory of the source file of the component
INCLUDE_DIRS = $(SRC_DIR)/$(COMPONENT_NAME)
SRC_DIRS = $(SRC_DIR)/$(COMPONENT_NAME)

# Includes CppUTest header files
INCLUDE_DIRS += -I $(CPPUTEST_HOME)/include

# Directories containing the source test .cpp files
# Again, COMPONENT_NAME naming helps here
TEST_SRC_DIRS = $(TEST_DIR)/$(COMPONENT_NAME)

# Run MakefileWorker.mk with the variables set in this Makefile
include $(CPPUTEST_HOME)/build/MakefileWorker.mk 