const BASE_ADDR: usize = 0x10000000; // UART base address
const UART_THR: *volatile u8 = @ptrFromInt(BASE_ADDR + 0x0); // Transmit Holding Register, For sending datas
const UART_LCR: *volatile u8 = @ptrFromInt(BASE_ADDR + 0x3); // Line Control Register
const UART_LSR: *volatile u8 = @ptrFromInt(BASE_ADDR + 0x5); // Line status register

// UART ready check constants
const UART_TRANSMITTER_EMPTY: u8 = 1 << 5; // 5th bit - Transmitter Holding Register Empty
const UART_DATA_READY: u8 = 1 << 6; // 6th bit - Data Ready

pub fn put_chr(chr: u8) void {
    // Wait until UART is ready to transmit
    UART_THR.* = chr;
}
pub fn init() void {
    // Initialize UART: Set 8N1 (8 data bits, no parity, 1 stop bit)

}
pub fn print(str: []const u8) void {
    for (str) |chr| {
        put_chr(chr);
    }
}
