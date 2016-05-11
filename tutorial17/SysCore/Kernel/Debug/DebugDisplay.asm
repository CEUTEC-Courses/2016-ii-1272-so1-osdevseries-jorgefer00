; Listing generated by Microsoft (R) Optimizing Compiler Version 16.00.30319.01 

	TITLE	C:\Documents and Settings\Jorge Fernandez\Desktop\Sistemas Operativos I\2016-ii-1272-so1-osdevseries-jorgefer00\tutorial17\SysCore\Kernel\DebugDisplay.cpp
	.686P
	.XMM
	include listing.inc
	.model	flat

INCLUDELIB MSVCRT
INCLUDELIB OLDNAMES

PUBLIC	?tbuf@@3PADA					; tbuf
PUBLIC	?video_memory@@3PAGA				; video_memory
PUBLIC	?cursor_x@@3EA					; cursor_x
PUBLIC	?cursor_y@@3EA					; cursor_y
PUBLIC	?_color@@3EA					; _color
PUBLIC	?bchars@@3PADA					; bchars
_BSS	SEGMENT
?tbuf@@3PADA DB	020H DUP (?)				; tbuf
?cursor_x@@3EA DB 01H DUP (?)				; cursor_x
	ALIGN	4

?cursor_y@@3EA DB 01H DUP (?)				; cursor_y
	ALIGN	4

?_color@@3EA DB	01H DUP (?)				; _color
_BSS	ENDS
_DATA	SEGMENT
?video_memory@@3PAGA DD 0b8000H				; video_memory
?bchars@@3PADA DB 030H					; bchars
	DB	031H
	DB	032H
	DB	033H
	DB	034H
	DB	035H
	DB	036H
	DB	037H
	DB	038H
	DB	039H
	DB	041H
	DB	042H
	DB	043H
	DB	044H
	DB	045H
	DB	046H
_DATA	ENDS
PUBLIC	?DebugUpdateCur@@YAXHH@Z			; DebugUpdateCur
; Function compile flags: /Ogspy
; File c:\documents and settings\jorge fernandez\desktop\sistemas operativos i\2016-ii-1272-so1-osdevseries-jorgefer00\tutorial17\syscore\kernel\debugdisplay.cpp
;	COMDAT ?DebugUpdateCur@@YAXHH@Z
_TEXT	SEGMENT
_x$ = 8							; size = 4
_y$ = 12						; size = 4
?DebugUpdateCur@@YAXHH@Z PROC				; DebugUpdateCur, COMDAT

; 61   : 
; 62   :     // get location
; 63   :     uint16_t cursorLocation = y * 80 + x;
; 64   : 
; 65   : #if 0
; 66   : 	// send location to vga controller to set cursor
; 67   : 	disable();
; 68   :     outportb(0x3D4, 14);
; 69   :     outportb(0x3D5, cursorLocation >> 8); // Send the high byte.
; 70   :     outportb(0x3D4, 15);
; 71   :     outportb(0x3D5, cursorLocation);      // Send the low byte.
; 72   : 	enable();
; 73   : #endif
; 74   : 
; 75   : }

	ret	0
?DebugUpdateCur@@YAXHH@Z ENDP				; DebugUpdateCur
_TEXT	ENDS
PUBLIC	?DebugPutc@@YAXE@Z				; DebugPutc
; Function compile flags: /Ogspy
;	COMDAT ?DebugPutc@@YAXE@Z
_TEXT	SEGMENT
_c$ = 8							; size = 1
?DebugPutc@@YAXE@Z PROC					; DebugPutc, COMDAT

; 79   : 
; 80   :     uint16_t attribute = _color << 8;

	movzx	eax, BYTE PTR ?_color@@3EA		; _color
	shl	ax, 8
	movzx	ecx, ax

; 81   : 
; 82   :     //! backspace character
; 83   :     if (c == 0x08 && cursor_x)

	mov	al, BYTE PTR _c$[esp-4]
	cmp	al, 8
	jne	SHORT $LN10@DebugPutc
	cmp	BYTE PTR ?cursor_x@@3EA, 0		; cursor_x
	je	SHORT $LN2@DebugPutc

