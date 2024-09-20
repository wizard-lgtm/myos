const std = @import("std");
const uart = @import("./drivers/uart.zig");
const _asm = @import("./asm.zig");
const interrupts = @import("./interrupts.zig");
// kernel.zig
export fn kmain() void {
    interrupts.set_trap_handler(interrupts.trap_handler);

    uart.init();
    uart.print("Hello from myos");

    while (true) {}
}
