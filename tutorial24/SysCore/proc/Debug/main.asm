; Listing generated by Microsoft (R) Optimizing Compiler Version 16.00.30319.01 

	TITLE	C:\Documents and Settings\Jorge Fernandez\Desktop\Sistemas Operativos I\2016-ii-1272-so1-osdevseries-jorgefer00\tutorial24\SysCore\proc\main.cpp
	.686P
	.XMM
	include listing.inc
	.model	flat

INCLUDELIB MSVCRT
INCLUDELIB OLDNAMES

CONST	SEGMENT
$SG2532	DB	0aH, 0dH, 'Este es un mensaje de un programa de usuario e'
	DB	'n Tutorial 24!', 00H
CONST	ENDS
PUBLIC	?processEntry@@YAXXZ				; processEntry
; Function compile flags: /Odtpy
; File c:\documents and settings\jorge fernandez\desktop\sistemas operativos i\2016-ii-1272-so1-osdevseries-jorgefer00\tutorial24\syscore\proc\main.cpp
_TEXT	SEGMENT
_str$ = -4						; size = 4
?processEntry@@YAXXZ PROC				; processEntry

; 12   : void processEntry () {

	push	ebp
	mov	ebp, esp
	push	ecx
	push	ebx

; 13   : 
; 14   : 	char* str="\n\rEste es un mensaje de un programa de usuario en Tutorial 24!";

	mov	DWORD PTR _str$[ebp], OFFSET $SG2532

; 15   : 
; 16   : 	__asm {
; 17   : 
; 18   : 		/* display message through kernel terminal */
; 19   : 		mov ebx, str

	mov	ebx, DWORD PTR _str$[ebp]

; 20   : 		mov eax, 0

	mov	eax, 0

; 21   : 		int 0x80

	int	-128					; ffffff80H

; 22   : 
; 23   : 		/* terminate */
; 24   : 		mov eax, 1

	mov	eax, 1

; 25   : 		int 0x80

	int	-128					; ffffff80H
$LN2@processEnt:

; 26   : 	}
; 27   : 	for (;;);

	jmp	SHORT $LN2@processEnt

; 28   : }

	pop	ebx
	mov	esp, ebp
	pop	ebp
	ret	0
?processEntry@@YAXXZ ENDP				; processEntry
_TEXT	ENDS
END
