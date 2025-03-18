// beats_aarch64.asm - Swatch Internet Time calculator for AArch64
// For Raspberry Pi 4 (Cortex-A72)
// Assemble with: as -o beats.o beats_aarch64.asm
// Link with: ld -o beats beats.o

.data
    timespec:       .skip 16         // struct timespec for time
    output:         .ascii "@"       // Output buffer starts with @
    decimal:        .skip 8          // Space for decimal digits
    newline:        .ascii "\n"
    beats_divisor:  .double 86.4     // 86400 seconds / 1000 beats

.text
.align 2
.global _start

// System call numbers for ARM64 Linux
.equ SYS_CLOCK_GETTIME, 113
.equ SYS_WRITE, 64
.equ SYS_EXIT, 93
.equ CLOCK_REALTIME, 0

_start:
    // Get current time using clock_gettime(CLOCK_REALTIME)
    mov x0, #CLOCK_REALTIME
    adr x1, timespec
    mov x8, #SYS_CLOCK_GETTIME
    svc #0

    // Load seconds since epoch
    ldr x0, [x1]                // Load seconds from timespec

    // Convert to UTC+1 by adding 3600 seconds
    add x0, x0, #3600

    // Divide by 86400 to get days since epoch
    mov x2, #86400
    udiv x3, x0, x2            // x3 = days
    msub x0, x3, x2, x0        // x0 = seconds into current day

    // Convert seconds to double for beats calculation
    scvtf d0, x0               // Convert to double
    adr x1, beats_divisor
    ldr d1, [x1]               // Load 86.4
    fdiv d0, d0, d1            // Divide by 86.4

    // Multiply by 1000 and round to get 3 decimal places
    mov x1, #1000
    scvtf d1, x1
    fmul d0, d0, d1            // Multiply by 1000
    fcvtas x0, d0              // Convert to integer with rounding

    // Convert to ASCII
    adr x1, decimal            // Get buffer address
    add x1, x1, #7             // Start at end
    mov w2, #0
    strb w2, [x1]              // Null terminator
    sub x1, x1, #1

    // First three decimal places
    mov w3, #3                 // Counter for decimal places
1:  mov x2, #10
    udiv x4, x0, x2           // Divide by 10
    msub x5, x4, x2, x0       // Get remainder
    add w5, w5, #'0'          // Convert to ASCII
    strb w5, [x1]             // Store digit
    sub x1, x1, #1            // Move buffer pointer
    mov x0, x4                // Update number
    subs w3, w3, #1           // Decrement counter
    b.ne 1b

    // Add decimal point
    mov w2, #'.'
    strb w2, [x1]
    sub x1, x1, #1

    // Remaining digits
2:  cbz x0, 3f                // If number is zero, done
    mov x2, #10
    udiv x4, x0, x2           // Divide by 10
    msub x5, x4, x2, x0       // Get remainder
    add w5, w5, #'0'          // Convert to ASCII
    strb w5, [x1]             // Store digit
    sub x1, x1, #1            // Move buffer pointer
    mov x0, x4                // Update number
    b 2b

3:  // Write @ symbol
    mov x0, #1                // stdout
    adr x1, output            // @ symbol
    mov x2, #1                // length
    mov x8, #SYS_WRITE
    svc #0

    // Write number
    mov x0, #1                // stdout
    adr x1, decimal           // number string
    mov x2, #8                // max length
    mov x8, #SYS_WRITE
    svc #0

    // Write newline
    mov x0, #1                // stdout
    adr x1, newline           // newline char
    mov x2, #1                // length
    mov x8, #SYS_WRITE
    svc #0

    // Exit
    mov x0, #0                // status = 0
    mov x8, #SYS_EXIT
    svc #0 
