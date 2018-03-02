---
title: mysql忘记root密码的解决方案
id: 313950
categories:
  - Linux
date: 2015-04-30 17:30:01
tags: mysql
---

首先，在/etc/my.cnf中，找到[mysqld]，添加一行：

`skip-grant-tables`

重启MySQL：

`/etc/init.d/mysql restart`

进入MySQL的命令行，并依次执行如下命令：

```
mysql> use mysql;
mysql> update user set password=password('newpwd') where user='root';
mysql> flush privileges;
mysql> exit
```

其中的`newpwd`是更改后的新密码，需要用户重新指定。

重新打开`/etc/my.cnf`，将刚才修改的地方改回初始状态。

再次重启MySQL：
`/etc/init.d/mysql restart`