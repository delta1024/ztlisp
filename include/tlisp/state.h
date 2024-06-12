#ifndef INCLUDE_tlisp_state_h__
#define INCLUDE_tlisp_state_h__

// IWYU pragma: private, include "tlisp.h"
#include "types.h"
/**
* @file tlisp/state.h
* @desc Tlisp state manipulation routines.
* @group state 
* @ingroup Tlisp
* @{
*/

/**
 * Obtain a fresh \ref TLISP_state
 * @returns NULL on failure. returned state must be freed when caller is done with it.
 * @sa TLISP_state_close().
 */
tlisp_State *tlisp_state_open();

/**
 * Frees all resources assosiated with the given state.
*/
void tlisp_state_close(tlisp_State *state);

/**
 * Load a buffer into memory and compile to a function
 * @param state An active \ref tlisp_State
 * @param buff The buffer to scan
 * @param len The buffer length
 */
void tlisp_state_loadbuffer(tlisp_State *state, const char *buff, int len);

/**
 * Execute a function on the stack
 * @param state An active \ref tlisp_State
 * @param pos The position from the top of the stack where the function is located
 * @param nargs The number of arguments the function takes
 */
void tlisp_state_call(tlisp_State *state, int pos, int nargs);


/** @} */
#endif // !INCLUDE_tlisp_state_h__
