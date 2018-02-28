---
title: appserv安装与配置支持rewrite，让wordpress支持固定连接
tags:
  - wordpress
id: 276001
categories:
  - PHP学习
date: 2011-01-04 06:55:09
---

这是一个PHP集成化的开发环境，可在本机测试安装，安装很简单，一直点一下步下一步就行了。

官方下载网址是：http://www.appservnetwork.com/

在用appserv测试wordpress时默认是不支持固定链接（永久链接）的，如果要启用permalink功能：

安装成功后打开

AppServ\Apache2.2\conf\httpd.conf文件

找到

```
#LoadModule rewrite_module modules/mod_rewrite.so
```

去掉前面的注释就行了

然后重启apache,不过我的电脑重启后也不行，不过重启动电脑后就行了。