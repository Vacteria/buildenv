#!/bin/bash

name="xz"
version="5.0.4"
sources="http://tukaani.org/xz/xz-${version}.tar.xz"

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
