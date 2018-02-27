---
title: 教程让tortoise-hgmercurial和putty免密码登陆ssh服务器
id: 313533
categories:
  - 转载
date: 2012-12-18 01:37:23
tags:
---

作为一个mercurial的忠实用户,在日常使用时觉得每次同步代码的时候输入ssh密码甚为繁琐,查看了下[官方的文档](http://tortoisehg.bitbucket.org/manual/2.1/sync.html#ssh)发现Tortoise HG的运行机制,发现它用的是putty程序中的plink来实现数据链接同时还支持pageant key agent,也就是意味着可以让Tortoise HG用私钥来访问SSH服务器了.下面是操作步骤:

1\. 用putty工具生成私钥文件

去putty官网下载[puttygen.exe](http://the.earth.li/~sgtatham/putty/latest/x86/puttygen.exe)

下载后运行, 界面效果如下:

[![点击查看原图](http://be-evil.org/content/uploadfile/201201/thum-e36ddfc62e79410164dccc1f20e90c2020120130181503.png)](http://be-evil.org/content/uploadfile/201201/e36ddfc62e79410164dccc1f20e90c2020120130181503.png)

点击Generate按钮后在下图红框中的区域来回晃动鼠标指针,直到进度条走满为止

[![点击查看原图](http://be-evil.org/content/uploadfile/201201/thum-8906e388b7777c97b9f65bd8174910b920120130181503.png)](http://be-evil.org/content/uploadfile/201201/8906e388b7777c97b9f65bd8174910b920120130181503.png)

进度条走满后,请选择 Save private key 来将私钥保存为一个ppk文件

[![点击查看原图](http://be-evil.org/content/uploadfile/201201/thum-71a4b03b5aff0c0c4dd015b518fe453b20120130181503.png)](http://be-evil.org/content/uploadfile/201201/71a4b03b5aff0c0c4dd015b518fe453b20120130181503.png)

然后请将上图中 "Public key for pasting into OpenSSH authorized_keys file" 文本框中的 ssh-rsa 开头的字符串整个复制出来,下雨步骤将会用到这个字符串

2\. 在SSH服务器上注册你的私钥

用putty或者其他ssh客户端登陆你的ssh服务器,运行命令

**vi ~/.ssh/authorized_keys**

按i(vi编辑器的插入命令)之后把粘贴的字符串复制进去,按esc键再输入:wq保存该文件(如果提示没有.ssh文件夹或者authorized_keys你可以手动创建).另外请注意注意,每个私钥的字符串只能使用一行

[![点击查看原图](http://be-evil.org/content/uploadfile/201201/1d48fe1ff92365e01195973549c01a9a20120130182556.png)](http://be-evil.org/content/uploadfile/201201/1d48fe1ff92365e01195973549c01a9a20120130182556.png)

3\. 用putty验证你的私钥工作正常

打开putty,新建一个ssh链接,选择data,在这里填写你登陆ssh服务器的用户名

[![点击查看原图](http://be-evil.org/content/uploadfile/201202/thum-74e66bd531867bc7b0c80372f08acc1c20120201121236.png)](http://be-evil.org/content/uploadfile/201202/74e66bd531867bc7b0c80372f08acc1c20120201121236.png)

然后在切换到Auth,在右侧选择你先前保存的ppk文件

[![点击查看原图](http://be-evil.org/content/uploadfile/201201/thum-f6c57ed61955aeed05d88bedbf5d9da320120130182737.png)](http://be-evil.org/content/uploadfile/201201/f6c57ed61955aeed05d88bedbf5d9da320120130182737.png)

&nbsp;

设定好之后,点击open按钮,putty就会自动登陆到ssh服务器而不会在让你输入密码了,登陆信息显示如下

[![点击查看原图](http://be-evil.org/content/uploadfile/201201/5fa62c94b058ac936c8f7b0183b747fd20120130183539.png)](http://be-evil.org/content/uploadfile/201201/5fa62c94b058ac936c8f7b0183b747fd20120130183539.png)

&nbsp;

4\. 让你的Tortoise HG也用上私钥

全局法:

如果你想你电脑上所有的HG版本库在同步的时候都用上同一个私钥文件的话,请按照下面的方法操作

在你操作系统的个人目录(Windows 7的话路径是C:\Users\用户名)中,应该有一个mercurial.ini(如果没有请创建之), 用文本编辑器打开这个文件, 在[ui]部分增加下面的配置信息

ssh = tortoiseplink.exe -ssh -i "D:\my.ppk"

请注意: 你需要将 D:\my.ppk 替换为你自己电脑上保存先前生成ppk文件的完整路径,配置文件内容参考如下

[![点击查看原图](http://be-evil.org/content/uploadfile/201201/thum-5489ae89fbfda297455c5093aa9dc6f720120130184213.png)](http://be-evil.org/content/uploadfile/201201/5489ae89fbfda297455c5093aa9dc6f720120130184213.png)

版本库法:

如果你只是想让个别几个版本库使用私钥同步

请用文本编辑器打开你版本库目录/.hg/hgrc这个文件

剩下的操作请参看全局法即可

保存完毕之后,可以试试使用hg pull 或者 push 功能来同步数据, 如果在输出窗口看到下面信息的输出,恭喜你,设定成功了.

[![点击查看原图](http://be-evil.org/content/uploadfile/201201/thum-4fd76a5d2ca20748ee9505de33e888f320120130185640.png)](http://be-evil.org/content/uploadfile/201201/4fd76a5d2ca20748ee9505de33e888f320120130185640.png)

原文：[http://be-evil.org/post-293.html](http://be-evil.org/post-293.html)