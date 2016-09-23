#!/bin/bash

name="nano"
version="2.3.1"
sources="http://www.nano-editor.org/dist/v2.3/nano-${version}.tar.gz"

pkg_compile()
{
	./configure \
	--prefix=${_toolspath} || stop
	
	make || stop
	make install || stop

	return 0
}
