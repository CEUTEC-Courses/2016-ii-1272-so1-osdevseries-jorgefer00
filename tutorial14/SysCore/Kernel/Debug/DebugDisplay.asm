; Listing generated by Microsoft (R) Optimizing Compiler Version 16.00.30319.01 

	TITLE	C:\Documents and Settings\Jorge Fernandez\Desktop\Sistemas Operativos I\2016-ii-1272-so1-osdevseries-jorgefer00\tutorial14\SysCore\Kernel\DebugDisplay.cpp
	.686P
	.XMM
	include listing.inc
	.model	flat

INCLUDELIB MSVCRT
INCLUDELIB OLDNAMES

PUBLIC	?tbuf@@3PADA					; tbuf
PUBLIC	?bchars@@3PADA					; bchars
_BSS	SEGMENT
?tbuf@@3PADA DB	020H DUP (?)				; tbuf
__xPos	DD	01H DUP (?)
__yPos	DD	01H DUP (?)
__startX DD	01H DUP (?)
__startY DD	01H DUP (?)
__color	DD	01H DUP (?)
_BSS	ENDS
_DATA	SEGMENT
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
PUBLIC	?DebugPutc@@YAXE@Z				; DebugPutc
; Function compile flags: /Ogtpy
; File c:\documents and settings\jorge fernandez\desktop\sistemas operativos i\2016-ii-1272-so1-osdevseries-jorgefer00\tutorial14\syscore\kernel\debugdisplay.cpp
;	COMDAT ?DebugPutc@@YAXE@Z
_TEXT	SEGMENT
_c$ = 8							; size = 1
?DebugPutc@@YAXE@Z PROC					; DebugPutc, COMDAT

; 58   : 
; 59   : 	if (c==0)

	mov	dl, BYTE PTR _c$[esp-4]
	test	dl, dl
	je	SHORT $LN5@DebugPutc

; 60   : 		return;
; 61   : 
; 62   : 	if (c == '\n'||c=='\r') {	/* start new line */

	cmp	dl, 10					; 0000000aH
	je	SHORT $LN2@DebugPutc
	cmp	dl, 13					; 0000000dH
	je	SHORT $LN2@DebugPutc

; 65   : 		return;
; 66   : 	}
; 67   : 
; 68   : 	if (_xPos > 79) {			/* start new line */

	mov	ecx, DWORD PTR __xPos
	cmp	ecx, 79					; 0000004fH
	jbe	SHORT $LN1@DebugPutc

; 69   : 		_yPos+=2;
; 70   : 		_xPos=_startX;

	mov	eax, DWORD PTR __startX
	add	DWORD PTR __yPos, 2
	mov	DWORD PTR __xPos, eax

; 78   : }

	ret	0
$LN1@DebugPutc:

; 71   : 		return;
; 72   : 	}
; 73   : 
; 74   : 	/* draw the character */
; 75   : 	unsigned char* p = (unsigned char*)VID_MEMORY + (_xPos++)*2 + _yPos * 80;

	mov	eax, DWORD PTR __yPos
	lea	eax, DWORD PTR [eax+eax*4]
	lea	eax, DWORD PTR [ecx+eax*8]
	inc	ecx
	lea	eax, DWORD PTR [eax+eax+753664]
	mov	DWORD PTR __xPos, ecx

; 76   : 	*p++ = c;
; 77   : 	*p =_color;

	mov	cl, BYTE PTR __color
	mov	BYTE PTR [eax], dl
	mov	BYTE PTR [eax+1], cl

; 78   : }

	ret	0
$LN2@DebugPutc:

; 63   : 		_yPos+=2;
; 64   : 		_xPos=_startX;

	mov	edx, DWORD PTR __startX
	add	DWORD PTR __yPos, 2
	mov	DWORD PTR __xPos, edx
$LN5@DebugPutc:

; 78   : }

	ret	0
?DebugPutc@@YAXE@Z ENDP					; DebugPutc
_TEXT	ENDS
PUBLIC	?itoa@@YAXIIPAD@Z				; itoa
; Function compile flags: /Ogtpy
;	COMDAT ?itoa@@YAXIIPAD@Z
_TEXT	SEGMENT
_i$ = 8							; size = 4
_base$ = 12						; size = 4
_buf$ = 16						; size = 4
?itoa@@YAXIIPAD@Z PROC					; itoa, COMDAT

