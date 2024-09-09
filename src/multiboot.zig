pub const Multiboot2Header = packed struct {
    magic: u32,
    architecture: u32,
    header_length: u32,
    checksum: u32,
};
