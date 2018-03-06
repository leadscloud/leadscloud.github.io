---
title: LAMP 重启脚本
id: 313444
categories:
  - Linux
date: 2012-06-30 02:00:29
tags: lamp
---

自己手工安装的lamp，所以需要有个脚本来控制服务器的停止与启动。

```
#!/bin/bash
PATH=/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin:~/bin
export PATH

# Check if user is root
if [ $(id -u) != "0" ]; then
    printf "Error: You must be root to run this script!\n"
    exit 1
fi

HOSTNAME=`hostname`
MYSQLPIDFILE=/usr/local/mysql/data/$HOSTNAME.pid
APACHENAME=httpd
APACHEPIDFILE=/usr/local/apache/logs/$APACHENAME.pid

function_start()
{
    printf "Starting LAMP...\n"

    /etc/init.d/httpd start

    if [ -f $MYSQLPIDFILE ]; then
        printf "MySQL is runing!\n"
    else
	/etc/init.d/mysqld start
	printf "MySQL start successfully!\n"
    fi
}

function_stop()
{
    printf "Stoping LAMP...\n"

    /etc/init.d/httpd stop

    if  [ -f $MYSQLPIDFILE ]; then
        /etc/init.d/mysqld stop
        printf "MySQL program is stop\n"
    else
        printf "MySQL program is not runing!\n" 
    fi
}

function_reload()
{
    printf "Reload LAMP...\n"
    /etc/init.d/mysqld reload
    /etc/init.d/httpd restart
}

function_restart()
{
    printf "Restart LAMP...\n"
    /etc/init.d/mysqld restart
    /etc/init.d/httpd restart
}
function_kill()
{
    kill `cat $APACHEPIDFILE`
    kill `cat $MYSQLPIDFILE`
}
function_status()
{
/etc/init.d/httpd status
/etc/init.d/mysqld status
}

case "$1" in
	start)
		function_start
		;;
	stop)
		function_stop
		;;
	restart)
		function_stop
		function_start
		;;
	reload)
		function_reload
		;;
	kill)
		function_kill
		;;
	status)
		function_status
		;;
	*)
		printf "Usage: /root/lamp {start|stop|reload|restart|kill|status}\n"
esac
exit
```