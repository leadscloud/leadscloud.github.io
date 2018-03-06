---
title: 通过SSH备份VPS网站文件和数据库
tags:
  - VPS
  - VPS备份
id: 313274
categories:
  - Linux
date: 2012-02-29 02:29:29
---

在使用 VPS 的过程里，有三样东西必须做好备份：网站目录、服务器配置文件和数据库。在进行备份前，先用 SSH 以 root 帐户登录到服务器。下面简单说说我的备份过程。

## 备份 MySQL 数据库

我通常是备份整个数据库并使用 Gzip 压缩，同时添加 DROP DATABASE 防止在备份文件导入时出现数据库重复问题。

```
/usr/local/mysql/bin/mysqldump --all-databases --add-drop-table -u{username} -p{password} | gzip &gt; /home/backup/mysql_$(date +%Y%m%d).sql.gz
```

使用上面这句 SSH 命令前需要确定 mysqldump 的路径，像我的 VPS 就在 /usr/local/mysql/bin/ 目录下。并且把 `{username}` 和 `{password}` 替换成你的 MySQL 用户名和密码。

## 备份服务器配置文件

备份服务器配置文件的目的是在重新布置服务器环境时能迅速恢复所有站点的配置，这一步主要是备份 Apache 和 Nginx 的配置文件。在备份前你必须清楚自己服务器的环境并且知道相关配置文件的位置，像我的服务器同时使用了 Apache 和 Nginx，就必须要同时备份这两个货的配置文件。

```
# backup nginx configure files
tar -zcvf /home/backup/nginx_conf_$(date +%Y%m%d).tar.gz /usr/local/nginx/conf
# backup apache configure files
tar -zcvf /home/backup/apache_conf_$(date +%Y%m%d).tar.gz /usr/local/apache/conf
```

## 备份网站目录

这一步就比较简单了，网站目录通常位于 /home/wwwroot 里，因此只需要把 wwwroot 目录打包压缩就行了。


`tar -zcvf /home/backup/wwwroot_$(date +%Y%m%d).tar.gz /home/wwwroot`


## 把备份文件保存到本地

在执行完上面三个步骤以后，使用 sftp 登录服务器，就能在 /home/backup 里找到刚才备份的文件，通过日期字串能看出这些备份文件是在那一天生成的，赶紧把这些备份下载到你的电脑上吧！