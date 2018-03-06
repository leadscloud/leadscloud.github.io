---
title: 使用ngrok搭建微信开发本地测试环境
date: 2018-03-06 19:14:30
tags: [微信,ngrok]
id: 316018
categories: 技术
---

微信开发的时候，必须要输入URL而且必须是外网域名，导致本地没法调试，不过使用ngrok可以创建一个内网穿透的服务器，这样就可以使用本地的服务器调试了。

[ngrock下载地址](https://ngrok.com/download)


开启 ssh 端口

`./ngrok tcp 22`

这时在外网即可 ssh 访问本机：

`ssh user@0.tcp.ngrok.io -p17840`

开启 http(s) 服务：

`./ngrok http 80`

免费版并不能自定义域名，每次启动时的端口都会改变

[CentOS6 搭建自己的 ngrok 服务](https://juejin.im/entry/58adb743b123db006730e691)

https://www.ngrok.cc/
https://natapp.cn/