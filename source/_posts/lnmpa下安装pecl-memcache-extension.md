---
title: lnmpa下安装pecl-memcache-extension
id: 313490
categories:
  - Wordpress学习
date: 2012-08-27 03:39:33
tags:
---

`wget http://pecl.php.net/get/memcache-3.0.6.tgz
tar -xzvf memcache-3.0.6.tgz
cd memcache-3.0.6
./configure --with-php-config=/usr/local/php/bin/php-config --with-zlib --with-apxs=/usr/local/apache/bin/apxs --with-gettext --enable-socket --enable-memcache --enable-sysvshm --enable-shmop`

安装好后，如果使用wordpress ,可以让wordpress支持 memcache ,方法见：
http://fairyfish.net/m/wordpress-memcached/
其它安装方法见此篇文章：

[http://www.cnblogs.com/mxw09/archive/2011/08/19/2145538.html](http://www.cnblogs.com/mxw09/archive/2011/08/19/2145538.html)

英文的一篇参考，为wordpress mu安装memcache

[http://ryan.boren.me/2005/12/23/memcached-backend/](http://ryan.boren.me/2005/12/23/memcached-backend/)