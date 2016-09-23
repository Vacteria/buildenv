#!/bin/bash

name="gcc"
version="4.7.2"
mpfrver="3.1.1"
gmpver="5.1.0"
mpcver="1.0.1"
sources="
	http://ftp.gnu.org/gnu/gcc/gcc-${version}/gcc-${version}.tar.bz2
	ftp://ftp.gmplib.org/pub/gmp-${gmpver}/gmp-${gmpver}.tar.xz
	http://www.mpfr.org/mpfr-${mpfrver}/mpfr-${mpfrver}.tar.xz
	http://www.multiprecision.org/mpc/download/mpc-${mpcver}.tar.gz
"

pkg_pre_compile()
{
	local i file

	cat gcc/limitx.h gcc/glimits.h gcc/limity.h > \
	$(dirname $( ${_ctarget}-gcc -print-libgcc-file-name))/include-fixed/limits.h

	cp -v gcc/Makefile.in{,.tmp}
	sed 's/^T_CFLAGS =$/& -fomit-frame-pointer/' gcc/Makefile.in.tmp \
	> gcc/Makefile.in

	for file in $(find gcc/config -name linux64.h -o -name linux.h -o -name sysv4.h)
	do
		cp -uv $file{,.orig}
		sed \
			-e 's@/lib\(64\)\?\(32\)\?/ld@/toolchain&@g' \
			-e 's@/usr@/toolchain@g' $file.orig > $file
		echo '
#undef STANDARD_STARTFILE_PREFIX_1
#undef STANDARD_STARTFILE_PREFIX_2
#define STANDARD_STARTFILE_PREFIX_1 "/toolchain/lib/"
#define STANDARD_STARTFILE_PREFIX_2 ""' >> $file
		touch $file.orig
	done
	  
	for i in ${_lastsrc[@]}
	do
		extract ${_tmpdir}/${i##*/}
		mv ${_inside_} ${_inside_//-[0-9]*} || return 1
	done
	
	mkdir -v ../gcc-build
	cd ../gcc-build
	
	return 0
}

pkg_compile()
{
	CC=${_ctarget}-gcc \
	AR=${_ctarget}-ar \
	RANLIB=${_ctarget}-ranlib \
	../gcc-${version}/configure \
    --prefix=${_toolspath} \
    --with-local-prefix=${_toolspath}  \
    --with-native-system-header-dir=${_toolsinclude} \
    --enable-clocale=gnu \
    --enable-shared \
    --enable-threads=posix \
    --enable-__cxa_atexit \
    --enable-languages=c,c++ \
    --disable-libstdcxx-pch \
    --disable-multilib \
    --disable-bootstrap \
    --disable-libgomp \
    --with-mpfr-include=$(pwd)/../gcc-${version}/mpfr/src \
    --with-mpfr-lib=$(pwd)/mpfr/src/.libs || stop
    
	make || stop
	make install || stop
	
	return 0
}

pkg_post_compile()
{
	ln -sv gcc ${_toolsbin}/cc

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
