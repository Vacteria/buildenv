#!/bin/bash

name="patch"
version="2.7.1"
sources="http://ftp.gnu.org/gnu/patch/patch-${version}.tar.xz"

pkg_compile()
{
	./configure \
	--prefix=${_toolspath} || stop

	make || stop
	make install || stop
	
	return 0
}
