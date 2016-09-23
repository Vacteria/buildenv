#!/bin/bash

name="diffutils"
version="3.2"
sources="http://ftp.gnu.org/gnu/diffutils/diffutils-${version}.tar.gz"

pkg_pre_compile()
{
	sed -i -e '/gets is a/d' lib/stdio.in.h || return 1
	
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
