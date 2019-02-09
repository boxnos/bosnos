target=helloos.img

all: qemu

%.o: %.s Makefile

boot.bin: boot.o link.ls Makefile
	ld -nostdlib -o $@ -T link.ls $<

$(target) : boot.bin Makefile
	# rm -f $@
	# mkdosfs -C -F 12 $@ 2880
	dd if=/dev/zero of=$@ bs=512 count=2880
	mkdosfs -F 12 $@ 1440
	dd if=$< of=$@ bs=512 count=1 conv=notrunc

qemu: $(target)
	qemu-system-i386 -drive format=raw,file=$<

clean:
	rm -f *.bin
	rm -f *.img
	rm -f *.o

