#{AFREE Prototype : Kernel}
#{Version 2010.000}
#{Lukas 'skywaker/lukove' Veselovsky}
#{Under a GPLv2 license WITTHOUT WARRANTY}

nasm -f elf stub.asm -o stub.o

fpc -Aelf -n -O3 -Op3 -Si -Sc -Sg -Xd -Rintel -Tlinux kernel.pas
ld -Tlinker.script -o kernel.obj stub.o kernel.o boot.o system.o vgacons.o vgaconsex.o
