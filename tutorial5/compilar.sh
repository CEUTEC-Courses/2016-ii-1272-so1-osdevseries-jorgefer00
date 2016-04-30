#!/bin/bash
nasm -f bin boot1.asm -o boot.bin
nasm -f bin boot2.asm -o boot2.bin
dd if=boot.bin of=floppy.img bs=512 count=1 conv=notrunc
dd if=boot2.bin of=floppy.img bs=512 seek=1 count=1 conv=notrunc
