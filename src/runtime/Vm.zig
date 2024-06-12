const std = @import("std");
const tlisp = @import("tlisp");
const config = @import("config");
const Value = tlisp.Value;
const ValueStack = tlisp.core.Stack(Value, config.STACK_MAX, 0);
const Chunk = tlisp.core.Chunk;
const OpCode = @import("opcode.zig").OpCode;

const Self = @This();

stack: ValueStack = .{},
chunk: *Chunk = undefined,
ip: []u8 = &.{},

fn readByte(self: *Self) u8 {
    self.ip.len += 1;
    return self.ip[self.ip.len - 1];
}
fn readConstant(self: *Self) Value {
    return self.chunk.constants[self.readByte()];
}
pub fn run(self: *Self) !void {
    while (true) {
        const byte: OpCode = @enumFromInt(self.readByte());
        switch (byte) {
            .Constant => {
                const val = self.readConstant();
                try self.stack.push(val);
            },
            .Return => {
                if (self.stack.pop()) |val|
                    std.debug.print("{d}\n", .{val});
                return;
            },
        }
    }
}
