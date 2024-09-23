const Uart = @import("./drivers/uart.zig").Uart;
const _asm = @import("./asm.zig");

pub fn set_trap_handler(trap_handler_ptr: *const fn () void) void {
    var uart = Uart{};

    const STVEC_MODE: usize = 0b00; // zero for no mapping, single function

    const trap_handler_addr: usize = @intFromPtr(trap_handler_ptr);

    uart.debug("trap handler addr: {b}, {d}\n", .{ trap_handler_addr, trap_handler_addr });

    const SET_ZERO: usize = 0b11;

    const stvec_addr_space: usize = trap_handler_addr & ~SET_ZERO; // ~ makes first 2 bit setted to 0 and the other 2..64 is the address;

    const stvec_value: usize = stvec_addr_space | STVEC_MODE;

    // read stvec after write for debugging
    var stvec: usize = _asm.stvec_read();

    uart.debug("stvec: {b}\n", .{stvec});

    _asm.stvec_write(stvec_value);

    stvec = _asm.stvec_read();

    uart.debug("stvec: {b}, {d}\n", .{ stvec, stvec });

    uart.debug("trap handler addr is setted to {p}\n", .{trap_handler_ptr});
    return;
}

pub fn enable_supervisor_interrupts() void {
    var sstatus = _asm.sstatus_read();
    const SIE_BIT: u64 = 1 << 1;
    sstatus |= SIE_BIT;
    _asm.sstatus_write(sstatus);
}

pub fn trap_handler() align(4) void {
    var uart = Uart{};
    uart.printf("Trap occured\n", .{});
    uart.printf("Unimplemented\n", .{});
}
///
///
///
pub fn get_interrupts_enabled() bool {
    var uart: Uart = .{};

    uart.printf("get_interrupts_enabled NOT IMPLEMENTED\n", .{});

    return false;
}
