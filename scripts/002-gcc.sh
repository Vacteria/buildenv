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
	
	for i in ${_lastsrc[@]}
	do
		extract ${i##*/}
		[ -z ${_inside_} ] && return 1
		mv -v ${_inside_} ${_inside_//-[0-9]*}
	done
	
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
	
	sed -i '/k prot/agcc_cv_libc_provides_ssp=yes' gcc/configure

	mkdir -v ../gcc-build
	cd ../gcc-build
}

pkg_compile()
{
	../gcc-${version}/configure \
    --target=${_ctarget} \
    --prefix=${_toolspath} \
    --with-sysroot=${_rootfs} \
    --with-newlib \
    --without-headers \
    --with-local-prefix=${_toolspath} \
    --with-native-system-header-dir=${_toolsinclude} \
    --disable-nls \
    --disable-shared \
    --disable-multilib \
    --disable-decimal-float \
    --disable-threads \
    --disable-libmudflap \
    --disable-libssp \
    --disable-libgomp \
    --disable-libquadmath \
    --enable-languages=c \
    --with-mpfr-include=$(pwd)/../gcc-${version}/mpfr/src \
    --with-mpfr-lib=$(pwd)/mpfr/src/.libs || stop
    
	make || stop
	make install || stop
	
	return 0
}

pkg_post_compile()
{
	ln -sv libgcc.a $( ${_ctarget}-gcc -print-libgcc-file-name | sed 's/libgcc/&_eh/' )
}
