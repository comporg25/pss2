.section .bss                  # Uninitialized data section

.lcomm inputbuff, 2            # Reserve 2 bytes named 'inputbuff' (no initial value)

.section .text                 # Code section

.globl _start                  # Make _start the entry point

_start:

mov $0, %rax                   # rax = 0 -> sys_read
mov $0, %rdi                   # rdi = 0 -> file descriptor 0 (stdin)
mov $inputbuff, %rsi           # rsi = ADDRESS of inputbuff (buffer pointer)
mov $2, %rdx                   # rdx = 2 -> read exactly 2 bytes
syscall                        # perform read(0, &inputbuff, 2)

convert:
mov inputbuff, %rbx            # rbx = *QWORD at address 'inputbuff'
                               # (NOTE: loads 8 bytes starting at inputbuff; buffer is only 2 bytes.)
sub $48, %rbx                  # rbx -= '0' (48) -> convert ASCII '0'..'9' to 0..9 (base)

mov inputbuff+1, %rcx          # rcx = *QWORD at address 'inputbuff+1' (intended “second byte”)
sub $48, %rcx                  # rcx -= '0' (48) -> convert ASCII to 0..9 (exponent)

mov $1, %rax                   # rax = 1 -> accumulator for result (starts at 1)

loop:

cmp $0, %rcx                   # compare exponent (rcx) with 0
je exit                        # if rcx == 0, we're done -> jump to exit

imul %rbx, %rax                # rax *= rbx -> multiply result by base
dec %rcx                       # rcx-- -> decrement exponent
jmp loop                       # repeat until rcx reaches 0

exit:
mov %rax, %rdi                 # move final result into rdi (exit status argument)
mov $60, %rax                  # rax = 60 -> sys_exit
syscall                        # exit(result). Kernel uses only low 8 bits as the status code.
