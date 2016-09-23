#!/bin/bash

name="grep"
version="2.14"
sources="http://ftp.gnu.org/gnu/grep/grep-2.14.tar.xz"

pkg_compile()
{
	./configure \
	--prefix=${_toolspath} || stop

	make || stop
	make install || stop
	
	return 0
}
