/******************************************************************************
   main.cpp
		-Process

   modified\ Oct 10 2010
   arthor\ Mike
******************************************************************************/

/**
* Process entry point
*/
void processEntry () {

	char* str="\n\rEste es un mensaje de un programa de usuario en Tutorial 24!";

	__asm {

		/* display message through kernel terminal */
		mov ebx, str
		mov eax, 0
		int 0x80

		/* terminate */
		mov eax, 1
		int 0x80
	}
	for (;;);
}
