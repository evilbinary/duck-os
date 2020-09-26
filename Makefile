##########################################################################################
# Project: Duck OS
# Makefile evilbinary
# Mail:rootntsd@gmail.com
##########################################################################################

.PHONY: build

build: start main
	@echo "build success"

main: kernel/main.ss kernel/gdt.ss kernel/kalloc.ss kernel/task.ss
	./compiler/compile.sh compile.ss  kernel/main

start: boot init
	@echo build start success

boot: start/boot.ss
	./compiler/compile.sh compile.ss start/boot

init: start/init.ss
	./compiler/compile.sh compile.ss start/init

run: image
	bochs -q -f ./bochsrc

runq: image
	qemu-system-i386 -fda build/duck-os.img

image: build
	dd if=build/start/boot bs=512 count=1 conv=notrunc of=build/duck-os.img
	dd if=build/start/init bs=512 count=10 seek=1 conv=notrunc of=build/duck-os.img
	dd if=build/kernel/main bs=512 count=10 seek=9 conv=notrunc of=build/duck-os.img


clean:
	rm -rf build/start/*
	rm -rf build/kernel/*
	