#include "tlisp.h"
#include <stddef.h>
#include <tlisp.h>
int main(void) {
	tlisp_State *state = tlisp_state_open();
	tlisp_state_loadbuffer(state, NULL, 0);
	tlisp_state_call(state, 0, 0);
	tlisp_state_close(state);
}
