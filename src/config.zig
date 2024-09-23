const std = @import("std");
const build_options = @import("build_options");

/// Reads config and returns bool options
pub fn get_debug() bool {
    const debug: bool = build_options.debug;
    return debug;
}
