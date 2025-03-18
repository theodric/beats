# cbeats
Swatch beat time in (gag) C++ for (puke!) *Windows*

Oh God, Why Am I Doing This?  
* Uses Windows' cursed native time API instead of blessed POSIX calls
* Higher precision (Windows FILETIME gives 100ns precision so you know exactly when it crashed)
* More robust error handling with try/catch because Windows likes to fuck up
* Object-oriented design because Windows
* UTF-8 console output support because complicated
* CMake-based build system instead of Make because Windows

## Building and Running
Needs CMake and Visual Studio 2022 (including the Build Tools) to build, so get those:  
`winget install Kitware.CMake`  
`winget install --id=Microsoft.VisualStudio.2022.Community -e`  

Then:  

Building:  
*Open a "Developer Command Prompt for VS 2022", then run*
`mkdir build`  
`cd build`  
`cmake ..`  
`cmake --build . --config Release`  

Installation (needs an Administrator-elevated "Developer Command Prompt for VS 2022"):  
`cmake --install . --prefix C:\Program Files\Beats`
