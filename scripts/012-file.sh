#!/bin/bash

name="file"
version="5.11"
sources="ftp://ftp.astron.com/pub/file/file-${version}.tar.gz"

pkg_compile()
{
	./configure \
	--prefix=${_toolspath} || stop

	make || stop
	make install || stop
	
	return 0
}
