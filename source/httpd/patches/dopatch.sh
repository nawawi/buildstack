patch -p1 < ../patches/httpd-2.4.1-deplibs.patch
patch -p1 < ../patches/httpd-2.4.1-corelimit.patch
#patch -p1 < ../patches/httpd-2.4.2-r1374214+.patch
# rutweb patch
#patch -p0 < ../patches/httpd-2.4.4-suexec-ld_library_path.patch

if [ -f "../patches/config-layout" -a -f "./config.layout" ]; then
    cat ../patches/config-layout >> ./config.layout;
fi
