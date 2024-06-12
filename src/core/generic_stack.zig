const std = @import("std");
const testing = std.testing;
pub fn Stack(comptime T: type, comptime STACK_MAX: usize, comptime default_value: T) type {
    return struct {
        const Self = @This();
        pub const Error = error{
            StackOverflow,
        };
        buffer: [STACK_MAX]T = [_]T{default_value} ** STACK_MAX,
        stack_top: []T = &.{},
        pub fn reset(self: *Self) void {
            self.stack_top = self.buffer[0..0];
        }
        pub fn push(self: *Self, value: T) Error!void {
            if (self.stack_top.len == STACK_MAX) {
                return error.StackOverflow;
            }
            self.stack_top.len += 1;
            self.stack_top[self.stack_top.len - 1] = value;
        }
        pub fn pop(self: *Self) ?T {
            if (self.stack_top.len == 0)
                return null;
            defer self.stack_top.len -= 1;
            return self.stack_top[self.stack_top.len - 1];
        }
    };
}
const TestingStack = Stack(i32, 15, 0);
test "Stack Push" {
    var stack = TestingStack{};
    stack.reset();
    try stack.push(5);
    try testing.expectEqual(1, stack.stack_top.len);
    try testing.expectEqual(5, stack.stack_top[0]);
}
test "Stack Pop" {
    var stack = TestingStack{};
    stack.reset();
    try stack.push(5);
    try testing.expectEqual(@as(?i32, 5), stack.pop());
}
