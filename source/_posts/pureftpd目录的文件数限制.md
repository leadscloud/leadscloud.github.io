---
title: pureftpd目录的文件数限制
tags:
  - Pureftpd
id: 313498
categories:
  - Linux
date: 2012-09-06 09:23:35
---

如果你的ftp使用的是Pureftpd服务，那你在使用ftp客户端时会发现有些文件传到服务器上，然后远程目录会不显示，那是因为ftp的服务器限制了文件数的显示。

lnmp服务器下可以修改：

编辑/usr/local/pureftpd/pure-ftpd.conf 查找LimitRecursion ，将后面的2000换成大一点的数，重启purefptd再试试

说明：

# 'ls' 命令的递归限制。第一个参数给出文件显示的最大数目。第二个参数给出最大的子目录深度。

LimitRecursion 2000 8

这儿有Pure-ftpd配置文件的详细介绍。
[http://wiki.ubuntu.org.cn/Pure-ftpd](http://wiki.ubuntu.org.cn/Pure-ftpd)