; 84   :    int pos = 0;
; 85   :    int opos = 0;
; 86   :    int top = 0;
; 87   : 
; 88   :    if (i == 0 || base > 16) {

	mov	eax, DWORD PTR _i$[esp-4]
	xor	ecx, ecx
	push	esi
	test	eax, eax
	je	SHORT $LN6@itoa
	mov	esi, DWORD PTR _base$[esp]
	cmp	esi, 16					; 00000010H
	ja	SHORT $LN6@itoa
$LL5@itoa:

; 90   :       buf[1] = '\0';
; 91   :       return;
; 92   :    }
; 93   : 
; 94   :    while (i != 0) {
; 95   :       tbuf[pos] = bchars[i % base];

	xor	edx, edx
	div	esi

; 96   :       pos++;

	inc	ecx
	mov	dl, BYTE PTR ?bchars@@3PADA[edx]
	mov	BYTE PTR ?tbuf@@3PADA[ecx-1], dl
	test	eax, eax
	jne	SHORT $LL5@itoa

; 97   :       i /= base;
; 98   :    }
; 99   :    top=pos--;

	mov	esi, ecx
	push	edi

; 100  :    for (opos=0; opos<top; pos--,opos++) {

	mov	edi, DWORD PTR _buf$[esp+4]
	test	esi, esi
	jle	SHORT $LN1@itoa

; 97   :       i /= base;
; 98   :    }
; 99   :    top=pos--;

	lea	ecx, DWORD PTR ?tbuf@@3PADA[ecx-1]
	npad	6
$LL3@itoa:

; 101  :       buf[opos] = tbuf[pos];

	mov	dl, BYTE PTR [ecx]
	mov	BYTE PTR [eax+edi], dl
	inc	eax
	dec	ecx
	cmp	eax, esi
	jl	SHORT $LL3@itoa
$LN1@itoa:

; 102  :    }
; 103  :    buf[opos] = 0;

	mov	BYTE PTR [eax+edi], 0
	pop	edi
	pop	esi

; 104  : }

	ret	0
$LN6@itoa:

; 89   :       buf[0] = '0';

	mov	eax, DWORD PTR _buf$[esp]
	mov	WORD PTR [eax], 48			; 00000030H
	pop	esi

; 104  : }

	ret	0
?itoa@@YAXIIPAD@Z ENDP					; itoa
_TEXT	ENDS
PUBLIC	?itoa_s@@YAXHIPAD@Z				; itoa_s
; Function compile flags: /Ogtpy
;	COMDAT ?itoa_s@@YAXHIPAD@Z
_TEXT	SEGMENT
_i$ = 8							; size = 4
_base$ = 12						; size = 4
_buf$ = 16						; size = 4
?itoa_s@@YAXHIPAD@Z PROC				; itoa_s, COMDAT

; 107  :    if (base > 16) return;

	mov	edx, DWORD PTR _base$[esp-4]
	cmp	edx, 16					; 00000010H
	ja	SHORT $LN3@itoa_s

; 108  :    if (i < 0) {

	mov	eax, DWORD PTR _i$[esp-4]

; 109  :       *buf++ = '-';

	mov	ecx, DWORD PTR _buf$[esp-4]
	test	eax, eax
	jns	SHORT $LN1@itoa_s
	mov	BYTE PTR [ecx], 45			; 0000002dH
	inc	ecx

; 110  :       i *= -1;

	neg	eax
$LN1@itoa_s:

; 111  :    }
; 112  :    itoa(i,base,buf);

	mov	DWORD PTR _buf$[esp-4], ecx
	mov	DWORD PTR _base$[esp-4], edx
	mov	DWORD PTR _i$[esp-4], eax
	jmp	?itoa@@YAXIIPAD@Z			; itoa
$LN3@itoa_s:

; 113  : }

	ret	0
?itoa_s@@YAXHIPAD@Z ENDP				; itoa_s
_TEXT	ENDS
PUBLIC	?DebugSetColor@@YAII@Z				; DebugSetColor
; Function compile flags: /Ogtpy
;	COMDAT ?DebugSetColor@@YAII@Z
_TEXT	SEGMENT
_c$ = 8							; size = 4
?DebugSetColor@@YAII@Z PROC				; DebugSetColor, COMDAT

