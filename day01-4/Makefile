target=helloos.img

all: qemu

%.o: %.s Makefile

%.img: %.o Makefile
	objcopy -O binary $< $@

qemu: $(target)
	qemu-system-i386 -drive format=raw,file=$<

clean:
	rm -f *.img
	rm -f *.o