; 84   :         cursor_x--;

	dec	BYTE PTR ?cursor_x@@3EA			; cursor_x
	jmp	SHORT $LN2@DebugPutc
$LN10@DebugPutc:

; 85   : 
; 86   :     //! tab character
; 87   :     else if (c == 0x09)

	cmp	al, 9
	jne	SHORT $LN8@DebugPutc

; 88   :         cursor_x = (cursor_x+8) & ~(8-1);

	mov	al, BYTE PTR ?cursor_x@@3EA		; cursor_x
	add	al, 8
	and	al, 248					; 000000f8H
	mov	BYTE PTR ?cursor_x@@3EA, al		; cursor_x
	jmp	SHORT $LN2@DebugPutc
$LN8@DebugPutc:

; 89   : 
; 90   :     //! carriage return
; 91   :     else if (c == '\r')

	cmp	al, 13					; 0000000dH

; 92   :         cursor_x = 0;

	je	SHORT $LN16@DebugPutc

; 93   : 
; 94   :     //! new line
; 95   : 	else if (c == '\n') {

	cmp	al, 10					; 0000000aH

; 96   :         cursor_x = 0;
; 97   :         cursor_y++;

	je	SHORT $LN17@DebugPutc

; 98   : 	}
; 99   : 
; 100  :     //! printable characters
; 101  :     else if(c >= ' ') {

	cmp	al, 32					; 00000020H
	jb	SHORT $LN2@DebugPutc

; 102  : 
; 103  : 		//! display character on screen
; 104  :         uint16_t* location = video_memory + (cursor_y*80 + cursor_x);
; 105  :         *location = c | attribute;

	movzx	edx, BYTE PTR ?cursor_x@@3EA		; cursor_x
	movzx	eax, al
	or	ax, cx
	movzx	ecx, BYTE PTR ?cursor_y@@3EA		; cursor_y
	imul	ecx, 80					; 00000050H
	add	ecx, edx
	mov	edx, DWORD PTR ?video_memory@@3PAGA	; video_memory
	mov	WORD PTR [edx+ecx*2], ax

; 106  :         cursor_x++;

	inc	BYTE PTR ?cursor_x@@3EA			; cursor_x
$LN2@DebugPutc:

; 107  :     }
; 108  : 
; 109  :     //! if we are at edge of row, go to new line
; 110  :     if (cursor_x >= 80) {

	cmp	BYTE PTR ?cursor_x@@3EA, 80		; cursor_x, 00000050H
	jb	SHORT $LN1@DebugPutc
$LN17@DebugPutc:

; 113  :         cursor_y++;

	inc	BYTE PTR ?cursor_y@@3EA			; cursor_y
$LN16@DebugPutc:

; 111  : 
; 112  :         cursor_x = 0;

	mov	BYTE PTR ?cursor_x@@3EA, 0		; cursor_x
$LN1@DebugPutc:

; 114  :     }
; 115  : 
; 116  :     //! update hardware cursor
; 117  : 	DebugUpdateCur (cursor_x,cursor_y);
; 118  : }

	ret	0
?DebugPutc@@YAXE@Z ENDP					; DebugPutc
_TEXT	ENDS
PUBLIC	?itoa@@YAXIIPAD@Z				; itoa
; Function compile flags: /Ogspy
;	COMDAT ?itoa@@YAXIIPAD@Z
_TEXT	SEGMENT
_i$ = 8							; size = 4
_base$ = 12						; size = 4
_buf$ = 16						; size = 4
?itoa@@YAXIIPAD@Z PROC					; itoa, COMDAT

