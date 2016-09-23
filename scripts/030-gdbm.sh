#!/bin/bash

name="gdbm"
version="1.10"
sources="ftp://ftp.gnu.org/gnu/gdbm/gdbm-${version}.tar.gz"

pkg_compile()
{
	./configure \
	--prefix=${_toolspath} \
	--enable-libgdbm-compat

	make prefix=${_toolspath} || stop
	make install || stop
	
	return 0
}
