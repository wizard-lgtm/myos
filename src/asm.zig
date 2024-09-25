const std = @import("std");

pub const Asm = struct {
    pub const SCsr = enum(u32) {
        sstatus = 0x100, // Status Register
        sie = 0x104, // Interrupt Enable Register
        stvec = 0x105, // Trap-Vector Base Address Register
        sscratch = 0x140, // Scratch Register
        sepc = 0x141, // Exception Program Counter
        scause = 0x142, // Cause Register
        stval = 0x143, // Trap Value Register
        sip = 0x144, // Interrupt Pending Register
        satp = 0x180, // Address Translation and Protection Register

    };

    pub fn csr_write(value: usize, comptime csr: SCsr) void {
        asm volatile ("csrw %[csr], %[value]"
            :
            : [value] "r" (value),
              [csr] "in" (csr),
        );
    }

    pub fn csr_read(comptime csr: SCsr) usize {
        var value: usize = 0;
        asm volatile ("csrr %[value], %[csr]"
            : [value] "=r" (value),
            : [csr] "in" (csr),
        );
        return value;
    }
};
