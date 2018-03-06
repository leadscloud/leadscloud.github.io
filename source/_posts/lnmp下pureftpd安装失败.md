---
title: lnmp下pureftpd安装失败
tags:
  - Pureftpd
  - lnmp
  - ftp
id: 313689
categories:
  - Linux
date: 2014-01-09 06:40:08
---

lnmp下Pureftpd安装失败的原因一般为 

    Error: Table 'admin' from database 'ftpusers' doesn't exist.

    MySql error : Table 'ftpusers.admin' doesn't exist

有时安装日志会提示： `Duplicate entry 'localhost-ftp' for key 'PRIMARY' Install GUI User manager for PureFTPd`

经检查是因为在安装pureftpd图形界面的时候创建表时出现错误，我目前的使用的是lnmp1.0出现的问题，0.9的时候也出过问题，不过重装一次就解决了。
重装过程很简单，进入`/root/lnmp1.0-full` 运行`./pureftpd.sh` 就行了。如果不行，可以按照以下方法解决，因为出问题是因为在创建表时出现问题，所以我们可以直接在phpmyadmin中创建表。

假设管理员密码是 yourpasswd


```sql
CREATE TABLE admin (
  Username varchar(35) NOT NULL default '',
  Password char(32) binary NOT NULL default '',
  PRIMARY KEY  (Username)
) TYPE=MyISAM;
```

把 TYPE=MyISAM 改为 ENGINE = MYISAM 即可。

```sql
INSERT INTO admin VALUES ('Administrator',MD5('yourpasswd'));
```


 下面再创建用户表，默认添加一个ftp用户。

```sql
CREATE TABLE `users` (
  `User` varchar(16) NOT NULL default '',
  `Password` varchar(32) binary NOT NULL default '',
  `Uid` int(11) NOT NULL default '14',
  `Gid` int(11) NOT NULL default '5',
  `Dir` varchar(128) NOT NULL default '',
  `QuotaFiles` int(10) NOT NULL default '500',
  `QuotaSize` int(10) NOT NULL default '30',
  `ULBandwidth` int(10) NOT NULL default '80',
  `DLBandwidth` int(10) NOT NULL default '80',
  `Ipaddress` varchar(15) NOT NULL default '*',
  `Comment` tinytext,
  `Status` enum('0','1') NOT NULL default '1',
  `ULRatio` smallint(5) NOT NULL default '1',
  `DLRatio` smallint(5) NOT NULL default '1',
  PRIMARY KEY  (`User`),
  UNIQUE KEY `User` (`User`)
) ENGINE = MYISAM;

INSERT INTO ftpusers.users VALUES ('zongzhaohao',MD5('yourpasswd'),501, 501, '/home/wwwroot', 100, 50, 1000, 1000, '*', 'Ftp user (for example)', '1', 0, 0);
```

以前一般都可以解决问题。

另外，关于lnmp不支持中文目录可以参考这篇文章。http://www.vpser.net/manage/lnmp-nginx-chinese-filename-directory.html 

不过这篇文章其实并不能彻底解决问题。如果你想使用pureftpd下传的文件默认就是utf-8的，请在站点管理器中的字符集设置中设置强制utf-8。 另外，可能这样设置仍然不行，请在pureftpd的配置文件中修改以下代码

```
#FileSystemCharset       big5
#ClientCharset           big5
```

改为

```
FileSystemCharset       utf8
ClientCharset           utf8
```

到此你上传到ftp的文件编码默认就是utf-8的，在浏览器中就可以直接打开了。另外，如果你想在putty中直接显示中文，请在putty设置中的translation设置编码为utf-8，上面的文章中有具体介绍，大家可以参考。