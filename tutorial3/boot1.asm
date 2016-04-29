;**********************************************
; Bootloader Etapa 1
; CEUTEC - Sistemas Operativos 1
; Creado por Jorge Fernandez
;**********************************************

org 0x7c00 		;Estamos en la direccion 0x7c00
bits 16    		;16 bits real mode 

Start:
	cli 		; Limpiamos los interruptores
	hlt 		; Paramos el procesador

times 510 - ($-$$) db 0	; Llenamos de 0's el resto del codigo para ser 512 bytes
dw 0xAA55		; Firma de que es un bootloader valido.
