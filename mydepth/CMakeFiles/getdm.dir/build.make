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
CMAKE_SOURCE_DIR = /home/vaheta/Desktop/siggraph/Servo/mydepth

# The top-level build directory on which CMake was run.
CMAKE_BINARY_DIR = /home/vaheta/Desktop/siggraph/Servo/mydepth

# Include any dependencies generated for this target.
include CMakeFiles/getdm.dir/depend.make

# Include the progress variables for this target.
include CMakeFiles/getdm.dir/progress.make

# Include the compile flags for this target's objects.
include CMakeFiles/getdm.dir/flags.make

CMakeFiles/getdm.dir/getdm.cpp.o: CMakeFiles/getdm.dir/flags.make
CMakeFiles/getdm.dir/getdm.cpp.o: getdm.cpp
	$(CMAKE_COMMAND) -E cmake_progress_report /home/vaheta/Desktop/siggraph/Servo/mydepth/CMakeFiles $(CMAKE_PROGRESS_1)
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Building CXX object CMakeFiles/getdm.dir/getdm.cpp.o"
	/usr/bin/c++   $(CXX_DEFINES) $(CXX_FLAGS) -o CMakeFiles/getdm.dir/getdm.cpp.o -c /home/vaheta/Desktop/siggraph/Servo/mydepth/getdm.cpp

CMakeFiles/getdm.dir/getdm.cpp.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing CXX source to CMakeFiles/getdm.dir/getdm.cpp.i"
	/usr/bin/c++  $(CXX_DEFINES) $(CXX_FLAGS) -E /home/vaheta/Desktop/siggraph/Servo/mydepth/getdm.cpp > CMakeFiles/getdm.dir/getdm.cpp.i

CMakeFiles/getdm.dir/getdm.cpp.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling CXX source to assembly CMakeFiles/getdm.dir/getdm.cpp.s"
	/usr/bin/c++  $(CXX_DEFINES) $(CXX_FLAGS) -S /home/vaheta/Desktop/siggraph/Servo/mydepth/getdm.cpp -o CMakeFiles/getdm.dir/getdm.cpp.s

CMakeFiles/getdm.dir/getdm.cpp.o.requires:
.PHONY : CMakeFiles/getdm.dir/getdm.cpp.o.requires

CMakeFiles/getdm.dir/getdm.cpp.o.provides: CMakeFiles/getdm.dir/getdm.cpp.o.requires
	$(MAKE) -f CMakeFiles/getdm.dir/build.make CMakeFiles/getdm.dir/getdm.cpp.o.provides.build
.PHONY : CMakeFiles/getdm.dir/getdm.cpp.o.provides

CMakeFiles/getdm.dir/getdm.cpp.o.provides.build: CMakeFiles/getdm.dir/getdm.cpp.o

# Object files for target getdm
getdm_OBJECTS = \
"CMakeFiles/getdm.dir/getdm.cpp.o"

# External object files for target getdm
getdm_EXTERNAL_OBJECTS =

getdm: CMakeFiles/getdm.dir/getdm.cpp.o
getdm: CMakeFiles/getdm.dir/build.make
getdm: /usr/local/lib/libopencv_videostab.so.2.4.10
getdm: /usr/local/lib/libopencv_video.so.2.4.10
getdm: /usr/local/lib/libopencv_ts.a
getdm: /usr/local/lib/libopencv_superres.so.2.4.10
getdm: /usr/local/lib/libopencv_stitching.so.2.4.10
getdm: /usr/local/lib/libopencv_photo.so.2.4.10
getdm: /usr/local/lib/libopencv_ocl.so.2.4.10
getdm: /usr/local/lib/libopencv_objdetect.so.2.4.10
getdm: /usr/local/lib/libopencv_nonfree.so.2.4.10
getdm: /usr/local/lib/libopencv_ml.so.2.4.10
getdm: /usr/local/lib/libopencv_legacy.so.2.4.10
getdm: /usr/local/lib/libopencv_imgproc.so.2.4.10
getdm: /usr/local/lib/libopencv_highgui.so.2.4.10
getdm: /usr/local/lib/libopencv_gpu.so.2.4.10
getdm: /usr/local/lib/libopencv_flann.so.2.4.10
getdm: /usr/local/lib/libopencv_features2d.so.2.4.10
getdm: /usr/local/lib/libopencv_core.so.2.4.10
getdm: /usr/local/lib/libopencv_contrib.so.2.4.10
getdm: /usr/local/lib/libopencv_calib3d.so.2.4.10
getdm: /usr/local/lib/libopencv_nonfree.so.2.4.10
getdm: /usr/local/lib/libopencv_ocl.so.2.4.10
getdm: /usr/local/lib/libopencv_gpu.so.2.4.10
getdm: /usr/local/lib/libopencv_photo.so.2.4.10
getdm: /usr/local/lib/libopencv_objdetect.so.2.4.10
getdm: /usr/local/lib/libopencv_legacy.so.2.4.10
getdm: /usr/local/lib/libopencv_video.so.2.4.10
getdm: /usr/local/lib/libopencv_ml.so.2.4.10
getdm: /usr/local/lib/libopencv_calib3d.so.2.4.10
getdm: /usr/local/lib/libopencv_features2d.so.2.4.10
getdm: /usr/local/lib/libopencv_highgui.so.2.4.10
getdm: /usr/local/lib/libopencv_imgproc.so.2.4.10
getdm: /usr/local/lib/libopencv_flann.so.2.4.10
getdm: /usr/local/lib/libopencv_core.so.2.4.10
getdm: CMakeFiles/getdm.dir/link.txt
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --red --bold "Linking CXX executable getdm"
	$(CMAKE_COMMAND) -E cmake_link_script CMakeFiles/getdm.dir/link.txt --verbose=$(VERBOSE)

# Rule to build all files generated by this target.
CMakeFiles/getdm.dir/build: getdm
.PHONY : CMakeFiles/getdm.dir/build

CMakeFiles/getdm.dir/requires: CMakeFiles/getdm.dir/getdm.cpp.o.requires
.PHONY : CMakeFiles/getdm.dir/requires

CMakeFiles/getdm.dir/clean:
	$(CMAKE_COMMAND) -P CMakeFiles/getdm.dir/cmake_clean.cmake
.PHONY : CMakeFiles/getdm.dir/clean

CMakeFiles/getdm.dir/depend:
	cd /home/vaheta/Desktop/siggraph/Servo/mydepth && $(CMAKE_COMMAND) -E cmake_depends "Unix Makefiles" /home/vaheta/Desktop/siggraph/Servo/mydepth /home/vaheta/Desktop/siggraph/Servo/mydepth /home/vaheta/Desktop/siggraph/Servo/mydepth /home/vaheta/Desktop/siggraph/Servo/mydepth /home/vaheta/Desktop/siggraph/Servo/mydepth/CMakeFiles/getdm.dir/DependInfo.cmake --color=$(COLOR)
.PHONY : CMakeFiles/getdm.dir/depend

