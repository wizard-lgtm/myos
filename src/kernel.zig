const std = @import("std");
const Uart = @import("./drivers/uart.zig").Uart;
const _asm = @import("./asm.zig");
const interrupts = @import("./interrupts.zig");
const config = @import("./config.zig");
const timer = @import("./timer.zig");

// kernel.zig
export fn kmain() void {
    var uart = Uart{};

    const sstatus: usize = _asm.Asm.csr_read(_asm.Asm.SCsr.sstatus);
    uart.debug("sstauts: {b}\n", .{sstatus});

    uart.debug("DEBUG MODE ENABLED!\n", .{});

    // enable supervisor level interrupts
    interrupts.enable_supervisor_interrupts();
    uart.debug("interrupts enabled!\n", .{});

    interrupts.set_trap_handler(interrupts.trap_handler);
    interrupts.enable_external_interrupts();

    // test trap
    // const invalid_memory: *u8 = @ptrFromInt(0xFFFFFFFF);
    // invalid_memory.* = 42;

    // get time
    timer.timer_init();
    const time = timer.rdtime_get();
    uart.printf("timer occured!, rdtime: {d}\n", .{time});
    timer.create_timer();
    uart.printf("timer occured!, rdtime: {d}\n", .{time});
    timer.create_timer();
    timer.create_timer();
    timer.create_timer();
    timer.create_timer();
    timer.create_timer();
    uart.printf("timer occured!, rdtime: {d}\n", .{time});
    uart.printf("timer occured!, rdtime: {d}\n", .{time});

    while (true) {}
}
