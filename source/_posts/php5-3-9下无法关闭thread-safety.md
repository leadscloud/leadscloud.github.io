---
title: php5-3-9下无法关闭thread-safety
id: 313396
categories:
  - Linux
date: 2012-06-02 09:56:32
tags:
---

/usr/local/php/bin/php -m

Failed loading /usr/local/php/lib/php/extensions/no-debug-zts-20090626/ZendGuardLoader.so:  /usr/local/php/lib/php/extensions/no-debug-zts-20090626/ZendGuardLoader.so: undefined symbol: compiler_globals

这个错误是因为ZendGuardLoader 必须是要在Thread Safety Disable 的情况下才能使用。别无它法，只有重新编绎。但上网找了很久，没有答案解决。因为重新编绎的方法没一个管用的，无法使Thread Safety 关闭。  此问题不解决 Zend Optimizer  也便安装不了。

这个问题一直没有解决。回答的都不对。

说是要apache 编绎时 --with-mpm=prefork  ，不对！
说是php重新编绎使用 --disable-maintainer-zts 或 --disable-roxen-zts 或 --without-roxen 或 --disable-zts ， 不对！

这是国外一个人的提问，没有解决。
http://www.experts-exchange.com/Web_Development/Web_Languages-Standards/PHP/PHP_Installation/Q_26890298.html

等待解决。