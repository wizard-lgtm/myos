pub packed struct Multiboot2Header {
 magic: u32,
 architecture: u32,
 header_length: u32,
 checksum: u32,
};

pub const multiboot2: MultiBootHeader {
  .magic = 0xE85250D6,
  .architecture: 0,
  .header_length: 24,
  checksum: -(0xE85250D6 + 0 + 24)
};
