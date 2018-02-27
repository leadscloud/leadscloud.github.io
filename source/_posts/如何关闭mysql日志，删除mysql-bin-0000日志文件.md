---
title: 如何关闭mysql日志，删除mysql-bin-0000日志文件
tags:
  - MySQL
id: 313442
categories:
  - Linux
date: 2012-06-28 11:17:43
---

[LNMP一键安装包](http://lnmp.org/)安装的MySQL默认是开启了日志文件的，如果数据操作比较频繁就会产生大量的日志，在/usr/local/mysql/var/下面产生mysql-bin.0000* 类似的文件，而且一般都在几十MB到几个GB，更甚会吃掉整个硬盘空间，从来导致mysql无法启动或报错，如[vps论坛用户的反馈](http://bbs.vpser.net/viewthread.php?tid=1776)。

如何关闭MySQL的日志功能：

删除日志：

&nbsp;

执行：/usr/local/mysql/bin/mysql -u root -p

输入密码登录后再执行：reset master;

再输入：quit 退出mysql命令模式。

彻底禁用MySQL日志：修改/etc/my.cnf 文件，找到

log-bin=mysql-bin
binlog_format=mixed

再这两行前面加上**#**，将其注释掉，再执行/etc/init.d/mysql restart即可。

注意如果你只注释：#log-bin=mysql-bin 重启mysql会出错错误: You need to use --log-bin to make --binlog-format work.

所以请把这两行都注释掉。

本文以[LNMP一件安装包](http://lnmp.org/)安装的环境为例除MySQL重启命令和配置文件路径可能略有不同，其他一样。

原文：**[http://www.vpser.net/manage/delete-mysql-mysql-bin-0000-logs.html](http://www.vpser.net/manage/delete-mysql-mysql-bin-0000-logs.html "如何关闭MySQL日志，删除mysql-bin.0000*日志文件")**