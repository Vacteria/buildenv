#!/bin/bash

name="perl"
version="5.16.2"
sources="http://www.cpan.org/src/5.0/perl-${version}.tar.bz2"
patches="http://dev.vacteria.org/patches/perl-${version}-libc-1.patch"

pkg_compile()
{
	sh Configure -des -Dprefix=${_toolspath} || stop
	
	make || stop

	cp -v perl cpan/podlators/pod2man ${_toolsbin}
	mkdir -pv ${_toolslib}/perl5/${version}
	cp -Rv lib/* ${_toolslib}/perl5/${version}
	
	return 0
}
