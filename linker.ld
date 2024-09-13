ENTRY(_start)

MEMORY {
    kernel_space (rwx) : ORIGIN = 0x80200000, LENGTH = 128K
}

SECTIONS {
    . = ORIGIN(kernel_space);

    .text : ALIGN(4K) {
        *(.init)
        *(.text)
    } > kernel_space

    .rodata : ALIGN(4K) {
        *(.rodata)
    } > kernel_space

    .bss : ALIGN(4K) {
        *(.bss)
    } > kernel_space
}