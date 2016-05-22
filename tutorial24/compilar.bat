@echo off
nasm -f bin boot1.asm -o boot.bin
nasm -f bin boot2.asm -o KRNLDR.SYS
dd if=boot.bin of=floppy.img bs=512 count=1 conv=notrunc seek=0
vfd.exe OPEN A: floppy.img /W /1.44
copy KRNLDR.SYS A:
copy "SysCore\debug\Kernel.exe" "A:\KRNL32.EXE"
copy "SysCore\debug\proc.exe" "A:\proc.EXE"
copy demo.txt A:
vfd.exe CLOSE A: 
pause