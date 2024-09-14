OUTPUT_FORMAT("elf64-littleriscv")
ENTRY(_start)

SECTIONS
{
    /* Set the base address for where your bootloader code will be loaded.
       This address depends on your platform and OpenSBI configuration. */
    . = 0x80400000;

    /* Text section where your boot.s and kmain will be placed */
    .text : {
        *(.text.boot)    /* Place all the code marked .text.boot here */
        *(.text)         /* Place other text sections here */
    }

    /* Data section */
    .data : {
        *(.data)
    }

    /* BSS section (uninitialized data) */
    .bss : {
        *(.bss)
        *(COMMON)
    }

    /* Stack region */
    . = ALIGN(16);
    .stack : {
        stack_top = .;     /* Mark the top of the stack */
        . += 0x1000;       /* Allocate 4KB for the stack */
        stack_bottom = .;  /* Mark the bottom of the stack */
    }

    /* End of memory layout */
    _end = .;
}

