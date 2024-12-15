# Analysis of project 'SimpleGraphs'

This repository contains analysis of project SimpleGraphs, it has been made as part of course `Software Verification` course which is part of Master studies on Faculty of Mathematics in Belgrade. 

## Description of the project on which analysis has been done

The project represents a small, _header-only_ library implemented in _C++_, designed for creating and executing various graph algorithms. The primary goal of this library is to provide flexibility in graph handling, allowing nodes and edges to contain different types of data. All algorithms are implemented generically to support a wide range of use cases. Additionally, a key objective is to make the library easy to understand and use.

Project source code - [**Link to repo** (_main grana_)](https://github.com/JovanDjordjevic/SimpleGraphs)

Commit hash : **_af10ed9cee6de73768b772fab3e6829e7dd52026_**

## Basic analysis info

### Applied tools 
- Static analysis 
    - _ClangAnalyzer_
    - _Cppcheck_ 
- Valgrind tools 
    - _MemCheck_
    - _Massif_ 
- Code formater
    - _ClangFormat_

### Reproducing the analysis 

Each tool has its own script that can reproduce the results that are contained inside directories the scripts should be placed inside [Root of SimpleGraphs](./SimpleGraphs/) and run from there to produce the reports. 
Some scripts need to build the tests and run them to analyze the library whole some tests do not.

## Summary

I've thoroughly analyzed the project _**SimpleGraphs**_ with all of the tools above and i have not found any major bug or some implementation error. The library is well writen without any bug coming up on my error checks.

Detailed reports for each of the tools are contained in the file [ProjectAnalysisReport.md](./ProjectAnalysisReport.md).

## Author

**_Pavle Vlajković 1071/2024_**
