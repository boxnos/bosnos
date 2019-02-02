target=helloos.img

all: qemu

%.o: %.s Makefile
	as $< -o $@

%.img: %.o Makefile
	objcopy -O binary $< $@

qemu: $(target)
	qemu-system-i386 -drive format=raw,file=$<

clean:
	rm -f rasm
	rm -f helloos.img
	rm -f *.o