; 124  : void itoa(unsigned i,unsigned base,char* buf) {

	push	ebp
	mov	ebp, esp

; 125  :    int pos = 0;
; 126  :    int opos = 0;
; 127  :    int top = 0;
; 128  : 
; 129  :    if (i == 0 || base > 16) {

	mov	eax, DWORD PTR _i$[ebp]
	xor	ecx, ecx
	test	eax, eax
	je	SHORT $LN6@itoa
	cmp	DWORD PTR _base$[ebp], 16		; 00000010H
	ja	SHORT $LN6@itoa
$LL5@itoa:

; 131  :       buf[1] = '\0';
; 132  :       return;
; 133  :    }
; 134  : 
; 135  :    while (i != 0) {
; 136  :       tbuf[pos] = bchars[i % base];

	xor	edx, edx
	div	DWORD PTR _base$[ebp]

; 137  :       pos++;

	inc	ecx
	mov	dl, BYTE PTR ?bchars@@3PADA[edx]
	mov	BYTE PTR ?tbuf@@3PADA[ecx-1], dl
	test	eax, eax
	jne	SHORT $LL5@itoa

; 141  :    for (opos=0; opos<top; pos--,opos++) {

	push	esi
	mov	esi, DWORD PTR _buf$[ebp]
	push	edi
	mov	edi, ecx
	test	edi, edi
	jle	SHORT $LN1@itoa

; 138  :       i /= base;
; 139  :    }
; 140  :    top=pos--;

	lea	ecx, DWORD PTR ?tbuf@@3PADA[ecx-1]
$LL3@itoa:

; 142  :       buf[opos] = tbuf[pos];

	mov	dl, BYTE PTR [ecx]
	dec	ecx
	mov	BYTE PTR [eax+esi], dl
	inc	eax
	cmp	eax, edi
	jl	SHORT $LL3@itoa
$LN1@itoa:
	pop	edi

; 143  :    }
; 144  :    buf[opos] = 0;

	mov	BYTE PTR [eax+esi], 0
	pop	esi

; 145  : }

	pop	ebp
	ret	0
$LN6@itoa:

; 130  :       buf[0] = '0';

	mov	eax, DWORD PTR _buf$[ebp]
	mov	WORD PTR [eax], 48			; 00000030H

; 145  : }

	pop	ebp
	ret	0
?itoa@@YAXIIPAD@Z ENDP					; itoa
_TEXT	ENDS
PUBLIC	?itoa_s@@YAXHIPAD@Z				; itoa_s
; Function compile flags: /Ogspy
;	COMDAT ?itoa_s@@YAXHIPAD@Z
_TEXT	SEGMENT
_i$ = 8							; size = 4
_base$ = 12						; size = 4
_buf$ = 16						; size = 4
?itoa_s@@YAXHIPAD@Z PROC				; itoa_s, COMDAT

; 147  : void itoa_s(int i,unsigned base,char* buf) {

	push	ebp
	mov	ebp, esp

; 148  :    if (base > 16) return;

	cmp	DWORD PTR _base$[ebp], 16		; 00000010H
	ja	SHORT $LN3@itoa_s

; 149  :    if (i < 0) {

	cmp	DWORD PTR _i$[ebp], 0
	jge	SHORT $LN1@itoa_s

; 150  :       *buf++ = '-';

	mov	eax, DWORD PTR _buf$[ebp]
	inc	DWORD PTR _buf$[ebp]

; 151  :       i *= -1;

	neg	DWORD PTR _i$[ebp]
	mov	BYTE PTR [eax], 45			; 0000002dH
$LN1@itoa_s:

; 154  : }

	pop	ebp

; 152  :    }
; 153  :    itoa(i,base,buf);

	jmp	?itoa@@YAXIIPAD@Z			; itoa
$LN3@itoa_s:

; 154  : }

	pop	ebp
	ret	0
?itoa_s@@YAXHIPAD@Z ENDP				; itoa_s
_TEXT	ENDS
PUBLIC	?DebugSetColor@@YAII@Z				; DebugSetColor
; Function compile flags: /Ogspy
;	COMDAT ?DebugSetColor@@YAII@Z
_TEXT	SEGMENT
_c$ = 8							; size = 4
?DebugSetColor@@YAII@Z PROC				; DebugSetColor, COMDAT

; 191  : 
; 192  : 	unsigned t=_color;
; 193  : 	_color=c;

	mov	cl, BYTE PTR _c$[esp-4]
	movzx	eax, BYTE PTR ?_color@@3EA		; _color
	mov	BYTE PTR ?_color@@3EA, cl		; _color

