#!/bin/bash

name="bzip2"
version="1.0.6"
sources="http://www.bzip.org/${version}/bzip2-${version}.tar.gz"

pkg_compile()
{
	make || stop
	make PREFIX=${_toolspath} install || stop
	
	return 0
}
