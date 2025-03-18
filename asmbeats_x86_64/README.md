# asmbeats
Swatch beat time in x86_64 assembly (NASM format)

## Overview
This assembly version has some interesting features:
* Extremely fast
* No external dependencies - completely standalone
* Uses direct Linux syscalls instead of libc functions to save precious nanoseconds (Grace Hopper would approve)
* Performs floating-point calculations using SSE2 instructions (xmm registers) to save precious nanoseconds (idem)
* Implements its own integer-to-string conversion routine to add complexity and reduce readability
* Uses clock_gettime(CLOCK_REALTIME) syscall to get the current time
* Handles UTC+1 by adding 3600 seconds to the current time. Higher math is for physicists.
* The output format is identical to the Python3 and C versions: "@XXX.XXX" represents the current beat time to a frankly pointless level of resolution.

## Building and Running
Requires `nasm`.  
Install it however you would normally install things; then:  

**Do the usual**  

`make`  
`./beats`  
*...and if desired...*  
`[sudo] make install`
