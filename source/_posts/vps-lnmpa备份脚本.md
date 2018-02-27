---
title: vps-lnmpa备份脚本
tags:
  - lnmpa
  - VPS备份
id: 313503
categories:
  - Linux
date: 2012-09-07 08:07:56
---

以下脚本可以实现对lnmpa的备份。

cd ~
vi backup.sh
chmod +x backup.sh

你也可以加入定时任务让它每天自动执行。
<pre class="lang:default decode:true">#!/bin/bash

#Funciont: Backup website and mysql database
#Author: licess
#Website: http://lnmp.org

#IMPORTANT!!!Please Setting the following Values!

# Configure
DB_DIR='/usr/local/mysql/var'
NGINX_CONF_DIR='/usr/local/nginx/conf'
APACHE_CONF_DIR='/usr/local/apache/conf'
FILE_DIR='/home/wwwroot'

######~Set FTP Information~######
FTP_HostName='host'
FTP_UserName='username'
FTP_PassWord='password'
FTP_BackupDir='backup/vps2'

#Values Setting END!

TodayBackup=*-$(date +"%Y%m%d").tar.gz
OldBackup=*-$(date -d -3day +"%Y%m%d").tar.gz

tar zcf /home/backup/wwwroot-$(date +"%Y%m%d").tar.gz $FILE_DIR --exclude=phpmyadmin
tar zcf /home/backup/database-$(date +"%Y%m%d").tar.gz $DB_DIR
tar zcf /home/backup/nginx-conf-$(date +"%Y%m%d").tar.gz $NGINX_CONF_DIR
tar zcf /home/backup/apache-conf-$(date +"%Y%m%d").tar.gz $APACHE_CONF_DIR

rm -f /home/backup/$OldBackup

cd /home/backup/

lftp $FTP_HostName -u $FTP_UserName,$FTP_PassWord &lt;&lt; EOF
cd $FTP_BackupDir
mrm $OldBackup
mput $TodayBackup
bye
EOF</pre>
以前脚本会在远程ftp下，留下三个日期的记录，这是修改后的脚本，可以保证不出上面的问题。
<pre class="lang:sh decode:true">#!/bin/bash

#Funciont: Backup website and mysql database
#Author: Ray.
#Website: http://love4026.org

#IMPORTANT!!!Please Setting the following Values!
# crontab -e
# 0 3 */3 * * /root/backup.sh

# Configure
DB_DIR='/usr/local/mysql/var'
NGINX_CONF_DIR='/usr/local/nginx/conf'
APACHE_CONF_DIR='/usr/local/apache/conf'
FILE_DIR='/home/wwwroot'

######~Set FTP Information~######
FTP_HostName='***.ixwebhosting.com'
FTP_UserName='username'
FTP_PassWord='passwsd'
FTP_BackupDir='backup/vps-yourname'

#Values Setting END!

TodayBackup=*-$(date +"%Y%m%d").tar.gz
OldBackup=*-$(date -d -3day +"%Y%m%d").tar.gz

tar zcf /home/backup/wwwroot-$(date +"%Y%m%d").tar.gz $FILE_DIR --exclude=phpmyadmin
tar zcf /home/backup/database-$(date +"%Y%m%d").tar.gz $DB_DIR
tar zcf /home/backup/nginx-conf-$(date +"%Y%m%d").tar.gz $NGINX_CONF_DIR
tar zcf /home/backup/apache-conf-$(date +"%Y%m%d").tar.gz $APACHE_CONF_DIR

rm -f /home/backup/$OldBackup

cd /home/backup/

lftp $FTP_HostName -u $FTP_UserName,$FTP_PassWord &lt;&lt; EOF
cd $FTP_BackupDir
mrm $OldBackup
mput $TodayBackup
bye
EOF</pre>
&nbsp;