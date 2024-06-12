#include <tlisp.h>
int main(void) {
	tlisp_State *state = tlisp_state_open();
	tlisp_state_close(state);
}
