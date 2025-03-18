# cbeats
Swatch beat time in C

The C version has some key differences from the Python version:
* It's completely self-contained with no external dependencies - it only uses the standard C libraries stdio.h and time.h
* It's more lightweight and will execute faster
* It doesn't handle microseconds (which aren't really meaningful for Swatch Internet Time anyway)
* The time handling is slightly simpler since we're just using UTC and adding an hour for UTC+1

## Building and Running
**Do the usual**  

`make`  
`./beats`  
*...and if desired...*  
`[sudo] make install`  
