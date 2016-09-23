#!/bin/bash

name="m4"
version="1.4.16"
sources="http://ftp.gnu.org/gnu/m4/m4-1.4.16.tar.bz2"

pkg_pre_compile()
{
	sed -i -e '/gets is a/d' lib/stdio.in.h
	
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
