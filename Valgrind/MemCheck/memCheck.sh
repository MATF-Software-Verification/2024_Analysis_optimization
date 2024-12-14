#!/bin/bash

# Run this script from root directory

OUTPUT_LOG_FILE_NAME="valgrind-memcheck-out.txt"

if [ ! -d "build" ]; then
    mkdir build 
    cd build 
    echo 'Running build...'
    cmake -DCMAKE_BUILD_TYPE=Debug ..
    make
    cd tests 
else 
    echo 'Traversing to test directory'
    cd ./build/tests 
fi 

echo 'Running MemChech...'
valgrind --leak-check=full --track-origins=yes --log-file=${OUTPUT_LOG_FILE_NAME} ./tests 

echo "Output file has been generated '$OUTPUT_LOG_FILE_NAME'" 