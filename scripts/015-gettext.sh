#!/bin/bash

name="gettext"
version="0.18.2"
sources="http://ftp.gnu.org/gnu/gettext/gettext-${version}.tar.gz"

pkg_compile()
{
	cd gettext-tools
	EMACS="no" ./configure \
	--prefix=${_toolspath} \
	--disable-shared \
	--disable-acl || stop

	make -C gnulib-lib                   || stop
	make -C src msgfmt msgmerge xgettext || stop

	install -m 0755 src/{msgfmt,msgmerge,xgettext} ${_toolsbin} || return 1

	cd ../gettext-runtime
	EMACS="no" ./configure \
	--prefix=${_toolspath} \
	--disable-shared || stop

	make -C gnulib-lib  || stop
	make -C src gettext 
	install -m 0755 src/gettext ${_toolsbin} || return 1
	
	return 0
}
