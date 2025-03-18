AS=as
ASFLAGS=
LD=ld
PREFIX=/usr/local
BINDIR=$(PREFIX)/bin

beats: beats.o
	$(LD) -o beats beats.o

beats.o: beats_aarch64.asm
	$(AS) $(ASFLAGS) -o beats.o beats_aarch64.asm

install: beats
	install -d $(DESTDIR)$(BINDIR)
	install -m 755 beats $(DESTDIR)$(BINDIR)/beats

uninstall:
	rm -f $(DESTDIR)$(BINDIR)/beats

clean:
	rm -f beats beats.o

.PHONY: install uninstall clean
