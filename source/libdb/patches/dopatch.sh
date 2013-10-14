patch -p1 < ../patches/libdb-multiarch.patch
#patch -p1 < ../patches/db-1.85-errno.patch
patch -p1 < ../patches/db-4.6.21-1.85-compat.patch
patch -p1 < ../patches/db-4.5.20-jni-include-dir.patch