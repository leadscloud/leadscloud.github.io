---
title: Can"t init tc log Aborting
id: 313417
categories:
  - Linux
date: 2012-06-12 14:01:31
tags:
---

今天的VPS非常卡，不小心输入个命令 /usr/local/mysql/bin/mysqld  然后卡的不动了，我重启了。结果mysql就启动不了了。

查看 `tail -n 50 /usr/local/mysql/data/***.err  ` 提示  

    Can"t init tc log Aborting ， Failed to open log，   File './mysql-bin.000023' not found

解决办法： 

问题出在mysql-bin.0000023上。

mysql5运行一段时间，在mysql/data目录下出现一堆类似mysql-bin.000***的文件，从mysql-bin.000001开始一直排列下来，有的占用了大量硬盘空间，高达上百兆，我的高达20多G。 这些文件是MySQL的事务日志log-bin。删除也是没事的。logbin主要是用来做回滚和增量备份的。 还可以在my.ini里把log-bin注释掉，就不产生日志文件了。 

`vi /etc/my.cnf`
配置中的log-bin注释掉，

```
#log-bin=mysql-bin 
```

 果然问题解决

log-bin=mysql-bin配置与主从配置有关，并且它记录了所有数据库的操作，用于灾难恢复，所以注释掉它也是有一定风险的，需要定时备份数据库！