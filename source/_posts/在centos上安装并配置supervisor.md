---
title: 在centos上安装并配置supervisor
id: 313956
categories:
  - 个人日志
date: 2015-08-21 11:51:27
tags:
---

    sudo yum install python-setuptools
    sudo easy_install pip
    sudo pip install supervisor

如果出现错误使用 easy_install supervisor 安装。

### 配置Supervisor

安装好后，需要合建配置文件
<pre class="lang:default decode:true">echo_supervisord_conf &gt; supervisord.conf
sudo cp supervisord.conf /etc/supervisord.conf
sudo mkdir /etc/supervisord.d/
sudo vi /etc/supervisord.conf
# 把下面的这两行的注释去掉，如果没有加上即可。
[include]
files = /etc/supervisord.d/*.conf
</pre>
配置文件

创建一个配置文件到/etc/supervisord.d/ 比如 /etc/supervisord.d/shadowsocks.conf

文件内容为
<pre class="lang:sh decode:true ">[program: ] (  is name of program)
command=/bin/  //Execute command
process_name=%(program_name)s //if your numprocs is more than 1 it should be %(program_name)s_%(process_num)02d 
numprocs=1 //Number of your concurrent process Perfect for gearman
directory=/tmp //cd this directory before running
priority=999 //priority or program maximum is 999
autostart=true
autorestart=true
startretries=3 //number of retrying times if process is die
stopwaitsecs=10 //waiting xx second before before stop
user=chrism //exec by user should be “root”
//Log control 
stdout_logfile=/a/path
stdout_logfile_maxbytes=1MB</pre>
shadowsocks的文件内容为
<pre class="lang:sh decode:true ">[program:shadowsocks] 
command=python /dir/server.py -c /dir/config.json
autorestart=true 
user=root 
</pre>

### 设置开机启动

<pre class="lang:sh decode:true ">sudo vi /etc/rc.d/init.d/supervisord
#!/bin/sh
#
# /etc/rc.d/init.d/supervisord
#
# Supervisor is a client/server system that
# allows its users to monitor and control a
# number of processes on UNIX-like operating
# systems.
#
# chkconfig: - 64 36
# description: Supervisor Server
# processname: supervisord

# Source init functions
. /etc/rc.d/init.d/functions

prog="supervisord"

prefix="/usr/"
exec_prefix="${prefix}"
prog_bin="${exec_prefix}/bin/supervisord"
PIDFILE="/var/run/$prog.pid"

start()
{
       echo -n $"Starting $prog: "
       daemon $prog_bin --pidfile $PIDFILE -c /etc/supervisord.conf
       [ -f $PIDFILE ] &amp;&amp; success $"$prog startup" || failure $"$prog startup"
       echo
}

stop()
{
       echo -n $"Shutting down $prog: "
       [ -f $PIDFILE ] &amp;&amp; killproc $prog || success $"$prog shutdown"
       echo
}

case "$1" in

 start)
   start
 ;;

 stop)
   stop
 ;;

 status)
       status $prog
 ;;

 restart)
   stop
   start
 ;;

 *)
   echo "Usage: $0 {start|stop|restart|status}"
 ;;

esac</pre>
再执行以下命令
<pre class="lang:sh decode:true">sudo chmod +x /etc/rc.d/init.d/supervisord
sudo chkconfig --add supervisord
sudo chkconfig supervisord on
sudo service supervisord start</pre>

网页界面查看

修改/etc/

把
<pre class="lang:sh decode:true">
;[inet_http_server]         ; inet (TCP) server disabled by default
;port=*:9001        ; (ip_address:port specifier, *:port for all iface)
</pre>

改为(即去掉注释）

<pre class="lang:sh decode:true">
[inet_http_server]         ; inet (TCP) server disabled by default
port=*:9001        ; (ip_address:port specifier, *:port for all iface)
</pre>

在浏览器输入http://Host:9001  就可以查看了。

参考资料：

https://medium.com/@thangman22/how-to-control-your-deamon-with-supervisord-on-centos-4ec4658205bf
https://rayed.com/wordpress/?p=1496