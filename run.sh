qemu-system-riscv64 -machine virt -bios fw_dynamic.bin -kernel zig-out/bin/myos.elf -serial mon:stdio -nographic
