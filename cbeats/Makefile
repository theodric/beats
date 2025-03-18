CC=gcc
CFLAGS=-Wall -Wextra -Ofast -std=c99
PREFIX=/usr/local
BINDIR=$(PREFIX)/bin

beats: beats.c
	$(CC) $(CFLAGS) -o beats beats.c

install: beats
	install -d $(DESTDIR)$(BINDIR)
	install -m 755 beats $(DESTDIR)$(BINDIR)/beats

uninstall:
	rm -f $(DESTDIR)$(BINDIR)/beats

clean:
	rm -f beats

.PHONY: install uninstall clean 
