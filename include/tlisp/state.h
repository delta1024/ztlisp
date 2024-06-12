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

/** @} */
#endif // !INCLUDE_tlisp_state_h__
