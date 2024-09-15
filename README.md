# LastOS

(note: i didn't decide to project name, if you have any suggestions, open a pull request)

## A unix-like os is about to being yours, light and open for _risc-v64_.
## Motivation
Myos is designed for risc-v cardboard and embedded systems. And it's focuces to simplicity, and running on low-spec hardware. Linux is too heavy and unneceserry for riscv embedded systems,such as car, elevator, or even a strech machine gui control panel.

## Supported systems 
- Qemu
- Vision Five 2 (Future planned) 

## Contribitions

Fork it, hack it, test it, pull it.

## Build Instructions
## dependencies:
- Riscv64 qemu
- Ziglang (0.13.0+)
- Risc-v Gcc cross platform toolchain
- U-boot
- 
For ubuntu/debian:
```
sudo apt install bison flex build-essentials riscv64-linux-gnu-gcc
```

## Building U-boot
```
git clone https://github.com/u-boot/u-boot
cd u-boot
make qemu-riscv64_defconfig
make
cp u-boot.bin ../myos/deps/
```
## Building OpenSBI
```
git clone https://github.com/riscv-software-src/opensbi.git
cd opensbi
make ARCH=riscv CROSS_COMPILE=riscv64-linux-gnu- PLATFORM=generic
cp build/platform/generic/firmware/fw_dynamic.elf ../myos/deps
```

### Run
`zig build`
`sh run.sh`
## Made with suffer, love and cuteness
