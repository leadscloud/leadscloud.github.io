---
title: 无密码登陆mysql服务器
tags:
  - MySQL
id: 313830
categories:
  - Linux
date: 2014-06-08 14:47:23
---

mysql 的一般登陆方式是这样的

```
mysql -u $MYSQL_ROOT -p $MYSQL_PASS -h 192.168.10.1
```

但是，你有两个方式可以使用无密码提示的登陆，一个是修改`/etc/my.cnf`文件，一个是修改`~/.my.conf `文件。

```
$ vi ~/.my.cnf
```


```
[client]
user=alice
password=alice_passwd
host=192.168.10.1
```

如果是修改my.cnf文件，把它加到文件末尾就行了。你可以直接使用  

```
mysql -u root
```

登陆，不会再提示密码错误。但如果你仍然使用

```
mysql -u root -p
```

的方式，它还是会提示你输入密码的。

确保文件是只读的

```
$ chmod 0600 ~/.my.cnf
```

这样设置以后，你每次使用命令`mysql`就可以不要密码了，自动进入mysql中。