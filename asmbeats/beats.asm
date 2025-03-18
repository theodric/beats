; beats.asm - Swatch Internet Time calculator in x86_64 assembly
; Compile with: nasm -f elf64 beats.asm
; Link with: ld -o beats beats.o

section .data
    time_spec:      times 16 db 0   ; struct timespec for time
    output:         db "@"          ; Output buffer starts with @
    decimal:        times 8 db 0    ; Space for decimal digits
    newline:        db 10           ; Newline character
    beats_divisor:  dq 86.4         ; 86400 seconds / 1000 beats

section .text
global _start

_start:
    ; Get current time using clock_gettime(CLOCK_REALTIME)
    mov rax, 228        ; sys_clock_gettime
    mov rdi, 0          ; CLOCK_REALTIME
    mov rsi, time_spec
    syscall

    ; Load seconds since epoch
    mov rax, [time_spec]

    ; Convert to UTC+1 by adding 3600 seconds (1 hour)
    add rax, 3600

    ; Divide by 86400 to get days since epoch, remainder in rdx
    mov rbx, 86400
    xor rdx, rdx
    div rbx             ; RAX = days, RDX = seconds into current day

    ; Convert seconds into beats (divide by 86.4)
    cvtsi2sd xmm0, rdx          ; Convert seconds to double
    divsd xmm0, [beats_divisor] ; Divide by 86.4

    ; Convert to string with 3 decimal places
    ; First multiply by 1000 to get an integer
    mov rax, 1000
    cvtsi2sd xmm1, rax
    mulsd xmm0, xmm1
    cvtsd2si rax, xmm0         ; Convert to integer

    ; Convert to ASCII
    mov rdi, decimal
    add rdi, 7                  ; Start at end of buffer
    mov byte [rdi], 0          ; Null terminator
    dec rdi
    
    ; First three digits are decimals
    mov rcx, 3
.decimal_loop:
    xor rdx, rdx
    mov rbx, 10
    div rbx
    add dl, '0'
    mov [rdi], dl
    dec rdi
    dec rcx
    jnz .decimal_loop

    ; Add decimal point
    mov byte [rdi], '.'
    dec rdi

    ; Remaining digits
.integer_loop:
    test rax, rax
    jz .print
    xor rdx, rdx
    mov rbx, 10
    div rbx
    add dl, '0'
    mov [rdi], dl
    dec rdi
    jmp .integer_loop

.print:
    ; Calculate length of the string
    mov rdx, decimal
    add rdx, 8          ; Point to end of buffer
    sub rdx, rdi        ; RDX now contains length
    inc rdi             ; Point to first digit

    ; Write @ symbol
    mov rax, 1          ; sys_write
    mov rdi, 1          ; stdout
    mov rsi, output     ; @
    mov rdx, 1          ; length
    syscall

    ; Write the number
    mov rax, 1          ; sys_write
    mov rdi, 1          ; stdout
    mov rsi, decimal    ; number string
    mov rdx, 8          ; max length
    syscall

    ; Write newline
    mov rax, 1          ; sys_write
    mov rdi, 1          ; stdout
    mov rsi, newline    ; \n
    mov rdx, 1          ; length
    syscall

    ; Exit
    mov rax, 60         ; sys_exit
    xor rdi, rdi        ; status = 0
    syscall
