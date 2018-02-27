---
title: centos-升级python2-7到python3-4-2
id: 313932
categories:
  - 个人日志
date: 2015-01-14 20:56:18
tags:
---

首先在命令行下输入 python 以查看你的python版本，默认应该是2.6以上的，比如我的是2.7
安装python3.4之前建议先安装以下软件包：
yum install zlib-devel bzip2-devel openssl-devel ncurses-devel sqlite-devel readline-devel tk-devel gcc make

其中sqlite-devel如果不安装，python3.4安装后sqlalchemy会有些问题，比如import sqlite3会有问题。

下载python3.4的源码包： 
<pre class="lang:sh decode:true " >
wget https://www.python.org/ftp/python/3.4.2/Python-3.4.2.tgz
tar zxvf Python-3.4.2.tgz
cd Python-3.4.2
./configure --prefix=/usr/local/python3.4
make && make install
</pre> 

安装完之后可以在/usr/local/src/python3.4/bin 目录下看到python3.4

安装完成后还需要配置python

<pre class="lang:sh decode:true " >mv /usr/bin/python /usr/bin/python.bak
ln -s /usr/local/python3.3/bin/python3.3 /usr/bin/python</pre> 

然后在命令行下输入 python 查看下版本，如果是3.4.2就正常了

其它的一些问题

安装好python3后，yum无法使用了，解决办法
按照提示编辑/usr/bin/yum文件，把开头的/usr/bin/python 改为 /usr/bin/python2
这主要是因为yum使用的还是python2的代码，所以需要注明使用哪个python版本

添加 python3.4 到环境变量

编辑 ~/.bash_profile，将：
PATH=$PATH:$HOME/bin
改为：
PATH=$PATH:$HOME/bin:/usr/local/python34/bin

使 python3.4 环境变量生效：

 . ~/.bash_profile