#!/bin/bash

name="bash"
version="4.2"
sources="http://ftp.gnu.org/gnu/bash/bash-${version}.tar.gz"
patches="http://dev.vacteria.org/patches//bash-4.2-fixes-10.patch"

pkg_compile()
{
	./configure \
	--prefix=${_toolspath} \
	--without-bash-malloc || stop

	make || stop
	make install || stop
	
	return 0
}

pkg_post_compile()
{
	ln -sv bash ${_toolsbin}/sh
}