; 194  : 	return t;
; 195  : }

	ret	0
?DebugSetColor@@YAII@Z ENDP				; DebugSetColor
_TEXT	ENDS
PUBLIC	?DebugGotoXY@@YAXII@Z				; DebugGotoXY
; Function compile flags: /Ogspy
;	COMDAT ?DebugGotoXY@@YAXII@Z
_TEXT	SEGMENT
_x$ = 8							; size = 4
_y$ = 12						; size = 4
?DebugGotoXY@@YAXII@Z PROC				; DebugGotoXY, COMDAT

; 199  : 
; 200  : 	if (cursor_x <= 80)

	cmp	BYTE PTR ?cursor_x@@3EA, 80		; cursor_x, 00000050H
	ja	SHORT $LN2@DebugGotoX

; 201  : 	    cursor_x = x;

	mov	al, BYTE PTR _x$[esp-4]
	mov	BYTE PTR ?cursor_x@@3EA, al		; cursor_x
$LN2@DebugGotoX:

; 202  : 
; 203  : 	if (cursor_y <= 25)

	cmp	BYTE PTR ?cursor_y@@3EA, 25		; cursor_y, 00000019H
	ja	SHORT $LN1@DebugGotoX

; 204  : 	    cursor_y = y;

	mov	al, BYTE PTR _y$[esp-4]
	mov	BYTE PTR ?cursor_y@@3EA, al		; cursor_y
$LN1@DebugGotoX:

; 205  : 
; 206  : 	//! update hardware cursor to new position
; 207  : 	DebugUpdateCur (cursor_x, cursor_y);
; 208  : }

	ret	0
?DebugGotoXY@@YAXII@Z ENDP				; DebugGotoXY
_TEXT	ENDS
PUBLIC	?DebugClrScr@@YAXE@Z				; DebugClrScr
; Function compile flags: /Ogspy
;	COMDAT ?DebugClrScr@@YAXE@Z
_TEXT	SEGMENT
_c$ = 8							; size = 1
?DebugClrScr@@YAXE@Z PROC				; DebugClrScr, COMDAT

; 216  : 
; 217  :     //! move position back to start
; 218  :     DebugGotoXY (0,0);

	movzx	eax, BYTE PTR _c$[esp-4]
	shl	ax, 8
	or	ax, 32					; 00000020H
	xor	ecx, ecx
$LL3@DebugClrSc:

; 212  : 
; 213  : 	//! clear video memory by writing space characters to it
; 214  : 	for (int i = 0; i < 80*25; i++)
; 215  :         video_memory[i] = ' ' | (c << 8);

	mov	edx, DWORD PTR ?video_memory@@3PAGA	; video_memory
	mov	WORD PTR [ecx+edx], ax
	add	ecx, 2
	cmp	ecx, 4000				; 00000fa0H
	jl	SHORT $LL3@DebugClrSc

; 216  : 
; 217  :     //! move position back to start
; 218  :     DebugGotoXY (0,0);

	push	0
	push	0
	call	?DebugGotoXY@@YAXII@Z			; DebugGotoXY
	pop	ecx
	pop	ecx

; 219  : }

	ret	0
?DebugClrScr@@YAXE@Z ENDP				; DebugClrScr
_TEXT	ENDS
PUBLIC	?DebugPuts@@YAXPAD@Z				; DebugPuts
EXTRN	?strlen@@YAIPBD@Z:PROC				; strlen
; Function compile flags: /Ogspy
;	COMDAT ?DebugPuts@@YAXPAD@Z
_TEXT	SEGMENT
_str$ = 8						; size = 4
?DebugPuts@@YAXPAD@Z PROC				; DebugPuts, COMDAT

