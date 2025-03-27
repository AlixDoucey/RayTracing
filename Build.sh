#!/bin/bash

# Default build type is Debug
BUILD_TYPE="Debug"

# Detect operating system
IS_WINDOWS=false
if [[ "$OSTYPE" == "msys" || "$OSTYPE" == "win32" || "$OSTYPE" == "cygwin" ]]; then
	IS_WINDOWS=true
	echo "Detected Windows operating system"
else
	echo "Detected Linux/Unix operating system"
fi

# Parse command line arguments
while [[ $# -gt 0 ]]; do
	key="$1"
	case $key in
	-r | --release)
		BUILD_TYPE="Release"
		shift
		;;
	-d | --debug)
		BUILD_TYPE="Debug"
		shift
		;;
	*)
		# Unknown option
		echo "Unknown option: $1"
		echo "Usage: $0 [-r|--release] [-d|--debug]"
		exit 1
		;;
	esac
done

# Create build directory if it doesn't exist
if [ ! -d "build" ]; then
	mkdir build
	echo "Created build directory"
fi

# Navigate to build directory
cd build

# Configure with CMake and build based on the detected OS
echo "Configuring for $BUILD_TYPE build..."

if [ "$IS_WINDOWS" = true ]; then
	# Windows configuration with Unix Makefiles
	cmake -G "Unix Makefiles" -DCMAKE_BUILD_TYPE=$BUILD_TYPE ..

	# Build the project with make
	echo "Building with make (Windows)..."
	make
else
	# Linux configuration with Ninja
	cmake -G Ninja -DCMAKE_BUILD_TYPE=$BUILD_TYPE ..

	# Build the project with ninja
	echo "Building with ninja (Linux)..."
	ninja
fi

# Store the exit code
BUILD_RESULT=$?

# Return to the root directory
cd ..

# Check if build was successful
if [ $BUILD_RESULT -eq 0 ]; then
	echo "Build successful! ($BUILD_TYPE mode)"
else
	echo "Build failed!"
	exit 1
fi
