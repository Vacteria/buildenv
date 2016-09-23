#!/bin/bash

name="linux"
version="3.7.1"
sources="http://www.kernel.org/pub/linux/kernel/v3.x/linux-${version}.tar.xz"

pkg_pre_compile()
{
	make mrproper
	
	return 0
}

pkg_compile()
{
	make headers_check
	make INSTALL_HDR_PATH=dest headers_install
	cp -rv dest/include/* ${_toolsinclude}

	return 0
}
