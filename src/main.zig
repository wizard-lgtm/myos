const uart_ptr: *volatile u8 = @ptrFromInt(0x10000000);
fn put_chr(chr: u8) void {
    uart_ptr.* = chr;
}
fn print_str(str: []const u8) void {
    for (str) |chr| {
        put_chr(chr);
    }
}
// kmain 
export fn kmain() void{
    // loop
    print_str("merhaba meryem!\n");
    while (true) {
        put_chr(uart_ptr.*);
    }
}
