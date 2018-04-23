test.img: test.o Makefile
	objcopy -O binary $< $@

%.o: %.s Makefile
	as $< -o $@

clean:
	rm *.o
	rm *.img
