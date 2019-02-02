target=helloos2.img
# target=helloos2.img

all: qemu

helloos2.s: helloos.img rasm Makefile
	./rasm $< > $@

%.o: %.s Makefile
	as $< -o $@

%.img: %.o Makefile
	objcopy -O binary $< $@

qemu: $(target)
	qemu-system-i386 -drive format=raw,file=$<

clean:
	rm -f rasm
	rm -f helloos?.img
	rm -f helloos2.s
	rm -f *.o

