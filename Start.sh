#!/bin/bash

# Default build type is Debug
BUILD_TYPE="Debug"

# Detect operating system
IS_WINDOWS=false
if [[ "$OSTYPE" == "msys" || "$OSTYPE" == "win32" || "$OSTYPE" == "cygwin" || "$OS" == "Windows_NT" ]]; then
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
	-dist | --dist)
		BUILD_TYPE="Dist"
		shift
		;;
	*)
		# Unknown option
		echo "Unknown option: $1"
		echo "Usage: $0 [-r|--release] [-d|--debug] [-dist|--dist]"
		exit 1
		;;
	esac
done

# Determine executable path based on OS and build type
if [ "$IS_WINDOWS" = true ]; then
	EXE_PATH="build/bin/${BUILD_TYPE}-Windows-x64/RayTracing.exe"
else
	EXE_PATH="build/bin/${BUILD_TYPE}-Linux-x64/RayTracing"
fi

# Check if executable exists
if [ -f "$EXE_PATH" ]; then
	echo "Running RayTracing application (${BUILD_TYPE} mode)..."
	"$EXE_PATH"
else
	echo "Error: Executable not found at expected path: $EXE_PATH"
	echo "Please build the project first."
	exit 1
fi
