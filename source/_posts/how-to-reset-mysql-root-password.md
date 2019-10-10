---
title: MySQL重置root密码
tags:
  - MySQL
id: 20191010
categories:
  - Linux
date: 2019-10-10 15:38:00
---

编辑mysql配置文件 `vi /etc/my.cnf`，在`mysqld`下添加一行`skip-grant-tables`，如下

```
[mysqld]
#...
skip-grant-tables
#...
```

这样就可以免密登录MySQL

重启MySQL `service mysqld restart`

在终端中直接输入 `mysql` 即可进入mysql

切换数据库

`use mysql;`

输入以下命令

```
update user set authentication_string=password('新密码') where user='root';
```

MySQL5.7前的版本使用

```
update user set password=password('新密码') where user='root';
```