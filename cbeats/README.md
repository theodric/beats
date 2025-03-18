# cbeats
Swatch beat time in C

The C version has a couple differences from the Python version:
* It doesn't handle microseconds (which aren't really meaningful for Swatch Internet Time anyway)
* The time handling is slightly simpler since we're just using UTC and adding an hour for UTC+1

## Building and Running
**Do the usual**  

`make`  
`./beats`  
*...and if desired...*  
`[sudo] make install`  
