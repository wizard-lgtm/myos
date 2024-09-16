

ENTRY(_start)

SECTIONS
{
    /* Define the memory region for kernel */
    . = 0x80200000;

    .text : {
        *(.text*)     /* All the .text sections */
    }

    .rodata : {
        *(.rodata*)   /* All the .rodata sections */
    }

    .data : {
        *(.data*)     /* All the .data sections */
    }

    .bss : {
        _bss_start = .;
        *(.bss*)
        _bss_end = .;
    }

    /* Define the top of the stack */
    _stack_top = 0x80300000;
}
