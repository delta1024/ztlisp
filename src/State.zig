const std = @import("std");
const Allocator = std.mem.Allocator;
const Self = @This();
const tlisp = @import("tlisp");
chunk: ?tlisp.core.Chunk,
compChunk: tlisp.core.chunk.CompilingChunk,
vm: tlisp.runtime.Vm,

pub fn init(allocator: Allocator) !*Self {
    const self = try allocator.create(Self);
    self.compChunk = tlisp.core.chunk.CompilingChunk.init(allocator);
    self.chunk = null;
    return self;
}

pub fn deinit(self: *Self, allocator: Allocator) void {
    if (self.chunk) |*chunk|
        chunk.deinit(allocator);
    self.compChunk.deinit();

    allocator.destroy(self);
}
