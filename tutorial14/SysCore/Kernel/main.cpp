/*
======================================
	main.cpp
		-kernel startup code
======================================
*/

#include "DebugDisplay.h"

void _cdecl main () {

	int i=0x1410FB2;

	DebugClrScr (0x18);

	DebugGotoXY (4,4);
	DebugSetColor (0x70);
	DebugPrintf ("+-----------------------------------------+\n");
	DebugPrintf ("|    TF141 32bit Kernel Ejecutandose      |\n");
	DebugPrintf ("+-----------------------------------------+\n\n");
	DebugSetColor (0x12);

	DebugSetColor (0x12);
	DebugPrintf ("\ni numero de cuenta ........................");
	DebugPrintf ("\ni numero de cuenta en hexadecimal ..........");

	DebugGotoXY (25,8);
	DebugSetColor (0x1F);
	DebugPrintf ("\n[%i]",i);
	DebugPrintf ("\n[0x%x]",i);

	DebugGotoXY (4,16);
	DebugSetColor (0x70);
	DebugPrintf ("\n\nCargando, por favor espere... :)");

}
