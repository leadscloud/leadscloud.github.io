---
title: VPS Linux 服务器工作流程
id: 313245
categories:
  - Linux
date: 2012-01-09 02:42:05
tags:
---

[caption id="attachment_313246" align="aligncenter" width="800" caption="Linux VPS 服务器工具流程图"][![Linux VPS 服务器工具流程图](http://www.love4026.org/wp-content/uploads/2012/01/Linux-VPS.jpg "Linux VPS 服务器工具流程图")](http://www.love4026.org/wp-content/uploads/2012/01/Linux-VPS.jpg)[/caption]

客户端发起域名解析请求，由DNS解析域名，然后默认去寻找对应IP的80端口并讲head信息传给对方服务器的web程序（一直在监听80端口） 比如apache或者nginx，然后web程序根据你请求的域名和内容来返回对应的信息。