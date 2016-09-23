#!/bin/bash

name="sed"
version="4.2.2"
sources="http://ftp.gnu.org/gnu/sed/sed-${version}.tar.bz2"

pkg_compile()
{
	./configure \
	--prefix=${_toolspath} || stop

	make || stop
	make install || stop
	
	return 0
}
