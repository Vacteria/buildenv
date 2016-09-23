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
	../binutils-${version}/configure \
	--prefix=${_toolspath} \
    --with-sysroot=${_rootfs} \
    --with-lib-path=${_toolslib} \
    --target=${_ctarget} \
    --disable-nls \
    --disable-werror || stop
    
	make || stop
	
	case ${_bits} in
		64 ) 
			mkdir -v ${_toolslib}
			ln -sv lib ${_toolslib}64 || return 1
		;;
	esac
	
	make install || stop
	
	return 0
}
