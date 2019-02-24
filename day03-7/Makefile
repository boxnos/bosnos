target=helloos.img

all: qemu

%.o: %.s Makefile

boot.bin: boot.o boot.ls Makefile
	ld -nostdlib -o $@ -T boot.ls $<

boxnos.sys: boxnos.o boxnos.s Makefile
	ld -nostdlib -o $@ -T boxnos.ls $<

$(target) : boot.bin boxnos.sys Makefile
	# rm -f $@
	# mkdosfs -C -F 12 $@ 2880
	dd if=/dev/zero of=$@ bs=512 count=2880
	mkdosfs -F 12 $@ 1440
	dd if=$< of=$@ bs=512 count=1 conv=notrunc
	mcopy boxnos.sys -i $@ ::

qemu: $(target)
	qemu-system-i386 -drive file=$<,format=raw,if=floppy -boot a

clean:
	rm -f *.bin
	rm -f *.img
	rm -f *.o

