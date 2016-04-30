#!/bin/bash
nasm -f bin boot1.asm -o boot.bin
dd if=boot.bin of=floppy.img bs=512 count=1 conv=notrunc
