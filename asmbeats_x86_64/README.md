# asmbeats
Swatch beat time in x86_64 assembly (NASM format)

## Overview
This assembly version has some interesting features:
* Uses direct Linux syscalls instead of libc functions
* Performs floating-point calculations using SSE2 instructions (xmm registers)
* Implements its own integer-to-string conversion routine
* Uses no external dependencies - it's a completely standalone binary
* Should be extremely fast as it's all native code

## Some technical notes about the implementation:
* Uses clock_gettime(CLOCK_REALTIME) syscall to get the current time
* Handles UTC+1 by adding 3600 seconds to the current time
* Uses SSE2 floating-point division for the beats calculation
* Formats the output with exactly 3 decimal places
* Uses multiple write syscalls to output the result (one each for the @ symbol, number, and newline)
* The output format is identical to the Python3 and C versions: "@XXX.XXX" represents the current beat time.

## Building and Running
Requires `nasm`.  
Install it however you would normally install things; then:  

**Do the usual**  

`make`  
`./beats`  
*...and if desired...*  
`[sudo] make install`
