#!/bin/bash
 
mkdir build 

cd build 

echo 'Running build...'
cmake -DCMAKE_BUILD_TYPE=Debug ..

make

cd tests 

echo 'Running MemChech...'
valgrind --leak-check=full --track-origins=yes --log-file=valgrind-memcheck-out.tx ./tests 
