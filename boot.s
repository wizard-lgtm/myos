.section .text
.globl _start
.globl kmain  # Declare kmain as an external symbol

_start:
    # Set up the stack pointer
    la sp, stack_top


    # Jump to kmain (which is in Zig)
    call kmain

    # If kmain returns, enter an infinite loop
1:  j 1b


.section .bss
    .space 0x1000
stack_top:
