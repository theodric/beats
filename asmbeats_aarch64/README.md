# asmbeats
Swatch beat time in aarch64 (Cortex-A72, BCM2711, Raspberry Pi 4) assembly

## Overview
Spiritually the same as the x86_64 ASM version, but:  
* Uses ARM's NEON/FP instructions
* scvtf for integer to float conversion (instead of cvtsi2sd)
* fdiv/fmul for floating point operations
* fcvtas for float to integer with rounding
* Double precision uses d registers
* Different addressing modes from x86_64
* Uses b for unconditional branch (instead of jmp)
* Uses b.ne, b.eq etc. for conditional branches
* etc. etc. etc.

## Building and Running
**Do the usual**  

`make`  
`./beats`  
*...and if desired...*  
`[sudo] make install`
