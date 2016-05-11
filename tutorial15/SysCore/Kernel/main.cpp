/*
=========================================================================
	main.cpp

	main kernel program
=========================================================================
*/

#include <hal.h>
#include "DebugDisplay.h"

int _cdecl main () {

	DebugClrScr (0x18);

	DebugGotoXY (0,0);
	DebugSetColor (0x70);
	DebugPrintf (" Sistemas Operativos I - CEUTEC...                       ");
	DebugGotoXY (0,1);
	DebugSetColor (0x19);
	DebugPrintf (" TF141 Iniciando...\n");

	DebugSetColor (0x70);
	DebugGotoXY (0,24);
	DebugPrintf (" Inicializando Capa de Abstraccion de Hardware (HAL.lib)...                           ");

	DebugSetColor (0x19);
	DebugGotoXY (0,2);

	hal_initialize ();

//! uncomment to generate interrupt 0x15. This will call the default exception handler
//	geninterrupt (0x15);

	return 0;
}



