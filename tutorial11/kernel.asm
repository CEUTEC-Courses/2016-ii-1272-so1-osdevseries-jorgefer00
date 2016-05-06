
;*******************************************************
;
;	Stage3.asm
;		A basic 32 bit binary kernel running
;
;	OS Development Series
;*******************************************************

org	0x100000			; Kernel starts at 1 MB

bits	32				; 32 bit code

jmp	Stage3				; jump to entry point

%include "stdio.inc"

msg db "Sistemas Operativos I - CEUTEC", 0x0A
db "                                    .&%%%%%%%&&&               ", 0x0A
db "                               &&%%###############%%&&           ", 0x0A
db "                           &&%%########################%&        ", 0x0A
db "                         &&%##############################%%     ", 0x0A
db "                       &%###################%  ##############%   ", 0x0A
db "                     ,&%################%#     ###############&& ", 0x0A
db "                    &############%#%         %%%%###########&&&", 0x0A
db "                   &&%#######      %##         %   %#########%&&&", 0x0A
db "                  &&%########      %#%         %   %#########%&&&", 0x0A
db "                 ,&########      %####%      #############%&&& ", 0x0A
db "                 &&%#########      %####%      #############&&&  ", 0x0A
db "                &&#########      %####%      ############%&&   ", 0x0A
db "                &&%##########      %####%      ###########%&&    ", 0x0A
db "                &&%##########       %##%%      #%#%#######&&     ", 0x0A
db "                 &%##########%          /#         %#####&&      ", 0x0A
db "                    %#########%.        %#%        %####%&       ", 0x0A
db "                      &%###############################%&        ", 0x0A
db "                         &&%%#########################%          ", 0x0A
db "                             &&&%%###################%           ", 0x0A
db "                                &&&&&&%%############.            ", 0x0A
db "                                    &&&&&&&&&%%%%%&              ", 0x0A
db "                                         &&&&&&&&   ", 0x0A
db "                                      Por 0x21041074", 0

Stage3:

	;-------------------------------;
	;   Set registers		;
	;-------------------------------;

	mov	ax, 0x10		; set data segments to data selector (0x10)
	mov	ds, ax
	mov	ss, ax
	mov	es, ax
	mov	esp, 90000h		; stack begins from 90000h

	;-------------------------------;
	;  Imprimir en modo protegido   ;
	;-------------------------------;

	call ClrScr32
	mov al, 0x1B
	mov ah, 0x01
	call GotoXY
	mov ebx, msg
	call Puts32

	;---------------------------------------;
	;   Stop execution			;
	;---------------------------------------;

	cli
	hlt


