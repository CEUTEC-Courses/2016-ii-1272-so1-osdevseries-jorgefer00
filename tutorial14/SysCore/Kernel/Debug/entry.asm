; Listing generated by Microsoft (R) Optimizing Compiler Version 16.00.30319.01 

	TITLE	C:\Documents and Settings\Jorge Fernandez\Desktop\Sistemas Operativos I\2016-ii-1272-so1-osdevseries-jorgefer00\tutorial14\SysCore\Kernel\entry.cpp
	.686P
	.XMM
	include listing.inc
	.model	flat

INCLUDELIB MSVCRT
INCLUDELIB OLDNAMES

PUBLIC	?kernel_entry@@YAXXZ				; kernel_entry
EXTRN	?Exit@@YAXXZ:PROC				; Exit
EXTRN	_main:PROC
EXTRN	?InitializeConstructors@@YAXXZ:PROC		; InitializeConstructors
; Function compile flags: /Ogtp
; File c:\documents and settings\jorge fernandez\desktop\sistemas operativos i\2016-ii-1272-so1-osdevseries-jorgefer00\tutorial14\syscore\kernel\entry.cpp
;	COMDAT ?kernel_entry@@YAXXZ
_TEXT	SEGMENT
?kernel_entry@@YAXXZ PROC				; kernel_entry, COMDAT

; 14   : 
; 15   : #ifdef ARCH_X86
; 16   : 	_asm {
; 17   : 		cli						// clear interrupts--Do not enable them yet

	cli

; 18   : 		mov ax, 10h				// offset 0x10 in gdt for data selector, remember?

	mov	ax, 16					; 00000010H

; 19   : 		mov ds, ax

	mov	ds, ax

; 20   : 		mov es, ax

	mov	es, ax

; 21   : 		mov fs, ax

	mov	fs, ax

; 22   : 		mov gs, ax

	mov	gs, ax

; 23   : 		mov ss, ax				// Set up base stack

	mov	ss, ax

; 24   : 		mov esp, 0x90000

	mov	esp, 589824				; 00090000H

; 25   : 		mov ebp, esp			// store current stack pointer

	mov	ebp, esp

; 26   : 		push ebp

	push	ebp

; 27   : 	}
; 28   : #endif
; 29   : 
; 30   : 	//! Execute global constructors
; 31   : 	InitializeConstructors();

	call	?InitializeConstructors@@YAXXZ		; InitializeConstructors

; 32   : 
; 33   : 	//!	Call kernel entry point
; 34   : 	main ();

	call	_main

; 35   : 
; 36   : 	//! Cleanup all dynamic dtors
; 37   : 	Exit ();

	call	?Exit@@YAXXZ				; Exit

; 38   : 
; 39   : #ifdef ARCH_X86
; 40   : 	_asm cli

	cli
	npad	4
$LL2@kernel_ent:

; 41   : #endif
; 42   : 	for (;;);

	jmp	SHORT $LL2@kernel_ent
?kernel_entry@@YAXXZ ENDP				; kernel_entry
_TEXT	ENDS
END
