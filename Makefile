##########################################################################################
# Project: Duck OS
# Makefile evilbinary
# Mail:rootntsd@gmail.com
##########################################################################################

.PHONY: build

build: boot.ss
	./build.sh make.ss
	@echo "build success"

run: image
	bochs -q -f ./bochsrc

image: build
	dd if=build/boot bs=512 count=2880 conv=notrunc of=build/boot.img
