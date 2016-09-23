#!/bin/bash

name="vpm"
version="1.0alpha2"
sources="http://vacteria.org/hg/vpm/archive/tip.tar.bz2"

pkg_compile()
{
	make PREFIX=${_toolspath} || stop
	make PREFIX=${_toolspath} install || stop

	return 0
}
