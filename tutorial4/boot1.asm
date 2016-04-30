;**********************************************
; Bootloader Etapa 1
; CEUTEC - Sistemas Operativos 1
; Creado por Jorge Fernandez
;**********************************************

org 0x7c00 		;Estamos en la direccion 0x7c00
bits 16    		;16 bits real mode 

start: jmp loader

;*************************************************;
;	OEM Parameter block
;*************************************************;

; Error Fix 2 - Removing the ugly TIMES directive -------------------------------------

;;	TIMES 0Bh-$+start DB 0					; The OEM Parameter Block is exactally 3 bytes
								; from where we are loaded at. This fills in those
								; 3 bytes, along with 8 more. Why?

bpbOEM			db "TF141 OS"				; This member must be exactally 8 bytes. It is just
								; the name of your OS :) Everything else remains the same.

bpbBytesPerSector:  	DW 512
bpbSectorsPerCluster: 	DB 1
bpbReservedSectors: 	DW 1
bpbNumberOfFATs: 	    DB 2
bpbRootEntries: 	    DW 224
bpbTotalSectors: 	    DW 2880
bpbMedia: 	            DB 0xF0
bpbSectorsPerFAT: 	    DW 9
bpbSectorsPerTrack: 	DW 18
bpbHeadsPerCylinder: 	DW 2
bpbHiddenSectors: 	    DD 0
bpbTotalSectorsBig:     DD 0
bsDriveNumber: 	        DB 0
bsUnused: 	            DB 0
bsExtBootSignature: 	DB 0x29
bsSerialNumber:	        DD 0xa0a1a2a3
bsVolumeLabel: 	        DB "TF141 OS   "
bsFileSystem: 	        DB "FAT12   "

msg	db	"Bienvenido a mi sistema operativo", 0		; el string a imprimir

;***************************************
;	Prints a string
;	DS=>SI: 0 terminated string
;***************************************

Print:
			lodsb					; cargar el proximo byte de SI a AL
			or			al, al		; Es AL=0?
			jz			PrintDone	; Si es 0, entonces salirse.
			mov			ah,	0eh	; Si no, entonces imprimir el caracter
			int			10h
			jmp			Print		; Repetir hasta que AL sea 0
PrintDone:
			ret					; terminamos, asi que retornamos de funcion

;*************************************************;
;	Bootloader Entry Point
;*************************************************;


loader:
	xor	ax, ax		; Limpiamos los Segment registers DS y ES
	mov	ds, ax		
	mov	es, ax		
				

	mov	si, msg						; el mensaje a imprimir
	call	Print						; llamamos la funcion print.

	xor	ax, ax						; limpiar AX
	int	0x12						; tomamos el tamaño de la memoria de la BIOS con este Interruptor

	cli 		; Limpiamos los interruptores
	hlt 		; Paramos el procesador

times 510 - ($-$$) db 0	; Llenamos de 0's el resto del codigo para ser 512 bytes
dw 0xAA55		; Firma de que es un bootloader valido.
