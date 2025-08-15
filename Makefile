# Compiler & Flags
CXX := clang++
CXXFLAGS := -std=c++11 -Wall -g

# SRC_DIR = src/1.getting_started/1.1.hello_window
# SRC_DIR = src/1.getting_started/2.1.triangle
# SRC_DIR = src/1.getting_started/2.2.triangle_indexed
# SRC_DIR = src/1.getting_started/2.3.triangle_exercise1
# SRC_DIR = src/1.getting_started/2.4.triangle_exercise2
# SRC_DIR = src/1.getting_started/2.5.triangle_exercise3
# SRC_DIR = src/1.getting_started/3.1.shader_uniform
# SRC_DIR = src/1.getting_started/3.2.shader_interpolation
# SRC_DIR = src/1.getting_started/3.3.shader_class
# SRC_DIR = src/1.getting_started/3.5.shader_exercise2
# SRC_DIR = src/1.getting_started/3.6.shader_exercise3
# SRC_DIR = src/1.getting_started/4.1.texture
# SRC_DIR = src/1.getting_started/4.2.texture_combined
# SRC_DIR = src/1.getting_started/4.4.texture_exercise2
# SRC_DIR = src/1.getting_started/4.5.texture_exercise3
# SRC_DIR = src/1.getting_started/4.6.texture_exercise4
# SRC_DIR = src/1.getting_started/5.1.transformations
# SRC_DIR = src/1.getting_started/5.2.transformations_exercise2
# SRC_DIR = src/1.getting_started/6.1.coordinate_systems
# SRC_DIR = src/1.getting_started/6.2.coordinate_systems_depth
# SRC_DIR = src/1.getting_started/6.3.coordinate_systems_multiple
# SRC_DIR = src/1.getting_started/7.1.camera_circle
# SRC_DIR = src/1.getting_started/7.2.camera_keyboard_dt
# SRC_DIR = src/1.getting_started/7.3.camera_mouse_zoom
# SRC_DIR = src/1.getting_started/7.4.camera_class
# SRC_DIR = src/2.lighting/1.color
# SRC_DIR = src/2.lighting/2.1.basic_lighting_diffuse
# SRC_DIR = src/2.lighting/2.2.basic_lighting_specular
# SRC_DIR = src/2.lighting/2.3.basic_lighting_exercise1
# SRC_DIR = src/2.lighting/3.1.materials
# SRC_DIR = src/2.lighting/4.1.lighting_maps_diffuse_map
# SRC_DIR = src/2.lighting/4.2.lighting_maps_specular_map
# SRC_DIR = src/2.lighting/4.3.lighting_maps_exercise2
SRC_DIR = src/2.lighting/4.4.lighting_maps_exercise4
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
