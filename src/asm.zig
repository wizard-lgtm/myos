pub fn sstatus_read() usize {
    var result: usize = 0;
    asm volatile ("csrr %[result], sstatus"
        : [result] "=r" (result),
    );
    return result;
}
pub fn sstatus_write(value: usize) void {
    asm volatile ("csrw sstatus, %[value]"
        :
        : [value] "r" (value),
    );
}
pub fn stvec_write(value: usize) void {
    asm volatile ("csrw stvec, %[value]"
        :
        : [value] "r" (value),
    );
}
pub fn stvec_read() usize {
    var value: usize = 0;
    asm volatile ("csrr %[value], stvec"
        : [value] "=r" (value),
    );
    return value;
}
