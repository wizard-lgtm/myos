const Multiboot2Header = @import("./multiboot.zig").Multiboot2Header;

export var multiboot align(4) linksection(".multiboot") = Multiboot2Header{
    .magic = 0xE85250D6, // magic number
    .architecture = 0, // riscv
    .header_length = 24, // length
    .checksum = @intCast(0xFFFFFFFF - (0xE85250D6 + 0 + 24) + 1), // correct wrapping for u32

};

// start
export fn _start() noreturn {
    // loop
    while (true) {}
}
