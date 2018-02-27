---
title: is-not-in-the-sudoers-file-this-incident-will-be-reported-解决办法
id: 313622
categories:
  - Linux
date: 2013-08-03 04:55:36
tags:
---

is not in the sudoers file. This incident will be reported

安装centos后，想直接使用root用户，但是 sudo passwd root 会出现上面的提示。解决办法如下

    1>、进入超级用户模式。也就是输入"su -",系统会让你输入超级用户密码，输入密码后就进入了超级用户模式。（当然，你也可以直接用root用户登录，因为红旗安装过后默认的登录用户就是root）
    2>、添加文件的写权限。也就是输入命令"chmod u+w /etc/sudoers"。
    3>、编辑/etc/sudoers文件。也就是输入命令"vim /etc/sudoers",输入"i"进入编辑模式，找到这一 行："root ALL=(ALL) ALL"在起下面添加"xxx ALL=(ALL) ALL"(这里的xxx是你的用户名)，然后保存（就是先摁一 下Esc键，然后输入":wq"）退出。
    4>、撤销文件的写权限。也就是输入命令"chmod u-w /etc/sudoers"。
    至此，问题解决。 