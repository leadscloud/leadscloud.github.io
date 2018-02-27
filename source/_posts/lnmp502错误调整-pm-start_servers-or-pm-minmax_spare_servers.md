---
title: lnmp502错误调整-pm-start_servers-or-pm-minmax_spare_servers
tags:
  - lnmp
id: 313619
categories:
  - Linux
date: 2013-07-18 02:34:45
---

[pool www] seems busy (you may need to increase pm.start_servers, or pm.min/max_spare_servers), spawning 8 children, there are 0 idle, and 12 total children

编辑以下内容,调大一下,start_servers和max_spare_servers 可以避免一定情况下的502频繁错误.

文件在/usr/local/php/etc/php-fpm.conf