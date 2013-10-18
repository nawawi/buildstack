BuildStack
==========

BuildStack is a set of shell scripts that makes it easy to compile Apache, FastCGI, PHP, PHP-FPM and mariaDB
as one component for software called Cenbia WebStack.

Requirement
-----------
1. Bash version 3 or higher.
1. Internet Connection. By default BuildStack will download source package if not exist.

2. Superuser "root" access.

3. development/compiling tools such as gcc, g++, and perl.

   Complete CentOS package or similar: 
   gcc gcc-c++ cmake make autoconf libtool bison libgcc unixODBC-devel readline-devel gnutls-devel 
   krb5-devel freetds-devel pam-devel bash sed coreutils rsync patch nasm. 

   If you're using CentOS 6. Please install "epel" repo and run script "bash ./build.d/centos-rpm"

4. ccache for faster compiling.

Usage
------
For development: ./build
For dist release: ./build --dist

Please type ./build --help for more options.

After installation start Cenbia Service:

**# /opt/cenbia/cenbia start**

Please type /opt/cenbia/cenbia --help for more options.

Contact
-------
For bug report and others, please email to nawawi(at)rutweb.com

