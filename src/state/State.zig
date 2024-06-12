const std = @import("std");
const Allocator = std.mem.Allocator;
const Self = @This();
message: []const u8,

pub fn init(allocator: Allocator) !*Self {
    const self = try allocator.create(Self);
    self.message = "Hello Mom\n";
    return self;
}

pub fn deinit(self: *Self, allocator: Allocator) void {
    allocator.destroy(self);
}
