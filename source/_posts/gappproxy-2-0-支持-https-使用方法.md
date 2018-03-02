---
title: GAppProxy 2.0 支持 https 使用方法
tags:
  - 代理
  - 翻墙
id: 313109
categories:
  - 个人日志
date: 2011-02-26 09:10:53
---

[![](http://love4026.files.wordpress.com/2011/02/gappproxy2-0.png)](http://love4026.files.wordpress.com/2011/02/gappproxy2-0.png)

GAppProxy是一个开源的HTTP Proxy软件，用它翻墙浏览网页的速度非常的快，原因是它使用Python编写，运行于Google App Engine上，依托于google的网络服务，所以可靠、稳定。

其实你也可以理解为它是一个项目，具体的介绍参见[GAppProxy介绍](http://code.google.com/p/gappproxy/) ，对于没有一些技术基础的人来说，布署GAppProxy是相当麻烦的一件事，至少当时我第一次接触，费了很大劲才搞明白是怎么回事。这儿只讲下最新版本2.0的使用方法。如果你想了解更多，请联系我。

GAppProxy的优化点就是速度快，而它的缺点主要是：GAppProxy目前存在一些没解决的问题:

*   1,Web 登录问题: 部分Web系统无法正常登录,这个原因主要是和待登录网站要求的安全性以及GAE平台的局限性相关。*   2,为支持HTTPS,GAppProxy使用了一种妥协的方式,该方式从原理上破坏了HTTPS固有的安全性,将HTTPS的安全级别降到了HTTP级,所以如果你要传输重要数据,请不要使用该HTTPS代理.此外HTTPS不支持服务器/客户认证,这也和GAE有关。*   3,不支持大尺寸的文件上传,GAE 对上传文件尺寸有限制。*   4,每月1G的流量，如果你看高清视频的话，可能不够用的。*   GAppProxy只支持80和443端口（其他端口网站无法代理），只支持HEAD、GET、POST方法（GAE支持的PUT、DELETE没被支持），不能上传二进制文件如图片（Twitter头像无法更新），不能断点续传（大文件下载一半被中断后需要重新下载），只能架在GAE上（GAE的DELETE方法不完整，因而从Twitter的List中删除某人是用基于GAE的代理无法实现的)，HTTPS会弹出证书无效的警告  

其实它还是很好用的，至少大部分情况下是没有问题的。

GAppProxy 2.0.0相关下载：    
[![](http://code.google.com/hosting/images/dl_arrow.gif) ](http://gappproxy.googlecode.com/files/GAppProxy%E4%BD%BF%E7%94%A8%E6%89%8B%E5%86%8C.doc)[GAppProxy使用手册.doc](http://code.google.com/p/gappproxy/downloads/detail?name=GAppProxy%E4%BD%BF%E7%94%A8%E6%89%8B%E5%86%8C.doc)     
[![](http://code.google.com/hosting/images/dl_arrow.gif) ](http://gappproxy.googlecode.com/files/fetchserver-2.0.0.zip)[fetchserver-2.0.0.zip](http://code.google.com/p/gappproxy/downloads/detail?name=fetchserver-2.0.0.zip)     
[![](http://code.google.com/hosting/images/dl_arrow.gif) ](http://gappproxy.googlecode.com/files/localproxy-2.0.0-win.zip)[localproxy-2.0.0-win.zip](http://code.google.com/p/gappproxy/downloads/detail?name=localproxy-2.0.0-win.zip)     
[![](http://code.google.com/hosting/images/dl_arrow.gif) ](http://gappproxy.googlecode.com/files/localproxy-2.0.0.tar.gz)[localproxy-2.0.0.tar.gz](http://code.google.com/p/gappproxy/downloads/detail?name=localproxy-2.0.0.tar.gz)     
[![](http://code.google.com/hosting/images/dl_arrow.gif) ](http://gappproxy.googlecode.com/files/uploader-2.0.0-win.zip)[uploader-2.0.0-win.zip](http://code.google.com/p/gappproxy/downloads/detail?name=uploader-2.0.0-win.zip) 

**说明：**

[GAppProxy使用手册.doc](http://code.google.com/p/gappproxy/downloads/detail?name=GAppProxy%E4%BD%BF%E7%94%A8%E6%89%8B%E5%86%8C.doc)中有详细的说明，即使你是个新手应该也能一步一步的学会的，请仔细阅读。你也可以在这儿看此[帮助文件](http://code.google.com/p/gappproxy/wiki/GAppProxy_2_0_0_Manual)

[localproxy-2.0.0-win.zip](http://code.google.com/p/gappproxy/downloads/detail?name=localproxy-2.0.0-win.zip)下载完成后，解压到当前文件夹就可以了，不用安装，修改完成proxy.conf后运行proxy.exe即可，proxy.exe打开是CMD窗口形式，而且不能隐藏，相比以前版本不太好看，如果你以前装过，据说也是可以用的。

以下是其它代理，原理都是相似的。

wallproxy [http://code.google.com/p/wallproxy/](http://code.google.com/p/wallproxy/)    
hyk-proxy [http://code.google.com/p/hyk-proxy/](http://code.google.com/p/hyk-proxy/)    
gappproxy [http://code.google.com/p/gappproxy/](http://code.google.com/p/gappproxy/)

其它的翻墙软件介绍： [SSH](http://www.love4026.org/19001/ie%E6%B5%8F%E8%A7%88%E5%99%A8%E4%BD%BF%E7%94%A8ssh%E4%BB%A3%E7%90%86%E7%BF%BB%E5%A2%99/)
  