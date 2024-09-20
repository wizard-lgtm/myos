pub fn mstatus_read() u64 {
    return asm volatile ("csrr t0, mstatus"
        : [ret] "={t0}" (-> usize),
    );
}
