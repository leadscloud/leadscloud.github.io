---
title: python批量操作ssh（vps）工具
tags:
  - paramiko
  - python
id: 313924
categories:
  - Linux
date: 2014-12-10 10:13:08
---

安装paramiko有两个先决条件，python和另外一个名为PyCrypto的模块。
在WINDOWS下安装PyCrypto可能需要到这儿下载 http://www.voidspace.org.uk/python/modules.shtml#pycrypto

如果需要安装ecdsa，在命令行下输入  pip install ecdsa  即可。

我使用的是python3.3， 通过这个文档可以了解使用方法。
http://paramiko-docs.readthedocs.org/en/1.15/api/client.html

**使用方法**

<pre class="lang:default decode:true " >ssh = paramiko.SSHClient()
ssh.set_missing_host_key_policy(paramiko.AutoAddPolicy())
ssh.connect("IP地址",22,"用户名", "口令")</pre> 