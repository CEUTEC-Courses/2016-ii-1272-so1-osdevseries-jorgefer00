; Listing generated by Microsoft (R) Optimizing Compiler Version 14.00.50727.42 

	TITLE	c:\Documents and Settings\Michael\Desktop\bte_lighter\Demos\Demo11\SysCore\Kernel\vmmngr_pde.cpp
	.686P
	.XMM
	include listing.inc
	.model	flat

INCLUDELIB LIBCMT
INCLUDELIB OLDNAMES

PUBLIC	?pd_entry_add_attrib@@YAXPAII@Z			; pd_entry_add_attrib
; Function compile flags: /Ogtpy
; File c:\documents and settings\michael\desktop\bte_lighter\demos\demo11\syscore\kernel\vmmngr_pde.cpp
;	COMDAT ?pd_entry_add_attrib@@YAXPAII@Z
_TEXT	SEGMENT
_e$ = 8							; size = 4
_attrib$ = 12						; size = 4
?pd_entry_add_attrib@@YAXPAII@Z PROC			; pd_entry_add_attrib, COMDAT

; 44   : 	*e |= attrib;

	mov	eax, DWORD PTR _e$[esp-4]
	mov	ecx, DWORD PTR _attrib$[esp-4]
	or	DWORD PTR [eax], ecx

; 45   : }

	ret	0
?pd_entry_add_attrib@@YAXPAII@Z ENDP			; pd_entry_add_attrib
_TEXT	ENDS
PUBLIC	?pd_entry_del_attrib@@YAXPAII@Z			; pd_entry_del_attrib
; Function compile flags: /Ogtpy
;	COMDAT ?pd_entry_del_attrib@@YAXPAII@Z
_TEXT	SEGMENT
_e$ = 8							; size = 4
_attrib$ = 12						; size = 4
?pd_entry_del_attrib@@YAXPAII@Z PROC			; pd_entry_del_attrib, COMDAT

; 48   : 	*e &= ~attrib;

	mov	ecx, DWORD PTR _attrib$[esp-4]
	mov	eax, DWORD PTR _e$[esp-4]
	not	ecx
	and	DWORD PTR [eax], ecx

; 49   : }

	ret	0
?pd_entry_del_attrib@@YAXPAII@Z ENDP			; pd_entry_del_attrib
_TEXT	ENDS
PUBLIC	?pd_entry_set_frame@@YAXPAII@Z			; pd_entry_set_frame
; Function compile flags: /Ogtpy
;	COMDAT ?pd_entry_set_frame@@YAXPAII@Z
_TEXT	SEGMENT
_e$ = 8							; size = 4
_addr$ = 12						; size = 4
?pd_entry_set_frame@@YAXPAII@Z PROC			; pd_entry_set_frame, COMDAT

; 52   : 	*e = (*e & ~I86_PDE_FRAME) | addr;

	mov	eax, DWORD PTR _e$[esp-4]
	mov	ecx, DWORD PTR [eax]
	and	ecx, -2147479553			; 80000fffH
	or	ecx, DWORD PTR _addr$[esp-4]
	mov	DWORD PTR [eax], ecx

; 53   : }

	ret	0
?pd_entry_set_frame@@YAXPAII@Z ENDP			; pd_entry_set_frame
_TEXT	ENDS
PUBLIC	?pd_entry_is_present@@YA_NI@Z			; pd_entry_is_present
; Function compile flags: /Ogtpy
;	COMDAT ?pd_entry_is_present@@YA_NI@Z
_TEXT	SEGMENT
_e$ = 8							; size = 4
?pd_entry_is_present@@YA_NI@Z PROC			; pd_entry_is_present, COMDAT

; 56   : 	return e & I86_PDE_PRESENT;

	mov	eax, DWORD PTR _e$[esp-4]
	and	eax, 1

; 57   : }

	ret	0
?pd_entry_is_present@@YA_NI@Z ENDP			; pd_entry_is_present
_TEXT	ENDS
PUBLIC	?pd_entry_is_writable@@YA_NI@Z			; pd_entry_is_writable
; Function compile flags: /Ogtpy
;	COMDAT ?pd_entry_is_writable@@YA_NI@Z
_TEXT	SEGMENT
_e$ = 8							; size = 4
?pd_entry_is_writable@@YA_NI@Z PROC			; pd_entry_is_writable, COMDAT

; 60   : 	return e & I86_PDE_WRITABLE;

	mov	eax, DWORD PTR _e$[esp-4]
	shr	eax, 1
	and	al, 1

; 61   : }

	ret	0
?pd_entry_is_writable@@YA_NI@Z ENDP			; pd_entry_is_writable
_TEXT	ENDS
PUBLIC	?pd_entry_pfn@@YAII@Z				; pd_entry_pfn
; Function compile flags: /Ogtpy
;	COMDAT ?pd_entry_pfn@@YAII@Z
_TEXT	SEGMENT
_e$ = 8							; size = 4
?pd_entry_pfn@@YAII@Z PROC				; pd_entry_pfn, COMDAT

; 64   : 	return e & I86_PDE_FRAME;

	mov	eax, DWORD PTR _e$[esp-4]
	and	eax, 2147479552				; 7ffff000H

; 65   : }

	ret	0
?pd_entry_pfn@@YAII@Z ENDP				; pd_entry_pfn
_TEXT	ENDS
PUBLIC	?pd_entry_is_user@@YA_NI@Z			; pd_entry_is_user
; Function compile flags: /Ogtpy
;	COMDAT ?pd_entry_is_user@@YA_NI@Z
_TEXT	SEGMENT
_e$ = 8							; size = 4
?pd_entry_is_user@@YA_NI@Z PROC				; pd_entry_is_user, COMDAT

; 68   : 	return e & I86_PDE_USER;

	mov	eax, DWORD PTR _e$[esp-4]
	shr	eax, 2
	and	al, 1

; 69   : }

	ret	0
?pd_entry_is_user@@YA_NI@Z ENDP				; pd_entry_is_user
_TEXT	ENDS
PUBLIC	?pd_entry_is_4mb@@YA_NI@Z			; pd_entry_is_4mb
; Function compile flags: /Ogtpy
;	COMDAT ?pd_entry_is_4mb@@YA_NI@Z
_TEXT	SEGMENT
_e$ = 8							; size = 4
?pd_entry_is_4mb@@YA_NI@Z PROC				; pd_entry_is_4mb, COMDAT

; 72   : 	return e & I86_PDE_4MB;

	mov	eax, DWORD PTR _e$[esp-4]
	shr	eax, 7
	and	al, 1

; 73   : }

	ret	0
?pd_entry_is_4mb@@YA_NI@Z ENDP				; pd_entry_is_4mb
_TEXT	ENDS
PUBLIC	?pd_entry_enable_global@@YAXI@Z			; pd_entry_enable_global
; Function compile flags: /Ogtpy
;	COMDAT ?pd_entry_enable_global@@YAXI@Z
_TEXT	SEGMENT
_e$ = 8							; size = 4
?pd_entry_enable_global@@YAXI@Z PROC			; pd_entry_enable_global, COMDAT

; 76   : 
; 77   : }

	ret	0
?pd_entry_enable_global@@YAXI@Z ENDP			; pd_entry_enable_global
_TEXT	ENDS
END