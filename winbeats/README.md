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
Needs CMake to build, so get that, and then:  

Building:  
`mkdir build`  
`cd build`  
`cmake ..`  
`cmake --build . --config Release`  

Installation:  
`cmake --install . --prefix C:\Program Files\Beats`
