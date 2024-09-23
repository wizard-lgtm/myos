const std = @import("std");
const Uart = @import("./drivers/uart.zig").Uart;
const _asm = @import("./asm.zig");
const interrupts = @import("./interrupts.zig");
const config = @import("./config.zig");

// kernel.zig
export fn kmain() void {
    var sstatus: usize = _asm.sstatus_read();

    var uart = Uart{};

    uart.debug("DEBUG MODE ENABLED!\n", .{});

    // enable supervisor level interrupts
    interrupts.enable_supervisor_interrupts();
    uart.debug("interrupts enabled!\n", .{});

    sstatus = _asm.sstatus_read();

    uart.debug("status {b}\n", .{sstatus});
    interrupts.set_trap_handler(interrupts.trap_handler);

    while (true) {}
}
