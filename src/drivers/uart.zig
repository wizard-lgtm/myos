const BASE_ADDR: usize = 0x10000000;
const BASE_PTR: *volatile u8 = @ptrFromInt(BASE_ADDR);
const WEIRD: *volatile u8 = @ptrFromInt(BASE_ADDR + 4);

pub fn put_chr(chr: u8) void {
    BASE_PTR.* = chr;
}
pub fn init() void {
    put_chr(BASE_PTR.*);
}
pub fn weird(chr: u8) void {
    WEIRD.* = chr;
}
pub fn print(str: []const u8) void {
    for (str) |chr| {
        put_chr(chr);
    }
}
