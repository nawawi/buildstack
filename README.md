BuildStack
==========

BuildStack is a set of shell scripts that makes it easy to compile Apache, FastCGI, PHP, PHP-FPM and mariaDB
as one component for software called Cenbia WebStack.

Requirement
-----------
1. Bash version 3 or higher.
2. Internet Connection. By default BuildStack will download source package if not exist.
3. Superuser "root" access.
4. Development/compiling tools such as gcc, g++, and perl.
5. ccache for faster compiling.

Download
--------
`git clone https://github.com/nawawi/buildstack.git`  
`cd buildstack`  
`chmod 755 build`  

or

`wget https://github.com/nawawi/buildstack/archive/master.zip`  
`unzip master.zip`  
`mv buildstack-master buildstack`  
`cd buildstack`  
`chmod 755 build`  

Setup
-----
BuildStack has tested on:

1. CentOS 6.4 (x86_64).
2. Ubuntu 12.04 (x86_64).
3. Arch Linux 2013.10.01 (x86_64). 

**CentOS**  
`rpm -ivh http://ftp.neowiz.com/fedora-epel/6/i386/epel-release-6-8.noarch.rpm`  
`yum -y update`  
`./build.d/setup-centos.sh`

**Ubuntu**  
apt-get update  
apt-get upgrade  
`./build.d/setup-ubuntu.sh`

**Arch Linux**  
pacman -Syu  
`./build.d/setup-archlinux.sh`

Build
-----
For development: ./build  
For dist release: ./build --dist

Please type ./build --help for more options.

After installation start Cenbia Service:

**# /opt/cenbia/cenbia start**

Please type /opt/cenbia/cenbia --help for more options.

Contact
-------
For bug report and others, please email to nawawi(at)rutweb.com

