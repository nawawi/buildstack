Cenbia WebStack - http://www.cenbia.com/

INTRODUCTION:
Cenbia WebStack is a LAMP solution that consists of Apache, FastCGI, PHP-FPM and mariaDB. 
Cenbia aim to be a high-performance Web Server for PHP, easy to install and portable.

REQUIREMENT:
shadow-utils coreutils sed bash

USAGE
=======
@ROOT_DIR/cenbia [argument]

Possible options:
@ROOT_DIR/cenbia start
@ROOT_DIR/cenbia stop
@ROOT_DIR/cenbia restart
@ROOT_DIR/cenbia shell

Possible arguments:
@ROOT_DIR/cenbia [option] httpd mysqld php-fpm
@ROOT_DIR/cenbia shell [system command]


Cenbia Shell
=============
Cenbia shell allow you to run command (CLI) under Cenbia environment setting.

mysqld-control  - command for control mysql daemon (mariaDB)
httpd-control   - command for control http daemon (apache)
php-fpm-control - command for control php-fpm daemon


phpMyAdmin URL
==============
http://localhost/pma

Login: root
Password: 123456

Configuration Files
===================
@INST_DIR/etc/httpd         - apache configuration directory
@INST_DIR/etc/php.ini       - php configuration file
@INST_DIR/etc/php.d         - php additional configuration file
@INST_DIR/etc/php-fpm.conf  - php-fpm configuration file
@INST_DIR/etc/php-fpm.d     - php-fpm additional configuration file
@INST_DIR/etc/my.cnf        - mysql configuration file

Directory/File info
===================
@ROOT_DIR                   - root (main) directory
@ROOT_DIR/cenbia            - cenbia console
@ROOT_DIR/data              - directory for Logs, pid file, socket..etc..etc
@ROOT_DIR/stack             - application/system directory (bin,lib,etc)



--
Last update: 26-Jun-2013 (nawawi@rutweb.com)