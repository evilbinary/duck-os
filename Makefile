##########################################################################################
# Project: Duck OS
# Makefile evilbinary
# Mail:rootntsd@gmail.com
##########################################################################################

.PHONY: build

build: boot kernel
	@echo "build success"

kernel: kernel.ss
	./build.sh compile.ss kernel

boot: boot.ss
	./build.sh compile.ss boot

run: image
	bochs -q -f ./bochsrc

image: build
	dd if=build/boot bs=512 count=2880 conv=notrunc of=build/boot.img
