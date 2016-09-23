#!/bin/bash

name="tar"
version="1.26"
sources="http://ftp.gnu.org/gnu/tar/tar-${version}.tar.bz2"

pkg_pre_compile()
{
	sed -i -e '/gets is a/d' gnu/stdio.in.h
	
	return 0
}

pkg_compile()
{
	./configure \
	--prefix=${_toolspath} || stop

	make || stop
	make install || stop
	
	return 0
}
