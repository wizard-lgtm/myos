const std = @import("std");
const builtin = @import("builtin");
const Target = std.Target;

const os: Target.Os = .{ .tag = Target.Os.Tag.freestanding, .version_range = Target.Os.VersionRange.default(.freestanding, .riscv64) };
const features: Target.Cpu.Feature.Set = .{ .ints = .{ 1, 2, 3, 4, 5 } };
const model = Target.Cpu.Model{
    .name = "riscv64", // riscv
    .llvm_name = null, // null
    .features = features,
};

const cpu: Target.Cpu = .{ .arch = .riscv64, .features = features, .model = &model };
pub fn build(b: *std.Build) void {
    const query = Target.Query{
        .cpu_arch = Target.Cpu.Arch.riscv64,
        .os_tag = Target.Os.Tag.freestanding,
        .abi = Target.Abi.none,
    };
    const target = std.Target{ .os = os, .abi = .none, .cpu = cpu, .ofmt = Target.ObjectFormat.default(os.tag, .riscv64) };
    const resolved_target = std.Build.ResolvedTarget{ .query = query, .result = target };
    const optimize = b.standardOptimizeOption(.{});

    const exe = b.addExecutable(.{
        .name = "myos.bin",
        .root_source_file = b.path("src/main.zig"),
        .target = resolved_target,
        .optimize = optimize,
    });

    exe.setLinkerScript(b.path("./linker.ld"));
    // add linker script,
    // TODO

    b.installArtifact(exe);
    const run_cmd = b.addRunArtifact(exe);
    run_cmd.step.dependOn(b.getInstallStep());

    if (b.args) |args| {
        run_cmd.addArgs(args);
    }

    const run_step = b.step("run", "Run the app");
    run_step.dependOn(&run_cmd.step);
}
