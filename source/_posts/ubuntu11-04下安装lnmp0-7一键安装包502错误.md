---
title: ubuntu11-04下安装lnmp0-7一键安装包502错误
tags:
  - ubuntu
  - VPS
id: 313153
categories:
  - Linux
date: 2011-05-22 11:31:42
---

内核： Linux ubuntu 2.6.38-8-generic #42-Ubuntu SMP Mon Apr 11 03:31:50 UTC 2011 i686 i686 i386 GNU/Linux

系统版本： Ubuntu 11.04&nbsp;&nbsp; 32位

打开http://127.0.0.1&nbsp; 显示成功，但打开 http://127.0.0.1/p.php 出现502错误

`/root/lnmp restart `错误信息：

`root@ubuntu:~/lnmp0.7-full/php-5.2.17# /root/lnmp restart

=========================================================================

Manager for LNMP V0.7&nbsp;&nbsp;,&nbsp;&nbsp;Written by Licess 

=========================================================================

LNMP is a tool to auto-compile &amp; install Nginx+MySQL+PHP on Linux 

This script is a tool to Manage status of lnmp 

For more information please visit http://www.lnmp.org [local]1[/local]

Usage: /root/lnmp {start|stop|reload|restart|kill|status}

=========================================================================

Stoping LNMP...

Nginx program is stop

PHP-FPM program is not runing!

Shutting down MySQL

. * 

MySQL program is stop

Starting LNMP...

Nginx start successfully!

/root/lnmp: 行 46: /usr/local/php/sbin/php-fpm: 没有那个文件或目录

PHP-FPM start successfully!

Starting MySQL

. * 

MySQL start successfully!`

&nbsp;

`解决办法：`

（打开 /root/lnmp0.7-full/ubuntu.sh&nbsp;&nbsp;找到 echo &quot;========================= php + php extensions install ===================&quot;&nbsp;&nbsp;按里面的代码执行的。从 tar zxvf php-5.2.17.tar.gz 开始执行的，下面有具体的）

apt-get install libjpeg62 libjpeg62-dev libjpeg-dev&nbsp; 

ln -s /usr/lib/i386-linux-gnu/libpng* /usr/lib/

ln -s /usr/lib/i386-linux-gnu/libjpeg* /usr/lib/&nbsp;&nbsp; 

cd /root/lnmp0.7-full/ 或者 cd cd /root/lnmp0.7/ 

tar zxvf php-5.2.17.tar.gz

gzip -cd php-5.2.17-fpm-0.5.14.diff.gz | patch -d php-5.2.17 -p1

cd php-5.2.17/

./buildconf --force

./configure --prefix=/usr/local/php --with-config-file-path=/usr/local/php/etc --with-mysql=/usr/local/mysql --with-mysqli=/usr/local/mysql/bin/mysql_config --with-iconv-dir --with-freetype-dir --with-jpeg-dir --with-png-dir --with-zlib --with-libxml-dir=/usr --enable-xml --enable-discard-path --enable-magic-quotes --enable-safe-mode --enable-bcmath --enable-shmop --enable-sysvsem --enable-inline-optimization --with-curl --with-curlwrappers --enable-mbregex --enable-fastcgi --enable-fpm --enable-force-cgi-redirect --enable-mbstring --with-mcrypt --enable-ftp --with-gd --enable-gd-native-ttf --with-openssl --with-mhash --enable-pcntl --enable-sockets --with-xmlrpc --enable-zip --enable-soap --without-pear --with-gettext --with-mime-magic

make ZEND_EXTRA_LIBS=&#39;-liconv&#39;

make install

这个问题我在vpse论坛上问过了，上面有关于我如何解决的：

[http://bbs.vpser.net/thread-3055-1-1.html](http://bbs.vpser.net/thread-3055-1-1.html)

附：

<font face="Verdana, Arial, sans-serif "><font style="font-size: 13px;">LNMP安装教程：[http://lnmp.org/install.html](http://lnmp.org/install.html)

LNMPA安装教程：[http://lnmp.org/lnmpa.html](http://lnmp.org/lnmpa.html)</font></font>