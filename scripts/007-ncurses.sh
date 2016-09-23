#!/bin/bash

name="ncurses"
version="5.9"
sources="ftp://ftp.gnu.org/gnu/ncurses/ncurses-${version}.tar.gz"

pkg_compile()
{
	./configure \
	--prefix=${_toolspath} \
	--with-shared \
	--without-debug \
	--without-ada \
	--enable-overwrite || stop

	make || stop
	make install || stop
	
	return 0
}
