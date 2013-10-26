#!/bin/bash
rm -rfv cenbia-utils-0.2
cp -fav _src cenbia-utils-0.2
tar -zcvf cenbia-utils-0.2.tar.gz cenbia-utils-0.2
mv -v cenbia-utils-0.2.tar.gz ../../tarball/cenbia-utils-0.2.tar.gz
rm -rf cenbia-utils-0.2
