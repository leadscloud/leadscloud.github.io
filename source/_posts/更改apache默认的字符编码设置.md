---
title: 更改apache默认的字符编码设置
id: 313899
categories:
  - 个人日志
date: 2014-09-04 13:08:37
tags:
---

从服务器上直接看txt文件有时会显示乱码，更改下网页编码即可，但这样对于用户不太友好。、
后来发现服务器在返回响应时的编码没有设置。
在.htaccess文件中加上下面一句话即可。

<pre class="lang:default decode:true " >AddDefaultCharset utf-8</pre> 

没添加前的服务器响应：
<pre class="lang:default decode:true " >Content-Type:text/plain;</pre> 

添加后的服务器响应：
<pre class="lang:default decode:true " >Content-Type:text/plain; charset=utf-8</pre> 
可以看到，多了一个 `charset=utf-8`