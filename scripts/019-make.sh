#!/bin/bash

name="make"
version="3.82"
sources="http://ftp.gnu.org/gnu/make/make-${version}.tar.bz2"

pkg_compile()
{
	./configure \
	--prefix=${_toolspath} || stop

	make || stop
	make install || stop
	
	return 0
}
