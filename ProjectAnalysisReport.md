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

`Dead initialization` - refers to variables that are initialized but the assigned value is never used before the variable is re-initialized or goes out of scope. This can indicate unnecessary computations, wasted resources, or potential issues in the code's logic.

The results of the scan are contained inside [report folder](./ClangAnalyzer/run-clangAnalyzer.sh).

#### Running the analyzer 

To run the analysis that i've run execute the [script](./ClangAnalyzer/run-clangAnalyzer.sh), i've noticed that running the analyzer was already built in to [Cmake file](./SimpleGraphs/CMakeLists.txt) so i've just called it from there. 

---

### ClangFormat

#### Brief summary of the tool
 
_**ClangFormat**_ is a tool for automatically formatting C, C++, Java, JavaScript, and other supported source code to _**enforce a consistent coding style**_.
It uses configurable style options, such as LLVM, Google, or custom .clang-format files, to apply uniform indentation, spacing, and alignment.

#### My settings 

I've decided to write a [generator](./ClangFormat/generateStyle) that is able to patch the `Llvm` style format. 
The patches I've added aim to improve code readability. 
But it is possible to change any settings by just adding that setting along with the desired value inside variable ***CONFIG_PATCH***. 
The Python script then generates patched style and applies it to code.

#### Usage

Run the [generator](./ClangFormat/generateStyle) to generate and apply the format to the code.

I've decided to also include small `git pre-commit hook` that will apply ***Lllvm*** style to the code before every single ***commit***

---