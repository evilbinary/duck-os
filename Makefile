##########################################################################################
# Project: Duck OS
# Makefile evilbinary
# Mail:rootntsd@gmail.com
##########################################################################################

.PHONY: build

build: boot loader kernel
	@echo "build success"

kernel: kernel.ss
	./build.sh compile.ss kernel

boot: boot.ss
	./build.sh compile.ss boot

loader: loader.ss
	./build.sh compile.ss loader

run: image
	bochs -q -f ./bochsrc

runq: image
	qemu-system-i386 -fda build/boot.img

image: build
	dd if=build/boot bs=512 count=1 conv=notrunc of=build/boot.img
	dd if=build/loader bs=512 count=10 seek=1 conv=notrunc of=build/boot.img
	dd if=build/kernel bs=512 count=10 seek=9 conv=notrunc of=build/boot.img
