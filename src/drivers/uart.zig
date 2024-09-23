const std = @import("std");
pub const Uart = struct {
    pub const BASE_ADDR: usize = 0x10000000; // UART base address
    pub const UART_THR: *volatile u8 = @ptrFromInt(BASE_ADDR + 0x0); // Transmit Holding Register, For sending datas
    pub const UART_LCR: *volatile u8 = @ptrFromInt(BASE_ADDR + 0x3); // Line Control Register
    pub const UART_LSR: *volatile u8 = @ptrFromInt(BASE_ADDR + 0x5); // Line status register

    // UART ready check constants
    pub const UART_TRANSMITTER_EMPTY: u8 = 1 << 5; // 5th bit - Transmitter Holding Register Empty
    pub const UART_DATA_READY: u8 = 1 << 6; // 6th bit - Data Ready

    pub const Self = @This();

    pub const WriteError = error{GeneralWriteError};
    // Custom writer struct for UART
    pub const Writer = std.io.Writer(*Uart, WriteError, write);

    pub fn init() void {
        // Initialize UART: Set 8N1 (8 data bits, no parity, 1 stop bit)
    }

    pub fn write(self: *Self, byte: []const u8) WriteError!usize {
        _ = self;
        const len = byte.len;
        print(byte);

        return len;
    }

    pub fn writer(self: *Self) Writer {
        return Writer{ .context = self };
    }
    pub fn printf(self: *Self, comptime format: []const u8, args: anytype) void {
        const _writer = self.*.writer();
        _writer.print(format, args) catch {
            print("a formatting error happened!");
        };
    }
    pub fn put_chr(chr: u8) void {
        // Wait until UART is ready to transmit
        UART_THR.* = chr;
    }
    pub fn print(str: []const u8) void {
        for (str) |chr| {
            put_chr(chr);
        }
    }

    ///
    /// Prints debug message if the KernelOptions.debug = true
    ///
    pub fn debug(self: *Self, comptime format: []const u8, args: anytype) void {
        const _writer = self.*.writer();
        _writer.print(format, args) catch {
            print("a formatting error happened!");
        };
    }
};

test "uart" {
    const str = "Hello";
    const uart = Uart{};
    uart.init();

    uart.printf("format format {s}: {d}\n", .{ str, 19992 });
}
