@echo off
nasm -f bin boot1.asm -o boot.bin
nasm -f bin boot2.asm -o KRNLDR.SYS
nasm -f bin kernel.asm -o KRNL.SYS
dd if=boot.bin of=floppy.img bs=512 count=1 conv=notrunc seek=0
vfd.exe OPEN A: floppy.img /W /1.44
copy KRNLDR.SYS A:
vfd.exe CLOSE A: 
pause