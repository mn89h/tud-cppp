# $<	the first dependency
# $@	name of the target
# $+	list of all dependencies
# $^	list of all dependencies (unique elements)

# delete the default suffixes (disable implicit rules)
.SUFFIXES:
# PHONY targets (targets that do not represent a file)
.PHONY: clean all doxygen clean_doxygen clean_all

# compiler options
CC		:= g++
# -g			add debugging symbols to the binary executable file
# -O0			deactivate optimizations
# -Wall			show reasonable warnings
# -Wextra		show more warnings
# -MMD -MP		generate dependencies to header files so that make recognizes changes to header files,
#				which otherwise do not appear explicitly in any rule
# -std=c++11	enable C++11
CFLAGS	:= -g -O0 -Wall -Wextra -MMD -MP -std=c++11
# build directory (to store the executable the .o and .d files)
BUILD	:= build

# source code
BINARY	:= $(BUILD)/main.exe
SOURCES	:= $(wildcard *.cpp)
OBJECTS	:= $(patsubst %.cpp, $(BUILD)/%.o, $(SOURCES))
DEPEND	:= $(patsubst %.cpp, $(BUILD)/%.d, $(SOURCES))

# default target (create the binary executable file)
all: $(BINARY)

# include dependencies to detect header file changes (this creates new targets!)
-include $(DEPEND)

# create the binary executable file
$(BINARY): $(OBJECTS)
	$(CC) -o $(BINARY) $^

# create an object file from a source file
$(BUILD)/%.o: %.cpp
	mkdir -p $(dir $@)
	$(CC) $(CFLAGS) -c $< -o $@

clean:
	rm -rf $(BUILD)

doxygen:
	if [ ! -e Doxyfile ]; then ( doxygen -g ) fi
	doxygen

clean_doxygen:
	rm -rf html latex Doxyfile

clean_all: clean clean_doxygen
