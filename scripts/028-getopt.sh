name="getopt"
version="1.1.4"
sources="http://software.frodo.looijaard.name/getopt/files/getopt-${version}.tar.gz"

pkg_compile()
{
	make prefix=${_toolspath}         || stop
	make prefix=${_toolspath} install || stop
	
	return 0
}
