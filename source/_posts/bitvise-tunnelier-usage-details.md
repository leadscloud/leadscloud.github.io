---
title: bitvise tunnelier 使用详情
tags:
  - SSH
  - Tunnelier
  - 代理
  - 翻墙
id: 313261
categories:
  - 个人日志
date: 2012-02-27 07:48:47
---

关于Bitvise Tunnelier

官方下载地址：[http://www.bitvise.com/tunnelier](http://www.bitvise.com/tunnelier)

官方推荐的绿色版下载地址：[http://tp.vbap.com.au/download](http://tp.vbap.com.au/download)

## 基本配置

### 首先是登录界面

[![](http://www.love4026.org/wp-content/uploads/2012/02/step1.jpg "step1")](http://www.love4026.org/wp-content/uploads/2012/02/step1.jpg)

在Host里填上你的SSH的服务器地址（IP或者域名），在Port里填上服务端口（一般是22或443），Username里填上用户名，Initial method里选择password（就是指定用密码作为初始化的方式），然后在Password里填入密码，最后再把”Store encrypted password in profile”选上，省得每次输密码。

### 接下来是选项配置

[![](http://www.love4026.org/wp-content/uploads/2012/02/step2.jpg "step2")](http://www.love4026.org/wp-content/uploads/2012/02/step2.jpg)

基本上就是如果第一次成功的连接中断，则自动重连。连接好后不自动打开终端控制台（因为我们并不是要连接上操作对方的linux，而只是翻个墙，使用SSH）

### 然后是服务配置

[![](http://www.love4026.org/wp-content/uploads/2012/02/step3.jpg "step3")](http://www.love4026.org/wp-content/uploads/2012/02/step3.jpg)

监听127.0.0.1，就是监听自己的电脑，端口自己填，默认1080，我用了7070 。 上图我用的本机IP,就为了局域网的其他电脑可以使用我的SSH，要把specify server pulic IP 选上。

### 最后是SSH选项（可选的）

[![](http://www.love4026.org/wp-content/uploads/2012/02/step4.jpg "step4")](http://www.love4026.org/wp-content/uploads/2012/02/step4.jpg)

据说选上这种压缩方式可以节省一定的带宽.

### 储存这次的配置到硬盘

[![](http://www.love4026.org/wp-content/uploads/2012/02/step5.png "step5")](http://www.love4026.org/wp-content/uploads/2012/02/step5.png)

选择左边的Save Profile，选个地方保存就是了。

好了，以上就是基本的配置，点击连接就大功告成了，连接成功后，会提示你储存交换后的key，选yes。 [![](http://www.love4026.org/wp-content/uploads/2012/02/step6.png "step6")](http://www.love4026.org/wp-content/uploads/2012/02/step6.png)

在Tunnelier出现如上图最后一行的提示信息后，说明连接成功，然后就在浏览器里面设置代理就行了，IE和Chrome是一种方式，firefox是独立的一种方式。

## 注意事项

**<strong>http代理与socks代理**</strong>

tunnelier应该被作为socks代理而不是http代理来使用，而我们一般的设置中，如果在http代理中填入了http的代理地址和端口，浏览器就会优先使用http代理，这与tunnelier冲突，会出现不能连接现象。在chrome插件SwitchySharp 下应该设置为： [![](http://www.love4026.org/wp-content/uploads/2012/02/step7.jpg "step7")](http://www.love4026.org/wp-content/uploads/2012/02/step7.jpg)

如果你想把socks代理转换成http代理，点击下面的连接：

[http://www.love4026.org/19001/ie%E6%B5%8F%E8%A7%88%E5%99%A8%E4%BD%BF%E7%94%A8ssh%E4%BB%A3%E7%90%86%E7%BF%BB%E5%A2%99/](http://www.love4026.org/19001/ie%e6%b5%8f%e8%a7%88%e5%99%a8%e4%bd%bf%e7%94%a8ssh%e4%bb%a3%e7%90%86%e7%bf%bb%e5%a2%99/ "IE浏览器使用SSH代理翻墙")