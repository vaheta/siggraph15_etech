# CMAKE generated file: DO NOT EDIT!
# Generated by "Unix Makefiles" Generator, CMake Version 2.8

#=============================================================================
# Special targets provided by cmake.

# Disable implicit rules so canonical targets will work.
.SUFFIXES:

# Remove some rules from gmake that .SUFFIXES does not remove.
SUFFIXES =

.SUFFIXES: .hpux_make_needs_suffix_list

# Suppress display of executed commands.
$(VERBOSE).SILENT:

# A target that is always out of date.
cmake_force:
.PHONY : cmake_force

#=============================================================================
# Set environment variables for the build.

# The shell in which to execute make rules.
SHELL = /bin/sh

# The CMake executable.
CMAKE_COMMAND = /usr/bin/cmake

# The command to remove a file.
RM = /usr/bin/cmake -E remove -f

# Escaping for special characters.
EQUALS = =

# The top-level source directory on which CMake was run.
CMAKE_SOURCE_DIR = /home/vaheta/Desktop/siggraph/Servo/depth

# The top-level build directory on which CMake was run.
CMAKE_BINARY_DIR = /home/vaheta/Desktop/siggraph/Servo/depth

# Include any dependencies generated for this target.
include CMakeFiles/depth.dir/depend.make

# Include the progress variables for this target.
include CMakeFiles/depth.dir/progress.make

# Include the compile flags for this target's objects.
include CMakeFiles/depth.dir/flags.make

CMakeFiles/depth.dir/openni_capture.cpp.o: CMakeFiles/depth.dir/flags.make
CMakeFiles/depth.dir/openni_capture.cpp.o: openni_capture.cpp
	$(CMAKE_COMMAND) -E cmake_progress_report /home/vaheta/Desktop/siggraph/Servo/depth/CMakeFiles $(CMAKE_PROGRESS_1)
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Building CXX object CMakeFiles/depth.dir/openni_capture.cpp.o"
	/usr/bin/c++   $(CXX_DEFINES) $(CXX_FLAGS) -o CMakeFiles/depth.dir/openni_capture.cpp.o -c /home/vaheta/Desktop/siggraph/Servo/depth/openni_capture.cpp

CMakeFiles/depth.dir/openni_capture.cpp.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing CXX source to CMakeFiles/depth.dir/openni_capture.cpp.i"
	/usr/bin/c++  $(CXX_DEFINES) $(CXX_FLAGS) -E /home/vaheta/Desktop/siggraph/Servo/depth/openni_capture.cpp > CMakeFiles/depth.dir/openni_capture.cpp.i

CMakeFiles/depth.dir/openni_capture.cpp.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling CXX source to assembly CMakeFiles/depth.dir/openni_capture.cpp.s"
	/usr/bin/c++  $(CXX_DEFINES) $(CXX_FLAGS) -S /home/vaheta/Desktop/siggraph/Servo/depth/openni_capture.cpp -o CMakeFiles/depth.dir/openni_capture.cpp.s

CMakeFiles/depth.dir/openni_capture.cpp.o.requires:
.PHONY : CMakeFiles/depth.dir/openni_capture.cpp.o.requires

CMakeFiles/depth.dir/openni_capture.cpp.o.provides: CMakeFiles/depth.dir/openni_capture.cpp.o.requires
	$(MAKE) -f CMakeFiles/depth.dir/build.make CMakeFiles/depth.dir/openni_capture.cpp.o.provides.build
.PHONY : CMakeFiles/depth.dir/openni_capture.cpp.o.provides

CMakeFiles/depth.dir/openni_capture.cpp.o.provides.build: CMakeFiles/depth.dir/openni_capture.cpp.o

# Object files for target depth
depth_OBJECTS = \
"CMakeFiles/depth.dir/openni_capture.cpp.o"

# External object files for target depth
depth_EXTERNAL_OBJECTS =

