# Analysis of SimpleGraphs library

## Tool overview

The tools that were used in this analysis are as follows:

- ClangAnalyzer
- ClangFormat
- Massif
- MemCheck
- Cppcheck

## Summary of each tool

### [ClangAnalyzer](https://clang-analyzer.llvm.org/)

#### Brief summary of the tool

Clang Analyzer is a static analysis tool for C, C++, and Objective-C that detects bugs by analyzing code paths without executing the program. It identifies issues like null pointer dereferences, memory leaks, and uninitialized variables.

#### Key results of analysis

The analyzer did not find any bugs contained inside the library itself, the only bugs it found were inside of tests and they were **Dead Initializations**. Since those were not directly tied to main library i concluded that there was no errors inside the library.

`Dead initialization` - refers to variables that are initialized but the assigned value is never used before the variable is re-initialized or goes out of scope. This can indicate unnecessary computations, wasted resources, or potential issues in the code's logic.

The results of the scan are contained inside [report folder](./ClangAnalyzer/run-clangAnalyzer.sh).

#### Running the analyzer

To run the analysis that i've run execute the [script](./ClangAnalyzer/run-clangAnalyzer.sh), i've noticed that running the analyzer was already built in to [Cmake file](./SimpleGraphs/CMakeLists.txt) so i've just called it from there.

---

### [ClangFormat](https://clang.llvm.org/docs/ClangFormat.html)

#### Brief summary of the tool

_**ClangFormat**_ is a tool for automatically formatting C, C++, Java, JavaScript, and other supported source code to _**enforce a consistent coding style**_.
It uses configurable style options, such as LLVM, Google, or custom .clang-format files, to apply uniform indentation, spacing, and alignment.

#### My settings

I've decided to write a [generator](./ClangFormat/generateStyle) that is able to patch the `Llvm` style format.
The patches I've added aim to improve code readability.
But it is possible to change any settings by just adding that setting along with the desired value inside variable **_CONFIG_PATCH_**.
The Python script then generates patched style and applies it to code.

#### Usage

Run the [generator](./ClangFormat/generateStyle) to generate and apply the format to the code.

I've decided to also include small `git pre-commit hook` that will apply **_Lllvm_** style to the code before every single **_commit_**

---

### [Valgrind](https://valgrind.org/)

**_Valgrind, as a base framework_**, provides essential tools for memory debugging, error detection, and performance profiling. It serves as the foundation for specialized utilities such as Memcheck, which identifies memory errors, Cachegrind, Massif, Hellgrind, Callgrind and many other tools.

Two **_Valgrind_** tools that i used are `MemCheck` and `Massif`

### [Massif](https://valgrind.org/docs/manual/ms-manual.html)

#### Brief summary of the tool

**Massif** is designed for detailed heap memory profiling, focusing on analyzing memory consumption and identifying inefficiencies in applications. It tracks memory usage over time and generates a visual breakdown of heap allocations

#### Way i executed analysis

I've decided to profile memory in two different instances of running the program:

- Directed graphs
- Undirected graphs

First and foermost i was looking for memory problems which of which found none, then i decided to see the difference in memory usage between algorithms for Directed graphs and Undirected graphs.
As expected memory usage for Directed graphs exeecded those of Undirected by around 1/3 more.

#### Usage

Take the [massif](./Valgrind/Massif/massif.sh) script and put in root of `Simple graphs` prject run it and if there is no build it will build the project for you.
Afterwards it will run `Massif` and generate output file for you. It will instruct you to use `ms_print` for analysis if output file. The pictures i provided are from [online tool](http://boutglay.com/massifjs/) for visualizing memory usage in execution.

#### Reports

- [Directed graph memory usage](./Valgrind/Massif/massif-directed-visual-report.png) - Shows heap allocation peaks around 2.5MB with steady memory usage during graph operations
- [Undirected graph memory usage](./Valgrind/Massif/massif-undirected-visual-report.png) - Shows lower memory consumption (~1.7MB peak) compared to directed graphs, confirming expected efficiency

### [MemCheck](https://valgrind.org/docs/manual/quick-start.html)

#### Brief summary of the tool

Memcheck is a tool that helps identify memory-related errors in programs, such as memory leaks, invalid accesses, and reads from uninitialized memory.

#### Key results of analysis

Library does not contain any memory leak all allocated memory was freed, the errors that Memcheck noted are all within tests and are related to use of uninitialised value.

#### Usage

Place the script in root of `Simple graphs` and run it. Script will build the project if that is needed and run the tool. After the tool is finished it will output log file which will reperesent the analysis of the said tool.

---

### [Cppcheck](https://cppcheck.sourceforge.io/)

#### Brief summary of the tool

`Cppcheck` is a static analysis tool for C/C++ code. It provides unique code analysis to detect bugs and focuses on detecting undefined behaviour and dangerous coding constructs. The goal is to have very few false positives.

#### Key results of analysis

There are a couple of `information` severity regarding missing includes, but CppCheck states that it is not a problem and that CppCheck does not need them to perform analysis.

`Style` severity is tied to all other messages, there is one note about constructor that should be explicit and all ohter messages are about unused functions.

#### Sugested changes

Since there was no message with high severity, no breaking error was found.
All the messages are benign and unused function i would not want to remove from this library since there is possible future development.
As for the constructor that was noted to be switched to explicit that is the **_that is the only pottentialy bad thing._**
Since the noted constructor has only 1 argument it could potentialy lead to bad behaviour if its left without `explicit`.
