#!/bin/bash
nasm -f bin boot1.asm -o boot.bin
nasm -f bin boot2.asm -o KRNLDR.SYS
dd if=boot.bin of=floppy.img bs=512 count=1 conv=notrunc
sudo mount floppy.img floppy_temp
sudo cp -v KRNLDR.SYS floppy_temp/
sleep 1
sudo umount floppy_temp
