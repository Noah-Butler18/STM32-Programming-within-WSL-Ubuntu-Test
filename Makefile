#------- Regular build configuration makefile -------#
# Tool definitions
CC = arm-none-eabi-gcc
MACH = cortex-m4

# Build settings
SRC_DIR = ./src
TEST_DIR = ./tests
BUILD_DIR = .
BUILD_NAME = app.elf

# Search path for header files
# We want to include a header file in our main.c that is not in the same directory as main.c
# So, we have to instruct the compiler on where to find the header file using -I
CFLAGS += -I $(SRC_DIR)/drivers/inc
CFLAGS += -std=gnu11 -O0
CFLAGS += -mcpu=$(MACH) -mthumb
# Last line is necessary for cross-compiler to produce appropriate machine code/assembly mnemonics for target architecture

# List module source files
# Wildcard symbol (%, *, etc) expansion happens automatically in rules, but wildcard expansion does not normally take place when a variable is set, or inside the arguments of a function. 
# If you want to do wildcard expansion in such places, you need to use the wildcard function, like this:
# $(wildcard pattern…)
CSOURCES = $(SRC_DIR)/001led_toggle.c
CSOURCES += $(wildcard $(SRC_DIR)/drivers/src/*.c)
# $(wildcard $(SRC_DIR)/.../*.c) effectively expands into all .c files (source files) in the source directory

# Compiler flags
CFLAGS += -Wall

# Linker flags
LDFLAGS += 

# Generate names for output object files (*.o) of each source file 
# Uses built-in make function patsubst "pattern string substitute"  
# syntax: $(patsubst pattern,replacement,text)
# patsubst finds whitespace-separated words in text that match pattern and replaces them with replacement
COBJECTS += $(patsubst %.c, %.o, $(CSOURCES))

# Default rule: build application
.PHONY: all
all : $(BUILD_NAME)

# Build components (individual object files)
# The first line here is an expansion, not a rule. It takes the *.o files in CSOURCES and expands them out to both .o and .c files for the following recipe
# This is required because without this line, make would not be able to find any .c files (they are in src, not the local directory with the makefile)
$(COBJECTS) : %.o : %.c
%.o : %.c
	$(CC) $(CFLAGS) -c $< -o $@
# No build directory is specified for this recipe, it will be default put the .o files in the same directory where the .c files reside
# -c flag = gcc flag that gets parsed by the bash shell. Tells compiler to stop at object file stage, and to not link the files.
# 	-c is needed for running unit tests within each .o file later; each source file should build independently 
# $< = first symbol in prerequisite
# $@ = target of the rule, in this case it would be %.o

# Build the target application
.PHONY: $(BUILD_NAME)
$(BUILD_NAME) : $(COBJECTS)
	$(CC) $(COBJECTS) -o $(BUILD_DIR)/$(BUILD_NAME) $(LDFLAGS)

# Remove any object files (Uses BASH command rm)
.PHONY: clean
clean:
	rm -f $(COBJECTS) $(BUILD_NAME)
# -f flag = Do not prompt user before removing files

# Run tests from home directory of project
.PHONY: test
test:
	make -C $(TEST_DIR)

#clean test directories of any object files, etc.
.PHONY: test_clean
test_clean:
	make -C $(TEST_DIR) clean