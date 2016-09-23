#!/bin/bash

name="binutils"
version="2.23.1"
sources="http://ftp.gnu.org/gnu/binutils/binutils-${version}.tar.bz2"

pkg_pre_compile()
{
	mkdir -v ../binutils-build || return 1
	cd ../binutils-build       || return 1
	
	return 0
}

pkg_compile()
{
	CC=${_ctarget}-gcc \
	AR=${_ctarget}-ar \
	RANLIB=${_ctarget}-ranlib \
	../binutils-${version}/configure \
	--prefix=${_toolspath} \
	--disable-nls \
	--with-lib-path=${_toolslib}
    
    
	make || stop	
	make install || stop

	return 0
}

pkg_post_compile()
{
	make -C ld clean                  || return 1
	make -C ld LIB_PATH=/usr/lib:/lib || return 1
	cp -v ld/ld-new ${_toolsbin}      || return 1
	
	return 0
}
