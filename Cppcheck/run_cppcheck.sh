#!/bin/bash

OUTPUT_FILE_NAME="cppcheck_output.xml"

echo "Traversing to correct directory..."
cd ./include/simpleGraphs

echo "Running Cppcheck..."
cppcheck --enable=all --xml --xml-version=2 simpleGraphs/simpleGraphs.hpp 2>$OUTPUT_FILE_NAME

echo 'Check report in ${OUTPUT_FILE_NAME}'

