#!/bin/bash

name="eglibc"
version="2.17"
sources="http://dev.vacteria.org/sources/eglibc-${version}.tar.xz"

pkg_pre_compile()
{
	mkdir -v ../glibc-build
	cd ../glibc-build

	return 0
}

pkg_compile()
{
	../eglibc-${version}/configure \
      --prefix=${_toolspath} \
      --host=${_ctarget} \
      --build=$(../glibc-${version}/scripts/config.guess) \
      --disable-profile \
      --enable-kernel=2.6.25 \
      --with-headers=${_toolsinclude} \
      libc_cv_forced_unwind=yes \
      libc_cv_ctors_header=yes \
      libc_cv_c_cleanup=yes

	make || stop
	make install || stop
	
	return 0
}

pkg_post_compile()
{
	echo 'main(){}' > dummy.c
	${_ctarget}-gcc dummy.c

	out=$(readelf -l a.out | grep ": ${_toolspath}" | tr -d '[,]' | sed -e 's/.*: //g')
	case ${_bits} in
		64 ) ld="${_toolslib}64/ld-linux-x86-64.so.2" ;;
		32 ) ld="${_toolslib}/ld-linux.so.2"        ;;
	esac
	
	if [ "${out}" != "${ld}" ]
	then
		error "New compiler temporal test failed.\nOutput is %s\nAnd linker is %s" ${out} ${ld}
		stop
	else
		msg "Temporal linker is %s\nAnd ld linker is %s" ${out} ${ld}
	fi

	rm -v dummy.c a.out
	
	return 0
}
