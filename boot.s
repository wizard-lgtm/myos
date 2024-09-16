.section .text           # Place the following code in the .text section (executable code)
.globl _start            # Declare the _start label as global, marking it as the entry point

_start:
    la sp, _stack_top    # Load the address of _stack_top into the stack pointer (sp) to initialize the stack
    
    # Clear the .bss section
    la t0, _bss_start    # Load the address of the beginning of the .bss section into register t0
    la t1, _bss_end      # Load the address of the end of the .bss section into register t1
    
1: 
    # Clear .bss section by setting each word to zero
    bgeu t0, t1, 2f      # Compare t0 and t1 (unsigned), if t0 >= t1, jump to label 2 (skip clearing)
    sw zero, 0(t0)       # Store zero (from register zero) into the address pointed to by t0
    addi t0, t0, 4       # Increment t0 by 4 to move to the next memory word
    j 1b                 # Jump back to label 1 to continue clearing the next memory location
    
2: 
    # Jump to the kernel main function
    j kmain              # Jump to the kmain function to begin kernel execution


