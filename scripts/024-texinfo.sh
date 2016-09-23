#!/bin/bash

name="texinfo"
version="4.13a"
sources="http://ftp.gnu.org/gnu/texinfo/texinfo-${version}.tar.gz"

pkg_pre_compile()
{
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