; 222  : void DebugPuts (char* str) {

	push	edi

; 223  : 
; 224  : 	if (!str)

	mov	edi, DWORD PTR _str$[esp]
	test	edi, edi
	je	SHORT $LN1@DebugPuts

; 225  : 		return;
; 226  : 
; 227  : 	//! err... displays a string
; 228  :     for (unsigned int i=0; i<strlen(str); i++)

	push	esi
	push	edi
	xor	esi, esi
	call	?strlen@@YAIPBD@Z			; strlen
	pop	ecx
	test	eax, eax
	je	SHORT $LN9@DebugPuts
$LL3@DebugPuts:

; 229  :         DebugPutc (str[i]);

	movzx	eax, BYTE PTR [esi+edi]
	push	eax
	call	?DebugPutc@@YAXE@Z			; DebugPutc
	push	edi
	inc	esi
	call	?strlen@@YAIPBD@Z			; strlen
	pop	ecx
	pop	ecx
	cmp	esi, eax
	jb	SHORT $LL3@DebugPuts
$LN9@DebugPuts:
	pop	esi
$LN1@DebugPuts:
	pop	edi

; 230  : }

	ret	0
?DebugPuts@@YAXPAD@Z ENDP				; DebugPuts
_TEXT	ENDS
PUBLIC	?DebugPrintf@@YAHPBDZZ				; DebugPrintf
EXTRN	?strcpy@@YAPADPADPBD@Z:PROC			; strcpy
; Function compile flags: /Ogspy
;	COMDAT ?DebugPrintf@@YAHPBDZZ
_TEXT	SEGMENT
_str$2731 = -64						; size = 64
_str$2752 = -32						; size = 32
_str$2742 = -32						; size = 32
_str$ = 8						; size = 4
?DebugPrintf@@YAHPBDZZ PROC				; DebugPrintf, COMDAT

