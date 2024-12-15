# Analysis of SimpleGraphs library 

## Tool overview 

The tools that were used in this analysis are as follows: 
- ClangAnalyzer
- ClangFormat
- Massif 
- MemCheck
- Cppcheck


## Summary of each check 

### ClangAnalyzer 

#### Brief summary of the tool 

Clang Analyzer is a static analysis tool for C, C++, and Objective-C that detects bugs by analyzing code paths without executing the program. It identifies issues like null pointer dereferences, memory leaks, and uninitialized variables. 

#### Key results of analysis 

The analyzer did not find any bugs contained inside the library itself, the only bugs it found were inside of tests and they were **Dead Initializations**. Since those were not directly tied to main library i concluded that there was no errors inside the library.

`Dead initialization` - refers to variables that are initialized (assigned a value) but the assigned value is never used before the variable is re-initialized or goes out of scope. This can indicate unnecessary computations, wasted resources, or potential issues in the code's logic.


The results of the scan are contained inside [report folder](./ClangAnalyzer/run-clangAnalyzer.sh).

#### Running the analyzer 

To run the analysis that i've run execute the [script](./ClangAnalyzer/run-clangAnalyzer.sh), i've noticed that running the analyzer was already built in to [Cmake file](./SimpleGraphs/CMakeLists.txt) so i've just called it from there. 

---