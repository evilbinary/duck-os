##########################################################################################
# Project: Duck OS
# Makefile evilbinary
# Mail:rootntsd@gmail.com
##########################################################################################

.PHONY: build

build: boot init kernel
	@echo "build success"

kernel: kernel.ss
	./build.sh compile.ss kernel

boot: boot.ss
	./build.sh compile.ss boot

init: init.ss
	./build.sh compile.ss init

run: image
	bochs -q -f ./bochsrc

runq: image
	qemu-system-i386 -fda build/boot.img

image: build
	dd if=build/boot bs=512 count=1 conv=notrunc of=build/boot.img
	dd if=build/init bs=512 count=10 seek=1 conv=notrunc of=build/boot.img
	dd if=build/kernel bs=512 count=10 seek=9 conv=notrunc of=build/boot.img
