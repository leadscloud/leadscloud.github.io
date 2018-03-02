---
title: linux VPS添加最低权限的SSH账号
id: 313586
categories:
  - 个人日志
date: 2013-04-07 07:29:43
tags:
---

useradd -M -s /sbin/nologin -n username

passwd username

输入两次密码就行了，然后你就可以使用了。可以使用myentunnela或者BitviseSSHClient。