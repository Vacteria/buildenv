#!/bin/bash

name="findutils"
version="4.4.2"
sources="http://ftp.gnu.org/gnu/findutils/findutils-${version}.tar.gz"

pkg_compile()
{
	./configure \
	--prefix=${_toolspath} || stop

	make || stop
	make install || stop
	
	return 0
}
