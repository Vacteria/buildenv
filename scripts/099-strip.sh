#!/bin/bash

pkg_hook()
{
	strip --strip-debug ${_toolspath}/lib/*
	strip --strip-unneeded ${_toolspath}/{,s}bin/*
	rm -rf ${_toolspath}/{,share}/{info,man,doc}

	find ${_rootfs}${_toolspath} | grep -E "*${_ctarget}*" | xargs rm -rvf

	[ -f ${_stagedir}/${_uname}-${_distro}-linux-gnu.tar.xz ] && \
	rm -f ${_stagedir}/${_uname}-${_distro}-linux-gnu.tar.xz
	
	case ${_bits} in
		32 ) defdist="pc" ;;
		64 ) defdist="unknow" ;;
	esac
	filepath="${_stagedir}/${_uname}-${defdist}-linux-gnu.tar.xz"
	
	[ -f "${filepath}" ] && rm -f "${filepath}"	
	tar -C ${_rootfs} -cJvf ${filepath} toolchain || return 1
	
	return 0
}
