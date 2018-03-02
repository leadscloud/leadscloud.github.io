---
title: Linux VPS 上的网站和数据库备份
tags:
  - VPS
  - VPS备份
id: 313216
categories:
  - Linux
date: 2011-09-24 06:15:15
---

以下是我linux主机上的备份操作，VPS安装的是lnmpa一键安装包。

首先是网站的备份，比较简单。

cd /home
tar zcvf wwwroot-bakup-20111-09-24.tar.gz wwwroot

mysql的备份

mysqldump -u root -p –all-databases | gzip > /home/mysql-backup-2011-09-24.sql.gz

使用mysqldump定时自动备份数据库

[root@www www]# vi backup-db.sh
#!/bin/sh
/bin/nice -n 19 /usr/bin/mysqldump -u vpsmysql –password=vpsmysqlpassword mysqlname -c | /bin/nice -n 19 /bin/gzip -9 &gt; /web/www/db-backup/vps-$(date ‘+%Y%m%d’).sql.gz
rm -rf /web/www/db-backup/vps-$(date +%Y%m%d -d “7 days ago”).sql.gz
#上面语句删除7天前的备份
上述脚本中-u后接数据库用户名， –password后接数据库密码，紧接着是数据库名，后面/web/www/db-backup/ 是备份的目录。
添加定时执行任务
[root@www ~]# crontab -e
59 23 * * * /web/www/backup-db.sh
每天的23：59分会自动备份数据库，且生成的数据库压缩按日期命名
以上备份的信息，备份完了就赶快把备份下载到本地，毕竟，备份的数据都在VPS，不在身边。

以上文备份好之后，用ftp下载下来比较保险。