; 233  : int DebugPrintf (const char* str, ...) {

	push	ebp
	mov	ebp, esp
	sub	esp, 64					; 00000040H
	push	edi

; 234  : 
; 235  : 	if(!str)

	mov	edi, DWORD PTR _str$[ebp]
	test	edi, edi
	jne	SHORT $LN15@DebugPrint

; 236  : 		return 0;

	xor	eax, eax
	jmp	$LN16@DebugPrint
$LN15@DebugPrint:
	push	ebx
	push	esi

; 240  : 	size_t i;
; 241  : 	for (i=0; i<strlen(str);i++) {

	push	edi
	xor	ebx, ebx
	call	?strlen@@YAIPBD@Z			; strlen
	pop	ecx
	test	eax, eax
	je	SHORT $LN12@DebugPrint

; 237  : 
; 238  : 	va_list		args;
; 239  : 	va_start (args, str);

	lea	esi, DWORD PTR _str$[ebp]
$LL14@DebugPrint:

; 242  : 
; 243  : 		switch (str[i]) {

	movzx	eax, BYTE PTR [ebx+edi]
	cmp	al, 37					; 00000025H
	je	SHORT $LN9@DebugPrint

; 292  : 				}
; 293  : 
; 294  : 				break;
; 295  : 
; 296  : 			default:
; 297  : 				DebugPutc (str[i]);

	push	eax
	call	?DebugPutc@@YAXE@Z			; DebugPutc
	pop	ecx

; 298  : 				break;

	jmp	SHORT $LN13@DebugPrint
$LN9@DebugPrint:

; 244  : 
; 245  : 			case '%':
; 246  : 
; 247  : 				switch (str[i+1]) {

	movsx	eax, BYTE PTR [ebx+edi+1]
	sub	eax, 88					; 00000058H
	je	SHORT $LN3@DebugPrint
	sub	eax, 11					; 0000000bH
	je	$LN6@DebugPrint
	dec	eax
	je	SHORT $LN4@DebugPrint
	sub	eax, 5
	je	SHORT $LN4@DebugPrint
	sub	eax, 10					; 0000000aH
	je	SHORT $LN5@DebugPrint
	sub	eax, 5
	jne	$LN2@DebugPrint
$LN3@DebugPrint:

; 276  : 					}
; 277  : 
; 278  : 					/*** display in hex ***/
; 279  : 					case 'X':
; 280  : 					case 'x': {
; 281  : 						int c = va_arg (args, int);
; 282  : 						char str[32]={0};

	push	7
	pop	ecx
	xor	eax, eax
	mov	BYTE PTR _str$2752[ebp], 0
	lea	edi, DWORD PTR _str$2752[ebp+1]
	rep stosd
	stosw
	stosb

; 283  : 						itoa_s (c,16,str);

	lea	eax, DWORD PTR _str$2752[ebp]
	push	eax
	push	16					; 00000010H
$LN25@DebugPrint:
	add	esi, 4
	push	DWORD PTR [esi]
	call	?itoa_s@@YAXHIPAD@Z			; itoa_s

; 284  : 						DebugPuts (str);

	lea	eax, DWORD PTR _str$2752[ebp]
	push	eax
	call	?DebugPuts@@YAXPAD@Z			; DebugPuts
	add	esp, 16					; 00000010H
$LN24@DebugPrint:

; 285  : 						i++;		// go to next character

	inc	ebx
$LN13@DebugPrint:

; 240  : 	size_t i;
; 241  : 	for (i=0; i<strlen(str);i++) {

	mov	edi, DWORD PTR _str$[ebp]
	push	edi
	inc	ebx
	call	?strlen@@YAIPBD@Z			; strlen
	pop	ecx
	cmp	ebx, eax
	jb	SHORT $LL14@DebugPrint
$LN12@DebugPrint:

; 299  : 		}
; 300  : 
; 301  : 	}
; 302  : 
; 303  : 	va_end (args);
; 304  : 	return i;

	mov	eax, ebx
$LN22@DebugPrint:
	pop	esi
	pop	ebx
$LN16@DebugPrint:
	pop	edi

; 305  : }

	leave
	ret	0
$LN5@DebugPrint:

; 255  : 					}
; 256  : 
; 257  : 					/*** address of ***/
; 258  : 					case 's': {
; 259  : 						int c = (int&) va_arg (args, char);

	add	esi, 4

; 260  : 						char str[64];
; 261  : 						strcpy (str,(const char*)c);

	push	DWORD PTR [esi]
	lea	eax, DWORD PTR _str$2731[ebp]
	push	eax
	call	?strcpy@@YAPADPADPBD@Z			; strcpy

; 262  : 						DebugPuts (str);

	lea	eax, DWORD PTR _str$2731[ebp]
	push	eax
	call	?DebugPuts@@YAXPAD@Z			; DebugPuts
	add	esp, 12					; 0000000cH

; 263  : 						i++;		// go to next character
; 264  : 						break;

	jmp	SHORT $LN24@DebugPrint
$LN4@DebugPrint:

; 265  : 					}
; 266  : 
; 267  : 					/*** integers ***/
; 268  : 					case 'd':
; 269  : 					case 'i': {
; 270  : 						int c = va_arg (args, int);
; 271  : 						char str[32]={0};

	push	7
	pop	ecx
	xor	eax, eax
	mov	BYTE PTR _str$2742[ebp], 0
	lea	edi, DWORD PTR _str$2742[ebp+1]
	rep stosd
	stosw
	stosb

; 272  : 						itoa_s (c, 10, str);

	lea	eax, DWORD PTR _str$2742[ebp]
	push	eax
	push	10					; 0000000aH

; 273  : 						DebugPuts (str);
; 274  : 						i++;		// go to next character
; 275  : 						break;

	jmp	SHORT $LN25@DebugPrint
$LN6@DebugPrint:

; 248  : 
; 249  : 					/*** characters ***/
; 250  : 					case 'c': {
; 251  : 						char c = va_arg (args, char);

	add	esi, 4

; 252  : 						DebugPutc (c);

	movzx	eax, BYTE PTR [esi]
	push	eax
	call	?DebugPutc@@YAXE@Z			; DebugPutc
	pop	ecx

; 253  : 						i++;		// go to next character
; 254  : 						break;

	jmp	SHORT $LN24@DebugPrint
$LN2@DebugPrint:

; 286  : 						break;
; 287  : 					}
; 288  : 
; 289  : 					default:
; 290  : 						va_end (args);
; 291  : 						return 1;

	xor	eax, eax
	inc	eax
	jmp	SHORT $LN22@DebugPrint
?DebugPrintf@@YAHPBDZZ ENDP				; DebugPrintf
_TEXT	ENDS
END
