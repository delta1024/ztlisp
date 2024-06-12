const std = @import("std");
const Allocator = std.mem.Allocator;

const Value = @import("tlisp").Value;
const ByteList = std.ArrayList(u8);
const ValueList = std.ArrayList(Value);
pub const Chunk = struct {
    code: []u8,
    lines: []u8,
    constants: []Value,
    pub fn deinit(self: *Chunk, allocator: Allocator) void {
        allocator.free(self.code);
        allocator.free(self.lines);
        allocator.free(self.constants);
    }
};
pub const CompilingChunk = struct {
    code: ByteList,
    lines: ByteList,
    constants: ValueList,
    pub fn init(allocator: Allocator) CompilingChunk {
        return .{
            .code = ByteList.init(allocator),
            .lines = ByteList.init(allocator),
            .constants = ValueList.init(allocator),
        };
    }
    pub fn deinit(self: *CompilingChunk) void {
        self.code.deinit();
        self.lines.deinit();
        self.constants.deinit();
    }
    pub fn finalize(self: *CompilingChunk) Allocator.Error!Chunk {
        return .{
            .code = try self.code.toOwnedSlice(),
            .lines = try self.lines.toOwnedSlice(),
            .constants = try self.constants.toOwnedSlice(),
        };
    }
    pub fn writeByte(self: *CompilingChunk, byte: u8, line: u8) Allocator.Error!void {
        try self.code.append(byte);
        try self.lines.append(line);
    }
    pub fn writeConstant(self: *CompilingChunk, constant: Value) Allocator.Error!u8 {
        try self.constants.append(constant);
        return @truncate(self.constants.items.len - 1);
    }
};