; 120  : 
; 121  : 	unsigned t=_color;
; 122  : 	_color=c;

	mov	ecx, DWORD PTR _c$[esp-4]
	mov	eax, DWORD PTR __color
	mov	DWORD PTR __color, ecx

; 123  : 	return t;
; 124  : }

	ret	0
?DebugSetColor@@YAII@Z ENDP				; DebugSetColor
_TEXT	ENDS
PUBLIC	?DebugGotoXY@@YAXII@Z				; DebugGotoXY
; Function compile flags: /Ogtpy
;	COMDAT ?DebugGotoXY@@YAXII@Z
_TEXT	SEGMENT
_x$ = 8							; size = 4
_y$ = 12						; size = 4
?DebugGotoXY@@YAXII@Z PROC				; DebugGotoXY, COMDAT

; 127  : 
; 128  : 	// reposition starting vectors for next text to follow
; 129  : 	// multiply by 2 do to the video modes 2byte per character layout
; 130  : 	_xPos = x*2;

	mov	eax, DWORD PTR _x$[esp-4]

; 131  : 	_yPos = y*2;

	mov	ecx, DWORD PTR _y$[esp-4]
	add	eax, eax
	add	ecx, ecx
	mov	DWORD PTR __xPos, eax
	mov	DWORD PTR __yPos, ecx

; 132  : 	_startX=_xPos;

	mov	DWORD PTR __startX, eax

; 133  : 	_startY=_yPos;

	mov	DWORD PTR __startY, ecx

; 134  : }

	ret	0
?DebugGotoXY@@YAXII@Z ENDP				; DebugGotoXY
_TEXT	ENDS
PUBLIC	?DebugClrScr@@YAXG@Z				; DebugClrScr
; Function compile flags: /Ogtpy
;	COMDAT ?DebugClrScr@@YAXG@Z
_TEXT	SEGMENT
_c$ = 8							; size = 2
?DebugClrScr@@YAXG@Z PROC				; DebugClrScr, COMDAT

; 137  : 
; 138  : 	unsigned char* p = (unsigned char*)VID_MEMORY;
; 139  : 
; 140  : 	for (int i=0; i<160*30; i+=2) {

	mov	dl, BYTE PTR _c$[esp-4]
	mov	eax, 753665				; 000b8001H
	mov	ecx, 2400				; 00000960H
	npad	2
$LL3@DebugClrSc:

; 141  : 
; 142  : 		p[i] = ' ';  /* Need to watch out for MSVC++ optomization memset() call */

	mov	BYTE PTR [eax-1], 32			; 00000020H

; 143  : 		p[i+1] = c;

	mov	BYTE PTR [eax], dl
	add	eax, 2
	dec	ecx
	jne	SHORT $LL3@DebugClrSc

; 144  : 	}
; 145  : 
; 146  : 	// go to start of previous set vector
; 147  : 	_xPos=_startX;_yPos=_startY;

	mov	eax, DWORD PTR __startX
	mov	ecx, DWORD PTR __startY
	mov	DWORD PTR __xPos, eax
	mov	DWORD PTR __yPos, ecx

; 148  : }

	ret	0
?DebugClrScr@@YAXG@Z ENDP				; DebugClrScr
_TEXT	ENDS
PUBLIC	?DebugPuts@@YAXPAD@Z				; DebugPuts
EXTRN	?strlen@@YAIPBD@Z:PROC				; strlen
; Function compile flags: /Ogtpy
;	COMDAT ?DebugPuts@@YAXPAD@Z
_TEXT	SEGMENT
_str$ = 8						; size = 4
?DebugPuts@@YAXPAD@Z PROC				; DebugPuts, COMDAT

