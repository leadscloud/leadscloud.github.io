---
title: LNMP MYSQL Error: The server quit without updating PID file
date: 2019-04-02 19:40:41
tags: lnmp
id: 20190407
categories: 技术
---


> Starting MySQL. ERROR! The server quit without updating PID file 


一般都是空间满了，磁盘空间不足导致无法写入，删除`mysql-bin.0000*`文件，在 `/usr/local/mysql/var` 目录下

磁盘空间充足的情况下还出现这个错误，试试以下办法

禁用 `bin-log`

`vi /etc/my.cnf`

把以下注释下

```
#log-bin=mysql-bin
#binlog_format=mixed
```

保存，然后重新启动 mysql

`/etc/init.d/mysql restart`

### 其它解决办法

查看mysql进程，并结束 ps -ef | grep mysqld kill -[pid]  kill相应进程号


如果有其它情形，比如你对某些权限进行了设置，进行了其它操作，上网搜索，网上关于这个的解决方法很多，需要多尝试，大部分解决方案只针对特定情况。

我上面的解决办法，一般对于以下情景适用：

* 使用的 lnmp 一键安装包
* 没有在服务器进行其它尝试，突然出现上面错误
* 之前是正常的




