#------- Regular build configuration makefile -------#
# Tool definitions
CC = arm-none-eabi-gcc
MACH = cortex-m4

# Build settings
SRC_DIR = ./src
TEST_DIR = ./tests
BUILD_DIR = .
BUILD_NAME = app.elf
BUILD_NAME_SEMIHOSTING = app_sh.elf

# Search path for header files
# We want to include a header file in our main.c that is not in the same directory as main.c
# So, we have to instruct the compiler on where to find the header file using -I
CFLAGS += -I $(SRC_DIR)/drivers/inc
CFLAGS += -std=gnu11 -O0
CFLAGS += -mfloat-abi=soft # Needed to tell compiler to generate opcodes for either a hardware FPU or opcodes from software libraries
CFLAGS += -mcpu=$(MACH) -mthumb
# Last line is necessary for cross-compiler to produce appropriate machine code/assembly mnemonics for target architecture

# List module source files
# Wildcard symbol (%, *, etc) expansion happens automatically in rules, but wildcard expansion does not normally take place when a variable is set, or inside the arguments of a function. 
# If you want to do wildcard expansion in such places, you need to use the wildcard function, like this:
# $(wildcard pattern…)
CSOURCES = $(SRC_DIR)/001led_toggle.c
CSOURCES += $(SRC_DIR)/startup_stm32f407vgtx.c
#CSOURCES += $(SRC_DIR)/syscalls.c
CSOURCES += $(wildcard $(SRC_DIR)/drivers/src/*.c)
# $(wildcard $(SRC_DIR)/.../*.c) effectively expands into all .c files (source files) in the source directory

# Compiler flags
CFLAGS += -Wall
CFLAGS += -g -Wstrict-prototypes -Wextra -Werror -Wshadow -Wswitch-default # ADDED 1/5/25 BY NGB TO MIMIC BEHAVIOR OF CPPUTEST COMPILATION********************************************************************************************
CFLAGS += -Wswitch-enum -Wconversion -Wno-long-long -pedantic-errors -Wsign-conversion # ADDED 1/5/25 BY NGB TO MIMIC BEHAVIOR OF CPPUTEST COMPILATION********************************************************************************************

# Linker flags
# Because we are using newlib, newlib nano, semihosting, etc. - We need to link appropriate GNU ARM toochain .specs file which came with the toolchain download (as well as all the library implementations)
LDFLAGS += -T $(SRC_DIR)/stm32_ls.ld
#LDFLAGS += --specs=nano.specs # ***************NEWLIB NANO ONLY********************************************************************************************
LDFLAGS += --specs=rdimon.specs # ***************SEMIHOSTING + NEWLIB NANO********************************************************************************************
LDFLAGS += -mcpu=$(MACH) -mthumb # Needed to link with standard C library
LDFLAGS += -mfloat-abi=soft # Needed to tell linker to link relevant software libraries to implement floating point operations
LDFLAGS += -Wl,-Map=final.map
# -Map flag is optional linker argument to generate a map file for the final .elf executable. Useful for analyzing/verifying memory locations and more!

# Generate names for output object files (*.o) of each source file 
# Uses built-in make function patsubst "pattern string substitute"  
# syntax: $(patsubst pattern,replacement,text)
# patsubst finds whitespace-separated words in text that match pattern and replaces them with replacement
COBJECTS += $(patsubst %.c, %.o, $(CSOURCES))

# Default rule: build application
.PHONY: all
all : $(BUILD_NAME)

# Build semihosting-enabled application
.PHONY: semihosting
semihosting : $(BUILD_NAME_SEMIHOSTING)

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
	$(CC) $(LDFLAGS) $(COBJECTS) -o $(BUILD_DIR)/$(BUILD_NAME)

# Build semihosting-enabled target application
$(BUILD_NAME_SEMIHOSTING) : $(COBJECTS)
	$(CC) $(LDFLAGS) $(filter-out $(SRC_DIR)/syscalls.o,$(COBJECTS)) -o $(BUILD_DIR)/$(BUILD_NAME_SEMIHOSTING)
# Filtering out the syscalls.o file that implements low-level system calls. This conflicts with the semihosting library - it already implements these
# Uses built-in make function filter-out

# Remove any object files (Uses BASH command rm)
.PHONY: clean
clean:
	rm -f $(COBJECTS) $(BUILD_NAME) $(BUILD_NAME_SEMIHOSTING)
# -f flag = Do not prompt user before removing files

# Run tests from home directory of project
.PHONY: test
test:
	make -C $(TEST_DIR)

#clean test directories of any object files, etc.
.PHONY: test_clean
test_clean:
	make -C $(TEST_DIR) clean

#Run OpenOCD with our board config file
.PHONY: load
load:
	openocd -f /usr/share/openocd/scripts/board/stm32f4discovery.cfg
