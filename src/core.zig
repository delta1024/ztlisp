pub const Stack = @import("core/generic_stack.zig").Stack;
pub const Value = @import("core/value.zig").Value;
pub const chunk = @import("core/chunk.zig");
pub const Chunk = chunk.Chunk;

test {
    _ = @import("core/generic_stack.zig");
}
