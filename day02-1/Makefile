target=helloos.img

all: qemu

%.o: %.s Makefile

%.img: %.o link.ls Makefile
	ld -nostdlib -o $@ -T link.ls $<

qemu: $(target)
	qemu-system-i386 -drive format=raw,file=$<

clean:
	rm -f *.img
	rm -f *.o

