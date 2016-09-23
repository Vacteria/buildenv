name=""
version=""
sources=""
patches=""

pkg_pre_compile()
{
	return 0
}

pkg_compile()
{
	./configure || stop
	make || stop
	make install || stop
	
	return 0
}

pkg_post_compile()
{
	return 0 
}

pkg_hook()
{
	return 0
}
