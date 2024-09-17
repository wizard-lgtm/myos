const uart = @import("./drivers/uart.zig");
pub fn cssr_mstatus() void {
    asm volatile ("csrr t0, mstatus");
}
const std = @import("std");
fn u64_to_str(n: u64) []u8 {
    var buffer: [20]u8 = undefined;
    const result = std.fmt.bufPrint(&buffer, "{d}", .{n});

    if (result) |value| {
        return buffer[0..value.len];
    } else |_| {
        return &[_]u8{}; // Return an empty slice in case of error
    }
    return buffer;
}

// kernel.zig
export fn kmain() void {
    _ = cssr_mstatus();

    for (0..5) |i| {
        uart.print("Hello world");
        uart.print(u64_to_str(i));
        uart.print("\n");
    }

    while (true) {}
}
