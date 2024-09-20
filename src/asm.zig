pub fn mstatus_read() usize {
    var result: usize = 0;
    asm volatile ("csrr %[result], mstatus"
        : [result] "=r" (result),
    );
    return result;
}
pub fn mcause_read() void {}
pub fn mtvec_read() void {}
