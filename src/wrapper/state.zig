const std = @import("std");
const allocator = std.heap.c_allocator;
const State = @import("tlisp").State;
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
