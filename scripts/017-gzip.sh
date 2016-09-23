#!/bin/bash

name="gzip"
version="1.5"
sources="http://ftp.gnu.org/gnu/gzip/gzip-${version}.tar.xz"

pkg_compile()
{
	./configure \
	--prefix=${_toolspath} || stop

	make || stop
	make install || stop
	
	return 0
}
