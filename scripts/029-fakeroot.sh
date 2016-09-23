#!/bin/bash

name="fakeroot"
version="1.18.4"
sources="http://ftp.de.debian.org/debian/pool/main/f/fakeroot/fakeroot_${version}.orig.tar.bz2"

pkg_compile()
{
	./configure \
	--prefix=${_toolspath} \
	--disable-static \
	--disable-shared \
	--with-ipc=sysv
	
	make || stop
	make install || stop
	
	return 0
}
