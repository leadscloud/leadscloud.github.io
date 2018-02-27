---
title: lnmp环境后续处理
id: 313247
categories:
  - Linux
date: 2012-01-09 02:47:06
tags:
---

一、关闭MySQL日志功能：（在/usr/local/mysql/var/下面产生类似mysql-bin.0000*的文件，很大）
（1）删除已产生的MySQL日志
执行：/usr/local/mysql/bin/mysql -u root -p
输入密码登录后再执行：reset master
（2）关闭MySQL日志功能
修改/etc/my.cnf 文件，用#号注释掉以下两行
log-bin=mysql-bin
binlog_format=mixed
再执行/etc/init.d/mysql restart即可
二、解决nginx 502 Bad Gateway错误：
（1）修改/usr/local/php/etc/php-fpm.conf文件
“max_children”值默认是“5”每一个消耗大约20M内存，根据内存大小设置
“max_requests”默认是“10240”一般不用改
“request_terminate_timeout”默认是“os”含义是让PHP-CGI一直执行下去而没有时间限制(一旦出错也将会一直显示错误)，但是一般服务器没有这么好，性能越好可以设置越高，可以设为“100s”
（2）修改/usr/local/php/etc/php.ini文件，将max_execution_time改为300（LNMP默认就是）
（3）重启一下VPS