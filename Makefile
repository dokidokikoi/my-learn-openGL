# Compiler & Flags
CXX := clang++
CXXFLAGS := -std=c++11 -Wall -g

# SRC_DIR = src/1.getting_started/1.1.hello_window
# SRC_DIR = src/1.getting_started/2.1.triangle
# SRC_DIR = src/1.getting_started/2.2.triangle_indexed
# SRC_DIR = src/1.getting_started/2.3.triangle_exercise1
# SRC_DIR = src/1.getting_started/2.4.triangle_exercise2
# SRC_DIR = src/1.getting_started/2.5.triangle_exercise3
SRC_DIR = src/1.getting_started/3.1.shader_uniform
OBJ_DIR = $(SRC_DIR)/build
BIN = main

# Include directories
INCLUDES := \
	-Ideps/glad/include \
	-Ideps/glfw/include \
	-Iinclude

# Library directories and frameworks (for macOS)
LDFLAGS := \
	-Ldeps/glfw/build/src -lglfw3 \
	-framework OpenGL \
	-framework Cocoa \
	-framework IOKit \
	-framework CoreVideo

SRCS := $(wildcard $(SRC_DIR)/*.cpp) 
OBJS := $(patsubst $(SRC_DIR)/%.cpp,$(OBJ_DIR)/%.o,$(SRCS))

# Rule: default = build all demos
.PHONY: all clean 

all: $(BIN)

$(BIN): $(OBJS) $(OBJ_DIR)/glad.o
	$(CXX) $(CXXFLAGS) $(INCLUDES) $(LDFLAGS) -o $@ $^

$(OBJ_DIR)/%.o: $(SRC_DIR)/%.cpp 
	@echo $(BIN)
	@mkdir -p $(OBJ_DIR)
	$(CXX) $(CXXFLAGS) $(INCLUDES) -c $< -o $@

$(OBJ_DIR)/glad.o: deps/glad/src/glad.c
	$(CXX) $(CXXFLAGS) $(INCLUDES) -c $< -o $@


test:
	@echo $(BIN)

# Clean everything
clean:
	@echo "Cleaning..."
	@rm -f $(OBJ_DIR)/*
