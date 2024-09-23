const std = @import("std");
const Uart = @import("./drivers/uart.zig").Uart;
const _asm = @import("./asm.zig");
const interrupts = @import("./interrupts.zig");
// kernel.zig
export fn kmain() void {
    var sstatus: usize = _asm.sstatus_read();

    const str = "Hello";
    var uart = Uart{};

    uart.printf("format format {s}: {d}\n", .{ str, 19992 });
    uart.printf("status {b}\n", .{sstatus});

    // enable supervisor level interrupts
    interrupts.enable_supervisor_interrupts();
    uart.printf("interrupts enabled!\n", .{});

    sstatus = _asm.sstatus_read();

    uart.printf("status {b}\n", .{sstatus});

    interrupts.set_trap_handler(interrupts.trap_handler);

    while (true) {}
}
