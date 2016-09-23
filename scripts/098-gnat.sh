#!/bin/bash

case ${_bits} in
	32 )
		name="gnat-gpl-2011-i686-gnu"
		version="linux-libc2.3-bin"
	;;
	64 )
		name="gnat-gpl-2010-x86_64-pc"
		version="linux-gnu-bin"
	;;
esac
sources="http://dev.vacteria.org/sources/${name}-${version}.tar.gz"

pkg_compile()
{
	make ins-all prefix=${_toolspath}/gnat || stop
	
	return 0
}
