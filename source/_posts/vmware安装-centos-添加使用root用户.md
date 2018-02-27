---
title: vmware安装-centos-添加使用root用户
id: 313705
categories:
  - Linux
date: 2014-02-07 07:05:43
tags:
---

Vmware简易安装linux系统centos6.4 时，默认只能自己创建一个非root用户（因为root用户默认存在），所以你安装好后，是没法使用root用户登陆的。
下面是如何给root用户添加密码。

1、进入超级用户模式
[demo@localhost ~]$ su
Password:

2、添加文件的写权限
[root@localhost demo]# chmod u+w /etc/sudoers

3、编辑/etc/sudoers文件。也就是输入命令"vi /etc/sudoers",进入编辑模式，找到这一 行："root ALL=(ALL) ALL"在起下面添加"demo ALL=(ALL) ALL"(这里的demo是你的用户名)，然后保存退出。
[root@localhost demo]# vi /etc/sudoers

4、撤销文件的写权限。
[root@localhost demo]# chmod u-w /etc/sudoers