depth: CMakeFiles/depth.dir/openni_capture.cpp.o
depth: CMakeFiles/depth.dir/build.make
depth: /usr/local/lib/libopencv_videostab.so.2.4.10
depth: /usr/local/lib/libopencv_video.so.2.4.10
depth: /usr/local/lib/libopencv_ts.a
depth: /usr/local/lib/libopencv_superres.so.2.4.10
depth: /usr/local/lib/libopencv_stitching.so.2.4.10
depth: /usr/local/lib/libopencv_photo.so.2.4.10
depth: /usr/local/lib/libopencv_ocl.so.2.4.10
depth: /usr/local/lib/libopencv_objdetect.so.2.4.10
depth: /usr/local/lib/libopencv_nonfree.so.2.4.10
depth: /usr/local/lib/libopencv_ml.so.2.4.10
depth: /usr/local/lib/libopencv_legacy.so.2.4.10
depth: /usr/local/lib/libopencv_imgproc.so.2.4.10
depth: /usr/local/lib/libopencv_highgui.so.2.4.10
depth: /usr/local/lib/libopencv_gpu.so.2.4.10
depth: /usr/local/lib/libopencv_flann.so.2.4.10
depth: /usr/local/lib/libopencv_features2d.so.2.4.10
depth: /usr/local/lib/libopencv_core.so.2.4.10
depth: /usr/local/lib/libopencv_contrib.so.2.4.10
depth: /usr/local/lib/libopencv_calib3d.so.2.4.10
depth: /usr/local/lib/libopencv_nonfree.so.2.4.10
depth: /usr/local/lib/libopencv_ocl.so.2.4.10
depth: /usr/local/lib/libopencv_gpu.so.2.4.10
depth: /usr/local/lib/libopencv_photo.so.2.4.10
depth: /usr/local/lib/libopencv_objdetect.so.2.4.10
depth: /usr/local/lib/libopencv_legacy.so.2.4.10
depth: /usr/local/lib/libopencv_video.so.2.4.10
depth: /usr/local/lib/libopencv_ml.so.2.4.10
depth: /usr/local/lib/libopencv_calib3d.so.2.4.10
depth: /usr/local/lib/libopencv_features2d.so.2.4.10
depth: /usr/local/lib/libopencv_highgui.so.2.4.10
depth: /usr/local/lib/libopencv_imgproc.so.2.4.10
depth: /usr/local/lib/libopencv_flann.so.2.4.10
depth: /usr/local/lib/libopencv_core.so.2.4.10
depth: CMakeFiles/depth.dir/link.txt
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --red --bold "Linking CXX executable depth"
	$(CMAKE_COMMAND) -E cmake_link_script CMakeFiles/depth.dir/link.txt --verbose=$(VERBOSE)

# Rule to build all files generated by this target.
CMakeFiles/depth.dir/build: depth
.PHONY : CMakeFiles/depth.dir/build

CMakeFiles/depth.dir/requires: CMakeFiles/depth.dir/openni_capture.cpp.o.requires
.PHONY : CMakeFiles/depth.dir/requires

CMakeFiles/depth.dir/clean:
	$(CMAKE_COMMAND) -P CMakeFiles/depth.dir/cmake_clean.cmake
.PHONY : CMakeFiles/depth.dir/clean

CMakeFiles/depth.dir/depend:
	cd /home/vaheta/Desktop/siggraph/Servo/depth && $(CMAKE_COMMAND) -E cmake_depends "Unix Makefiles" /home/vaheta/Desktop/siggraph/Servo/depth /home/vaheta/Desktop/siggraph/Servo/depth /home/vaheta/Desktop/siggraph/Servo/depth /home/vaheta/Desktop/siggraph/Servo/depth /home/vaheta/Desktop/siggraph/Servo/depth/CMakeFiles/depth.dir/DependInfo.cmake --color=$(COLOR)
.PHONY : CMakeFiles/depth.dir/depend

