patch -p1 < ../patches/php-5.2.0-includedir.patch
patch -p1 < ../patches/php-5.2.4-embed.patch
patch -p1 < ../patches/php-5.3.0-recode.patch
patch -p1 < ../patches/php-5.4.7-libdb.patch
#patch -p1 < ../patches/php-5.4.8-mysqli.patch
#patch -p1 < ../patches/php-5.4.7-imap.patch
patch -p1 < ../patches/php-5.4.7-odbctimer.patch
#patch -p1 < ../patches/php-5.4.7-sqlite.patch
#patch -p1 < ../patches/php-5.4.8-libxml.patch
patch -p1 < ../patches/php-5.4.0-dlopen.patch
patch -p1 < ../patches/php-5.4.0-easter.patch
patch -p1 < ../patches/php-5.3.1-systzdata-v10.patch
patch -p1 < ../patches/php-5.4.0-phpize.patch
patch -p1 < ../patches/php-5.4.5-system-libzip.patch
patch -p1 < ../patches/php-5.4.8-ldap_r.patch
patch -p0 < ../patches/php-5.4.16-fix_chrootpath.patch