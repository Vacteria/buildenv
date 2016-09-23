#!/bin/bash

name="wget"
version="1.13.4"
sources="http://ftp.gnu.org/gnu/wget/wget-${version}.tar.xz"

pkg_compile()
{
	find . -name stdio.in.h | xargs sed -i '/gets is a security hole/d'

	./configure \
	--prefix=${_toolspath} \
	--with-ssl=no
	
	make || stop
	make install || stop

	return 0
}
