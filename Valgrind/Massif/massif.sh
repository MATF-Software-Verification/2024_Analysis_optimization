#!/bin/bash

OUTPUT_LOG_FILE_NAME="valgrind-massif-out.txt"

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

echo "Running Massif..."
valgrind --tool=massif --log-file=${OUTPUT_LOG_FILE_NAME} 

echo "Report file has been generated '$OUTPUT_LOG_FILE_NAME' as well as file containing analysis massif-out.<id>" 

echo "Use ms_print to see the analysis of the massif-out.<id> file"