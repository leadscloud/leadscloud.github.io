---
title: shadowsocks-安装笔记
id: 313675
categories:
  - 个人日志
date: 2013-11-30 13:19:33
tags:
---

一些记录，不是很详细

安装git
<pre class="lang:sh decode:true " >yum -y install git</pre> 
查看git安装成功没
<pre class="lang:sh decode:true " >git --version</pre> 

<pre class="lang:sh decode:true " >git clone https://github.com/clowwindy/shadowsocks.git</pre> 

<pre class="lang:sh decode:true " >cd shadowsocks</pre> 

<pre class="lang:sh decode:true " >vi config.json</pre> 

<pre class="lang:sh decode:true " >
{
    "server":"<your_ip>",
    "server_port":8388,
    "local_port":1080,
    "password":"password",
    "timeout":600,
    "method":"table"
}
</pre> 

<pre class="lang:sh decode:true " >python setup.py install</pre> 

进入 shadowsocks下的shadowsocks文件夹

<pre class="lang:sh decode:true " >nohup python server.py > log &</pre> 

或者进入到config.json文件所在目录 

<pre class="lang:sh decode:true " >nohup ssserver > log &</pre> 

Centos 开机启动设置

<pre class="lang:sh decode:true " >echo "nohup ssserver -c /root/shadowsocks/config.json > log &" >> /etc/rc.d/rc.local</pre> 

 lsof -i :8388  可以查看此端口的连接