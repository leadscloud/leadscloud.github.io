---
title: linux下查看nginx，apache，mysql，php的编译参数
id: 313523
categories:
  - Linux
date: 2012-12-17 03:46:36
tags:
---

1、nginx编译参数：
#/usr/local/nginx/sbin/nginx -V

2、apache编译参数：
# cat /usr/local/apache/build/config.nice

3、php编译参数：
# /usr/local/php/bin/php -i |grep configure

4、mysql编译参数：
# cat /usr/local/mysql/bin/mysqlbug|grep configure