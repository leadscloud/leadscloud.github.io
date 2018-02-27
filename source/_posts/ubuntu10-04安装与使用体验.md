---
title: ubuntu10-04安装与使用体验
tags:
  - Linux
  - ubuntu
id: 257001
categories:
  - 个人日志
date: 2010-12-17 13:40:28
---

[![ubuntu 10.04桌面效果](http://seoskys.appspot.com/upload/agdzZW9za3lzchILEgpVcGxvYWRGaWxlGIHQDww.png)](http://seoskys.appspot.com/upload/agdzZW9za3lzchILEgpVcGxvYWRGaWxlGIHQDww.png)

最近安装了ubuntu系统，感觉使用还不错，界面很漂亮。当然一开始用还是有些不习惯。不过装软件方便多了，我就装了chrome和firefox的最新版本的浏览器。还有fcitx软入法。有这些也足够了。以后慢慢研究，装这个系统主要是想搭建一个LAMP环境。对了，在装ubuntu的时候一开始最好不要连网，不然会下载很长时间。等前几步跑过之后再连网也不迟。 安装好之后建议安装中文语言包。里面的字体感觉还是蛮好看的。

一、Fcitx的安装方法，很多软件的安装方法都可以在这儿找到，很方便。

[http://wiki.ubuntu.org.cn/Fcitx](http://wiki.ubuntu.org.cn/Fcitx)

firefox3.6的安装方法：

1\. 到官网（[http://www.mozillaonline.com/products/firefox/](http://www.mozillaonline.com/products/firefox/)）下载最新的firefox包;

2\. 解压缩包并且把文件夹移动到你想要安装的位置

首先到你存放下载文件的目录输入下面的命令，xjvf 后面跟你下载的包的名字：

$tar xjvf firefox-3.6.3.tar.bz2

然后把解压出来的目录移到你要的位置，我的是我之前建立来装软件的目录（software）：

$sudo mv firefox /software/

3\. 在/usr/bin建立firefox的链接

首先到/usr/bin目录：

$cd /usr/bin

然后把系统默认的firefox bin文件改名字：

$sudo mv firefox firefox.old

(如果最后没有成功用$sudo mv firefox.old firefox恢复原来的版本)

最后建立链接到解压包的可执行文件：

$sudo ln -s /software/firefox/firefox

二、Chrome的安装

[http://www.google.com/chrome/intl/en/eula_dev.html?dl=unstable_i386_deb](http://www.google.com/chrome/intl/en/eula_dev.html?dl=unstable_i386_deb)

<span style="font-family: 'Lucida Grande', 'Trebuchet MS', Helvetica, Arial, sans-serif; line-height: 16px; -webkit-border-horizontal-spacing: 5px; -webkit-border-vertical-spacing: 5px; ">下载相应的包到本机后，双击运行，就可以自动安装了。
安装完后在<span style="margin-top: 0px; margin-right: 0px; margin-bottom: 0px; margin-left: 0px; padding-top: 0px; padding-right: 0px; padding-bottom: 0px; padding-left: 0px; color: rgb(255, 64, 0); ">应用程序</span>－<span style="margin-top: 0px; margin-right: 0px; margin-bottom: 0px; margin-left: 0px; padding-top: 0px; padding-right: 0px; padding-bottom: 0px; padding-left: 0px; color: rgb(255, 64, 0); ">互联网</span>－<span style="margin-top: 0px; margin-right: 0px; margin-bottom: 0px; margin-left: 0px; padding-top: 0px; padding-right: 0px; padding-bottom: 0px; padding-left: 0px; color: rgb(255, 64, 0); ">Google Chrome &nbsp; QQ安装完之后也是在这儿</span></span>

三、想安装QQ的话可以直接去官网上下deb包双击就自动安装了，很简单。