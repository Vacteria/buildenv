#!/bin/bash

name="coreutils"
version="8.20"
sources="http://ftp.gnu.org/gnu/coreutils/coreutils-${version}.tar.xz"

pkg_compile()
{
	./configure \
	--prefix=${_toolspath} \
	--enable-install-program=hostname || stop

	make || stop
	make install || stop
	
	return 0
}
