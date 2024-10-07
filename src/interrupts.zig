const Uart = @import("./drivers/uart.zig").Uart;
const _asm = @import("./asm.zig");
const Asm = _asm.Asm;
const SCsr = Asm.SCsr;

pub const InterruptCause = enum(usize) {
    UserSoftwareInterrupt = 0,
    SuperVisorSoftwareInterrupt = 1,
    UserTimerInterrupt = 4,
    SupervisorTimerInterrupt = 5,
    UserexternalInterrupt = 8,
    SupervisorexternalInterrupt = 9,
};
pub const ExceptionCause = enum(usize) {
    InstructionAddressMisaligned = 0,
    InstructionAccessFault = 1,
    IllegalInstruction = 2,
    BreakPoint = 3,
    LoadAccessFault = 5,
    AMOAddressMisaligned = 6,
    StoreAMOAccessFault = 7,
    EnviromentCall = 8,
    InstructionPageFault = 12,
    LoadPageFault = 13,
    StoreAMOPageFault = 15, //
};

var uart: Uart = .{};

pub fn set_trap_handler(trap_handler_ptr: *const fn () void) void {
    const STVEC_MODE: usize = 0b00; // zero for no mapping, single function

    const trap_handler_addr: usize = @intFromPtr(trap_handler_ptr);

    uart.debug("trap handler addr: {b}, {d}\n", .{ trap_handler_addr, trap_handler_addr });

    const SET_ZERO: usize = 0b11;

    const stvec_addr_space: usize = trap_handler_addr & ~SET_ZERO; // ~ makes first 2 bit setted to 0 and the other 2..64 is the address;

    const stvec_value: usize = stvec_addr_space | STVEC_MODE;

    // read stvec after write for debugging
    var stvec: usize = Asm.csr_read(SCsr.stvec);

    uart.debug("stvec: {b}\n", .{stvec});

    Asm.csr_write(stvec_value, SCsr.stvec);

    stvec = Asm.csr_read(SCsr.stvec);

    uart.debug("stvec: {b}, {d}\n", .{ stvec, stvec });

    uart.debug("trap handler addr is setted to {p}\n", .{trap_handler_ptr});
    return;
}

// Supervisor interrupts
pub fn enable_supervisor_interrupts() void {
    var sstatus = Asm.csr_read(SCsr.sstatus);
    const SIE_BIT: u64 = 1 << 1;
    sstatus |= SIE_BIT;
    Asm.csr_write(sstatus, SCsr.sstatus);
}
pub fn check_supervisor_interrupts_enabled() bool {
    const sstatus: usize = Asm.csr_read(Asm.SCsr.sstatus); // Read sstatus register
    const mask = 1 << 1; // 1st bit of sstatus equals SIE
    return (sstatus & mask) != 0; // Perform AND operation for checking
}

// Timer interrupts
pub fn check_supervisor_timer_interrupts_enabled() bool {
    const sie: usize = Asm.csr_read(Asm.SCsr.sie); // Read sstatus register
    const mask = 1 << 5; // 5th bit of sie equals STIE
    return (sie & mask) != 0; // Perform AND operation for checking
}
pub fn enable_supervisor_timer_interrupts() void {
    var sie = Asm.csr_read(SCsr.sie);
    const mask = 1 << 5; // 5th bit of sie equals STIE
    sie = sie | mask; // Perform OR operation for setting 5th bit to 1
    Asm.csr_write(sie, SCsr.sie);
}

// Trap handler
pub fn trap_handler() align(4) void {
    const scause = Asm.csr_read(SCsr.scause);
    const is_interrupt_mask = 1 << 63; // 63th last bit is for is interrupt?
    const is_interrupt: bool = scause & is_interrupt_mask == 1; // perform AND operation to scause

    uart.debug("Trap Occured\n", .{});

    if (is_interrupt) {
        const cause: InterruptCause = @enumFromInt(scause);
        // Handle interrupts
        uart.debug("An Interrupt occured!\n", .{});

        uart.printf("cause: {any}\n", .{cause});
    } else {
        const cause: ExceptionCause = @enumFromInt(scause);
        // Handle exceptions
        uart.debug("An exception happened\n", .{});
        uart.printf("cause: {any}\n", .{cause});
    }
    asm volatile ("sret");
}
///
///
///
pub fn get_interrupts_enabled() bool {
    uart.printf("get_interrupts_enabled NOT IMPLEMENTED\n", .{});

    return false;
}

pub fn enable_external_interrupts() void {
    var sie = Asm.csr_read(SCsr.sie);
    uart.debug("sie before enabling interrupts: {d}\n,", .{sie});
    const mask: usize = 1 << 9;
    const mask2: usize = 1 << 5;

    sie |= mask;
    sie |= mask2;

    uart.debug("sie going to be write {d}, {b}\n", .{ sie, sie });
    Asm.csr_write(sie, SCsr.sie);

    sie = Asm.csr_read(SCsr.sie);

    uart.debug("External interrupts are enabled!\n", .{});

    uart.debug("sie after enabling interrupts: {d}\n,", .{sie});

    const sip = Asm.csr_read(SCsr.sip);
    uart.debug("sip: {d}, {b}", .{ sip, sip });
}
