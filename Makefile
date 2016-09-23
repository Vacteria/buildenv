#!/usr/bin/make -f

DESTDIR =
HOME = /usr/share/buildenv
SBIN = /usr/sbin

install :
	mkdir -p $(DESTDIR)/$(HOME)/backend
	mkdir -p $(DESTDIR)/$(HOME)/scripts
	mkdir -p $(DESTDIR)/$(SBIN)
	
	install -m 0755 buildenv.in $(DESTDIR)/$(SBIN)/buildenv
	install -m 0644 backend/* $(DESTDIR)/$(HOME)/backend
	install -m 0644 scripts/* $(DESTDIR)/$(HOME)/scripts
