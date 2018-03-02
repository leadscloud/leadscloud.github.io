---
title: Nginx 为 http header 添加Charset utf-8
id: 313653
categories:
  - Linux
date: 2013-10-23 08:21:42
tags:
---

LNMPA下的http头信息的Content-Type: text/html 没有设置charset=utf-8
<pre class="lang:default decode:true">HTTP/1.1 200 OK
Server: nginx/1.0.15
Date: Wed, 23 Oct 2013 08:12:31 GMT
Content-Type: text/html
Connection: keep-alive
Vary: Accept-Encoding
X-Powered-By: InfoMaster/1.1.Alpha1 (Ray)</pre>
添加方法很简单

修改 /usr/local/nginx/conf/nginx.conf 在http, server, 或 location 下添加
<pre class="lang:default decode:true">charset utf-8;</pre>
使用 curl -IL info.shibangsoft.com 查看如下
<pre class="lang:default decode:true">HTTP/1.1 200 OK
Server: nginx/1.0.15
Date: Wed, 23 Oct 2013 08:19:05 GMT
Content-Type: text/html; charset=utf-8
Connection: keep-alive
Vary: Accept-Encoding
X-Powered-By: InfoMaster/1.1.Alpha1 (Ray)</pre>