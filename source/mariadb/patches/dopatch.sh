patch -p1 < ../patches/mariadb-errno.patch
patch -p1 < ../patches/mariadb-strmov.patch
patch -p1 < ../patches/mariadb-install-test.patch
patch -p1 < ../patches/mariadb-expired-certs.patch
patch -p1 < ../patches/mariadb-versioning.patch
patch -p1 < ../patches/mariadb-dubious-exports.patch
patch -p1 < ../patches/mariadb-s390-tsc.patch
patch -p1 < ../patches/mariadb-logrotate.patch
patch -p1 < ../patches/mariadb-cipherspec.patch
patch -p1 < ../patches/mariadb-file-contents.patch
patch -p1 < ../patches/mariadb-string-overflow.patch
patch -p1 < ../patches/mariadb-dh1024.patch
patch -p1 < ../patches/mariadb-man-plugin.patch
patch -p1 < ../patches/mariadb-basedir.patch
cp -f ../patches/libmysql.version ./libmysql/libmysql.version 
cp -f ../patches/mysql_plugin.1 ./man/mysql_plugin.1
