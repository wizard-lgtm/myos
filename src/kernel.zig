const uart = @import("./drivers/uart.zig");
// kernel.zig
export fn kmain() void {
    uart.print("Hello world!\n");

    uart.weird('a');
    while (true) {
        uart.init();
    }
}
