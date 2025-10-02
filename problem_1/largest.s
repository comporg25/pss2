.section .data
numberofnumbers:
        .quad 7                   # total number of elements in the array
mynumbers:
        .quad 5, 20, 33, 80, 52, 10, 1   # the array of 64-bit integers

.section .text

.globl _start

_start:
mov numberofnumbers, %rcx        # RCX = contents at label 'numberofnumbers' (the count)
                                 # (direct addressing: load the value stored at that address)

mov $mynumbers, %rbx             # RBX = ADDRESS of 'mynumbers' (immediate/address-of)
                                 # we'll use RBX as a pointer to the current element

#largest number
mov $0, %rdi                     # RDI will hold the current maximum; initialize to 0

cmp $0, %rcx                     # if count == 0, there is nothing to process
je end                           # jump to exit when the array is empty

loop:
mov (%rbx), %rax                 # RAX = *RBX  (load current 8-byte element via register-indirect)
cmp %rdi, %rax                   # compare current max (RDI) with element (RAX)
jbe loopcontrol                  # if element <= max (unsigned), skip update

mov %rax, %rdi                   # else: update current max = element

loopcontrol:
add $8, %rbx                     # advance pointer to next element (each is 8 bytes)
dec %rcx                         # decrement remaining count
jnz loop                         # if more elements left (RCX != 0), continue loop

end:
mov $60, %rax                    # RAX = 60  (sys_exit)
syscall                          # exit(status = RDI). Kernel uses low 8 bits of RDI as exit code.
