const std = @import("std");
const builtin = @import("builtin");
const Target = std.Target;

const os: Target.Os = .{ .tag = Target.Os.Tag.freestanding, .version_range = Target.Os.VersionRange.default(.freestanding, .riscv64) };
const cpu: Target.Cpu = .{.arch = .riscv64, .features = }
pub fn build(b: *std.Build) void {
    const query = Target.Query{
        .cpu_arch = Target.Cpu.Arch.riscv64,
        .os_tag = Target.Os.Tag.freestanding,
        .abi = Target.Abi.none,
    };
    const target = std.Target{ .os = os, .abi = .none, .cpu = std.Target.Cpu, .ofmt = .raw };
    const resolved_target = std.Build.ResolvedTarget{ .query = query, .result = target };
    const optimize = b.standardOptimizeOption(.{});

    const exe = b.addExecutable(.{
        .name = "myos",
        .root_source_file = b.path("src/main.zig"),
        .target = resolved_target,
        .optimize = optimize,
    });

    b.installArtifact(exe);
    const run_cmd = b.addRunArtifact(exe);
    run_cmd.step.dependOn(b.getInstallStep());

    if (b.args) |args| {
        run_cmd.addArgs(args);
    }

    const run_step = b.step("run", "Run the app");
    run_step.dependOn(&run_cmd.step);
}
