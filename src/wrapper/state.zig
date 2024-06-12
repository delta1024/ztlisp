const std = @import("std");
const allocator = std.heap.c_allocator;
const tlisp = @import("tlisp");
const State = tlisp.State;
const OpCode = tlisp.runtime.OpCode;
pub const tlisp_State = extern struct {
    inner: *State,
};
export fn tlisp_state_open() ?*anyopaque {
    const state = allocator.create(tlisp_State) catch return null;
    state.inner = State.init(allocator) catch {
        allocator.destroy(state);
        return null;
    };
    return state;
}

export fn tlisp_state_close(state: ?*anyopaque) void {
    const self: *tlisp_State = @ptrCast(@alignCast(state));
    self.inner.deinit(allocator);
    allocator.destroy(self);
}
export fn tlisp_state_loadbuffer(state: ?*anyopaque, buffer: [*c]const u8, len: i32) void {
    _ = buffer;
    _ = len;
    const _self: *tlisp_State = @ptrCast(@alignCast(state));
    const self = _self.inner;
    const pos = self.compChunk.writeConstant(15) catch @panic("constant write err");
    self.compChunk.writeByte(@intFromEnum(OpCode.Constant), 1) catch {};
    self.compChunk.writeByte(pos, 1) catch {};
    self.compChunk.writeByte(@intFromEnum(OpCode.Return), 1) catch {};
}
export fn tlisp_state_call(state: ?*anyopaque, pos: i32, nargs: i32) void {
    _ = pos;
    _ = nargs;
    const _self: *tlisp_State = @ptrCast(@alignCast(state));
    const self = _self.inner;
    self.chunk = self.compChunk.finalize() catch null;
    std.debug.print("\n{?}\n", .{self.chunk});
}