; 150  : void DebugPuts (char* str) {

	push	edi

; 151  : 
; 152  : 	if (!str)

	mov	edi, DWORD PTR _str$[esp]
	test	edi, edi
	je	SHORT $LN1@DebugPuts

; 153  : 		return;
; 154  : 
; 155  : 	for (size_t i=0; i<strlen (str); i++)

	push	esi
	push	edi
	xor	esi, esi
	call	?strlen@@YAIPBD@Z			; strlen
	add	esp, 4
	test	eax, eax
	je	SHORT $LN15@DebugPuts
	push	ebx
	lea	ebx, DWORD PTR [esi+2]
	npad	3
$LL3@DebugPuts:

; 156  : 		DebugPutc (str[i]);

	mov	al, BYTE PTR [esi+edi]
	test	al, al
	je	SHORT $LN2@DebugPuts
	cmp	al, 10					; 0000000aH
	je	SHORT $LN8@DebugPuts
	cmp	al, 13					; 0000000dH
	je	SHORT $LN8@DebugPuts
	mov	edx, DWORD PTR __xPos
	cmp	edx, 79					; 0000004fH
	ja	SHORT $LN8@DebugPuts
	mov	ecx, DWORD PTR __yPos
	lea	ecx, DWORD PTR [ecx+ecx*4]
	lea	ecx, DWORD PTR [edx+ecx*8]
	inc	edx
	lea	ecx, DWORD PTR [ecx+ecx+753664]
	mov	DWORD PTR __xPos, edx
	mov	dl, BYTE PTR __color
	mov	BYTE PTR [ecx], al
	mov	BYTE PTR [ecx+1], dl
	jmp	SHORT $LN2@DebugPuts
$LN8@DebugPuts:
	mov	eax, DWORD PTR __startX
	add	DWORD PTR __yPos, ebx
	mov	DWORD PTR __xPos, eax
$LN2@DebugPuts:

; 153  : 		return;
; 154  : 
; 155  : 	for (size_t i=0; i<strlen (str); i++)

	push	edi
	inc	esi
	call	?strlen@@YAIPBD@Z			; strlen
	add	esp, 4
	cmp	esi, eax
	jb	SHORT $LL3@DebugPuts
	pop	ebx
$LN15@DebugPuts:
	pop	esi
$LN1@DebugPuts:
	pop	edi

; 157  : }

	ret	0
?DebugPuts@@YAXPAD@Z ENDP				; DebugPuts
_TEXT	ENDS
PUBLIC	?DebugPrintf@@YAHPBDZZ				; DebugPrintf
; Function compile flags: /Ogtpy
;	COMDAT ?DebugPrintf@@YAHPBDZZ
_TEXT	SEGMENT
_i$2620 = -40						; size = 4
tv612 = -36						; size = 4
_str$2672 = -32						; size = 32
_str$2662 = -32						; size = 32
_str$2652 = -32						; size = 32
_str$ = 8						; size = 4
?DebugPrintf@@YAHPBDZZ PROC				; DebugPrintf, COMDAT

; 159  : int DebugPrintf (const char* str, ...) {

	sub	esp, 40					; 00000028H
	push	ebx
	push	edi

; 160  : 
; 161  : 	if(!str)

	mov	edi, DWORD PTR _str$[esp+44]
	xor	ebx, ebx
	cmp	edi, ebx
	jne	SHORT $LN15@DebugPrint

; 162  : 		return 0;

	pop	edi
	xor	eax, eax
	pop	ebx

; 225  : 		}
; 226  : 
; 227  : 	}
; 228  : 
; 229  : 	va_end (args);
; 230  : }

	add	esp, 40					; 00000028H
	ret	0
$LN15@DebugPrint:
	push	ebp

