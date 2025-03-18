ASM=nasm
ASMFLAGS=-f elf64
LD=ld
PREFIX=/usr/local
BINDIR=$(PREFIX)/bin

beats: beats.o
	$(LD) -o beats beats.o

beats.o: beats.asm
	$(ASM) $(ASMFLAGS) beats.asm

install: beats
	install -d $(DESTDIR)$(BINDIR)
	install -m 755 beats $(DESTDIR)$(BINDIR)/beats

uninstall:
	rm -f $(DESTDIR)$(BINDIR)/beats

clean:
	rm -f beats beats.o

.PHONY: install uninstall clean 
