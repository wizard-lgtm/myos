build=build # build dir
isoname=myos.iso # isoname
mkdir -p $build # create build dir

zig build # build with build.zig file 

d=build/isofiles/boot/grub

mkdir -p "$d" && cp grub.cfg "$d"
cp zig-out/bin/myos.bin $build/isofiles/boot/kernel.bin

sudo grub-mkrescue -o build/$isoname build/isofiles # create iso

qemu-system-riscv64 -drive format=raw,file=build/$isoname # run with qemu