; 166  : 
; 167  : 	for (size_t i=0; i<strlen(str);i++) {

	xor	ebp, ebp
	push	edi
	mov	DWORD PTR _i$2620[esp+56], ebp
	call	?strlen@@YAIPBD@Z			; strlen
	add	esp, 4
	test	eax, eax
	je	$LN81@DebugPrint

; 163  : 
; 164  : 	va_list		args;
; 165  : 	va_start (args, str);

	push	esi
	lea	esi, DWORD PTR _str$[esp+52]
$LL14@DebugPrint:

; 168  : 
; 169  : 		switch (str[i]) {

	movzx	eax, BYTE PTR [edi+ebp]
	cmp	al, 37					; 00000025H
	je	SHORT $LN9@DebugPrint

; 218  : 				}
; 219  : 
; 220  : 				break;
; 221  : 
; 222  : 			default:
; 223  : 				DebugPutc (str[i]);

	push	eax
	call	?DebugPutc@@YAXE@Z			; DebugPutc
	add	esp, 4

; 224  : 				break;

	jmp	$LN13@DebugPrint
$LN9@DebugPrint:

; 170  : 
; 171  : 			case '%':
; 172  : 
; 173  : 				switch (str[i+1]) {

	movsx	eax, BYTE PTR [edi+ebp+1]
	add	eax, -88				; ffffffa8H
	cmp	eax, 32					; 00000020H
	ja	$LN2@DebugPrint
	movzx	eax, BYTE PTR $LN80@DebugPrint[eax]
	jmp	DWORD PTR $LN84@DebugPrint[eax*4]
$LN6@DebugPrint:

; 174  : 
; 175  : 					/*** characters ***/
; 176  : 					case 'c': {
; 177  : 						char c = va_arg (args, char);
; 178  : 						DebugPutc (c);

	movzx	ecx, BYTE PTR [esi+4]
	add	esi, 4
	push	ecx
	call	?DebugPutc@@YAXE@Z			; DebugPutc

; 179  : 						i++;		// go to next character
; 180  : 						break;

	jmp	$LN83@DebugPrint
$LN5@DebugPrint:

; 181  : 					}
; 182  : 
; 183  : 					/*** address of ***/
; 184  : 					case 's': {
; 185  : 						int c = (int&) va_arg (args, char);
; 186  : 						char str[32]={0};

	xor	eax, eax
	add	esi, 4
	mov	DWORD PTR _str$2652[esp+57], eax
	mov	DWORD PTR _str$2652[esp+61], eax
	mov	DWORD PTR _str$2652[esp+65], eax
	mov	DWORD PTR _str$2652[esp+69], eax
	mov	DWORD PTR _str$2652[esp+73], eax
	mov	DWORD PTR _str$2652[esp+77], eax
	mov	DWORD PTR _str$2652[esp+81], eax
	mov	WORD PTR _str$2652[esp+85], ax
	mov	BYTE PTR _str$2652[esp+87], al

; 187  : 						itoa_s (c, 16, str);

	mov	eax, DWORD PTR [esi]
	mov	DWORD PTR tv612[esp+56], esi
	mov	BYTE PTR _str$2652[esp+56], bl
	lea	edi, DWORD PTR _str$2652[esp+56]
	cmp	eax, ebx
	jge	SHORT $LN18@DebugPrint
	mov	BYTE PTR _str$2652[esp+56], 45		; 0000002dH
	lea	edi, DWORD PTR _str$2652[esp+57]
	neg	eax
$LN18@DebugPrint:
	xor	ecx, ecx
	cmp	eax, ebx
	je	$LN53@DebugPrint
	npad	4
$LL26@DebugPrint:
	mov	edx, eax
	and	edx, 15					; 0000000fH
	mov	dl, BYTE PTR ?bchars@@3PADA[edx]
	mov	BYTE PTR ?tbuf@@3PADA[ecx], dl
	shr	eax, 4
	inc	ecx
	cmp	eax, ebx
	jne	SHORT $LL26@DebugPrint
	mov	esi, ecx
	xor	eax, eax
	cmp	esi, ebx
	jle	SHORT $LN22@DebugPrint
	lea	ecx, DWORD PTR ?tbuf@@3PADA[ecx-1]
$LL24@DebugPrint:
	mov	dl, BYTE PTR [ecx]
	mov	BYTE PTR [eax+edi], dl
	inc	eax
	dec	ecx
	cmp	eax, esi
	jl	SHORT $LL24@DebugPrint
$LN22@DebugPrint:
	mov	ebp, DWORD PTR _i$2620[esp+56]
	mov	esi, DWORD PTR tv612[esp+56]
	mov	BYTE PTR [eax+edi], bl
	jmp	$LN55@DebugPrint
$LN4@DebugPrint:

; 188  : 						DebugPuts (str);
; 189  : 						i++;		// go to next character
; 190  : 						break;
; 191  : 					}
; 192  : 
; 193  : 					/*** integers ***/
; 194  : 					case 'd':
; 195  : 					case 'i': {
; 196  : 						int c = va_arg (args, int);
; 197  : 						char str[32]={0};
; 198  : 						itoa_s (c, 10, str);

	mov	ecx, DWORD PTR [esi+4]
	xor	eax, eax
	add	esi, 4
	mov	DWORD PTR tv612[esp+56], esi
	mov	BYTE PTR _str$2662[esp+56], bl
	mov	DWORD PTR _str$2662[esp+57], eax
	mov	DWORD PTR _str$2662[esp+61], eax
	mov	DWORD PTR _str$2662[esp+65], eax
	mov	DWORD PTR _str$2662[esp+69], eax
	mov	DWORD PTR _str$2662[esp+73], eax
	mov	DWORD PTR _str$2662[esp+77], eax
	mov	DWORD PTR _str$2662[esp+81], eax
	mov	WORD PTR _str$2662[esp+85], ax
	mov	BYTE PTR _str$2662[esp+87], al
	lea	ebp, DWORD PTR _str$2662[esp+56]
	cmp	ecx, ebx
	jge	SHORT $LN31@DebugPrint
	mov	BYTE PTR _str$2662[esp+56], 45		; 0000002dH
	lea	ebp, DWORD PTR _str$2662[esp+57]
	neg	ecx
$LN31@DebugPrint:
	xor	esi, esi
	cmp	ecx, ebx
	je	SHORT $LN40@DebugPrint
$LL39@DebugPrint:
	mov	eax, -858993459				; cccccccdH
	mul	ecx
	shr	edx, 3
	lea	eax, DWORD PTR [edx+edx*4]
	add	eax, eax
	sub	ecx, eax
	mov	cl, BYTE PTR ?bchars@@3PADA[ecx]
	mov	BYTE PTR ?tbuf@@3PADA[esi], cl
	mov	ecx, edx
	inc	esi
	cmp	ecx, ebx
	jne	SHORT $LL39@DebugPrint
	mov	edi, esi
	xor	eax, eax
	cmp	edi, ebx
	jle	SHORT $LN35@DebugPrint
	lea	ecx, DWORD PTR ?tbuf@@3PADA[esi-1]
$LL37@DebugPrint:
	mov	dl, BYTE PTR [ecx]
	mov	BYTE PTR [eax+ebp], dl
	inc	eax
	dec	ecx
	cmp	eax, edi
	jl	SHORT $LL37@DebugPrint
$LN35@DebugPrint:
	mov	BYTE PTR [eax+ebp], bl
	jmp	SHORT $LN42@DebugPrint
$LN40@DebugPrint:
	mov	WORD PTR [ebp], 48			; 00000030H
$LN42@DebugPrint:

; 199  : 						DebugPuts (str);

	lea	eax, DWORD PTR _str$2662[esp+56]
	push	eax
	call	?DebugPuts@@YAXPAD@Z			; DebugPuts

; 200  : 						i++;		// go to next character
; 201  : 						break;

	mov	esi, DWORD PTR tv612[esp+60]
	mov	edi, DWORD PTR _str$[esp+56]
	add	esp, 4
	inc	DWORD PTR _i$2620[esp+56]
	mov	ebp, DWORD PTR _i$2620[esp+56]
	jmp	$LN13@DebugPrint
$LN3@DebugPrint:

; 202  : 					}
; 203  : 
; 204  : 					/*** display in hex ***/
; 205  : 					case 'X':
; 206  : 					case 'x': {
; 207  : 						int c = va_arg (args, int);
; 208  : 						char str[32]={0};

	xor	eax, eax
	add	esi, 4
	mov	DWORD PTR _str$2672[esp+57], eax
	mov	DWORD PTR _str$2672[esp+61], eax
	mov	DWORD PTR _str$2672[esp+65], eax
	mov	DWORD PTR _str$2672[esp+69], eax
	mov	DWORD PTR _str$2672[esp+73], eax
	mov	DWORD PTR _str$2672[esp+77], eax
	mov	DWORD PTR _str$2672[esp+81], eax
	mov	WORD PTR _str$2672[esp+85], ax
	mov	BYTE PTR _str$2672[esp+87], al

; 209  : 						itoa_s (c,16,str);

	mov	eax, DWORD PTR [esi]
	mov	DWORD PTR tv612[esp+56], esi
	mov	BYTE PTR _str$2672[esp+56], bl
	lea	edi, DWORD PTR _str$2672[esp+56]
	cmp	eax, ebx
	jge	SHORT $LN44@DebugPrint
	mov	BYTE PTR _str$2672[esp+56], 45		; 0000002dH
	lea	edi, DWORD PTR _str$2672[esp+57]
	neg	eax
$LN44@DebugPrint:
	xor	ecx, ecx
	cmp	eax, ebx
	je	SHORT $LN53@DebugPrint
	npad	9
$LL52@DebugPrint:
	mov	edx, eax
	and	edx, 15					; 0000000fH
	mov	dl, BYTE PTR ?bchars@@3PADA[edx]
	mov	BYTE PTR ?tbuf@@3PADA[ecx], dl
	shr	eax, 4
	inc	ecx
	cmp	eax, ebx
	jne	SHORT $LL52@DebugPrint
	mov	esi, ecx
	xor	eax, eax
	cmp	esi, ebx
	jle	SHORT $LN48@DebugPrint
	lea	ecx, DWORD PTR ?tbuf@@3PADA[ecx-1]
$LL50@DebugPrint:
	mov	dl, BYTE PTR [ecx]
	mov	BYTE PTR [eax+edi], dl
	inc	eax
	dec	ecx
	cmp	eax, esi
	jl	SHORT $LL50@DebugPrint
$LN48@DebugPrint:
	mov	ebp, DWORD PTR _i$2620[esp+56]
	mov	esi, DWORD PTR tv612[esp+56]
	mov	BYTE PTR [eax+edi], bl
	jmp	SHORT $LN55@DebugPrint
$LN53@DebugPrint:
	mov	WORD PTR [edi], 48			; 00000030H
$LN55@DebugPrint:

; 210  : 						DebugPuts (str);

	lea	eax, DWORD PTR _str$2672[esp+56]
	push	eax
	call	?DebugPuts@@YAXPAD@Z			; DebugPuts

; 211  : 						i++;		// go to next character

	mov	edi, DWORD PTR _str$[esp+56]
$LN83@DebugPrint:
	add	esp, 4
	inc	ebp
$LN13@DebugPrint:

; 166  : 
; 167  : 	for (size_t i=0; i<strlen(str);i++) {

	inc	ebp
	push	edi
	mov	DWORD PTR _i$2620[esp+60], ebp
	call	?strlen@@YAIPBD@Z			; strlen
	add	esp, 4
	cmp	ebp, eax
	jb	$LL14@DebugPrint
	pop	esi
	pop	ebp
	pop	edi
	pop	ebx

; 225  : 		}
; 226  : 
; 227  : 	}
; 228  : 
; 229  : 	va_end (args);
; 230  : }

	add	esp, 40					; 00000028H
	ret	0
$LN2@DebugPrint:

; 212  : 						break;
; 213  : 					}
; 214  : 
; 215  : 					default:
; 216  : 						va_end (args);
; 217  : 						return 1;

	mov	eax, 1
	pop	esi
$LN81@DebugPrint:
	pop	ebp
	pop	edi
	pop	ebx

; 225  : 		}
; 226  : 
; 227  : 	}
; 228  : 
; 229  : 	va_end (args);
; 230  : }

	add	esp, 40					; 00000028H
	ret	0
	npad	3
$LN84@DebugPrint:
	DD	$LN3@DebugPrint
	DD	$LN6@DebugPrint
	DD	$LN4@DebugPrint
	DD	$LN5@DebugPrint
	DD	$LN2@DebugPrint
$LN80@DebugPrint:
	DB	0
	DB	4
	DB	4
	DB	4
	DB	4
	DB	4
	DB	4
	DB	4
	DB	4
	DB	4
	DB	4
	DB	1
	DB	2
	DB	4
	DB	4
	DB	4
	DB	4
	DB	2
	DB	4
	DB	4
	DB	4
	DB	4
	DB	4
	DB	4
	DB	4
	DB	4
	DB	4
	DB	3
	DB	4
	DB	4
	DB	4
	DB	4
	DB	0
?DebugPrintf@@YAHPBDZZ ENDP				; DebugPrintf
_TEXT	ENDS
END
