# This is a global makefile that can run on ALL tests in our tests subdirectory

# Define test component directories
# Uses dir function with the following syntax in make:
# $(dir names…)
# dir extracts the directory-part of each file name in names.
TEST_DIRS = $(dir $(wildcard */))
# $(wildcard */) effectively expands to all subdirectories of the current directory that the Makefile is in. i.e., ~/unittest_practice/tests/(whatever folders are in here)

# Default rule: run all tests
.PHONY: all $(TEST_DIRS)
all: $(TEST_DIRS)

# Run tests
$(TEST_DIRS):
	make -C $@
# -C moves into each directory in TEST_DIRS before running make with the particular makefile found in that test directory

# Clean tests
.PHONY: clean
clean: 
	$(foreach DIR, $(TEST_DIRS), make -C $(DIR) clean;)
# refer to 8.6 The foreach Function for more information
# Here, "DIR" is nothing but a variable that takes on each value of the expanded "TEST_DIRS", and gets substituted into "make -C $(DIR) clean" until there are no more TEST_DIRS.
# What this is essentially doing is executing clean for every directory with a test case in it, moving from directory to directory until there are no more
# make -C average/ clean
# make -C kv_store/ clean