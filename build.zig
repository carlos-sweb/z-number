const std = @import("std");

pub fn build(b: *std.Build) void {
    const target = b.standardTargetOptions(.{});
    const optimize = b.standardOptimizeOption(.{});

    // Create znumber module
    const znumber_module = b.addModule("znumber", .{
        .root_source_file = b.path("src/znumber.zig"),
    });

    // Test setup
    const test_step = b.step("test", "Run all tests");

    const test_files = [_][]const u8{
        "tests/constants_test.zig",
        "tests/static_test.zig",
        "tests/formatting_test.zig",
        "tests/parsing_test.zig",
        "tests/validation_test.zig",
        "tests/conversion_test.zig",
        "tests/edge_cases_test.zig",
        "tests/ieee754_test.zig",
    };

    inline for (test_files) |test_file| {
        const unit_tests = b.addTest(.{
            .root_module = b.createModule(.{
                .root_source_file = b.path(test_file),
                .target = target,
                .optimize = optimize,
            }),
        });

        unit_tests.root_module.addImport("znumber", znumber_module);

        const run_unit_tests = b.addRunArtifact(unit_tests);
        test_step.dependOn(&run_unit_tests.step);
    }

    // Main znumber tests
    const znumber_tests = b.addTest(.{
        .root_module = b.createModule(.{
            .root_source_file = b.path("src/znumber.zig"),
            .target = target,
            .optimize = optimize,
        }),
    });

    const run_znumber_tests = b.addRunArtifact(znumber_tests);
    test_step.dependOn(&run_znumber_tests.step);

    b.default_step = test_step;
}
