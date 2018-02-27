---
title: centos下apache监测自动重启脚本
tags:
  - apache
id: 313372
categories:
  - Linux
date: 2012-05-19 02:04:42
---

最近apache的httpd进程总是丢失，可能是网站过载引起的。没什么好的办法避免，就想到写个脚本判断下，如果apache停止就重启。脚本如下：
<pre class="lang:sh decode:true">vi  /root/apachemonitor.sh</pre>
<pre class="lang:sh decode:true">#!/bin/bash

URL="http://127.0.0.1/"

curlit()
{
	curl --connect-timeout 15 --max-time 20 --head --silent "$URL" | grep '200'
}

if ! curlit; then
	top -n 1 -b &gt;&gt; /var/log/apachemonitor.log
	/etc/init.d/httpd restart
	echo $(date) "Apache Restart" &gt;&gt; /var/log/apachemonitor.log
fi</pre>

别忘了： chmod +x apachemonitor.sh
然后添加到定时任务：crontab -e
<pre class="lang:sh decode:true">*/1 * * * * /root/apachemonitor.sh</pre>
每一分钟检查一次

如果没有安装curl ：
<pre class="lang:sh decode:true  crayon-selected">yum install curl</pre>