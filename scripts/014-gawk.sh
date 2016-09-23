#!/bin/bash

name="gawk"
version="4.0.2"
sources="http://ftp.gnu.org/gnu/gawk/gawk-${version}.tar.xz"

pkg_compile()
{
	./configure \
	--prefix=${_toolspath} || stop

	make || stop
	make install || stop
	
	return 0
}
