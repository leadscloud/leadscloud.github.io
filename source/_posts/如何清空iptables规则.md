---
title: 如何清空iptables规则
tags:
  - iptables
  - VPS
id: 313379
categories:
  - Linux
date: 2012-05-27 11:39:11
---

最近发现屏蔽中国也许也许是个错误的决定。

如果想清空的话，先执行

/sbin/iptables -P INPUT ACCEPT

然后执行

/sbin/iptables -F

查看规则的话使用 

iptables -L

iptables 的使用

http://www.vpser.net/security/linux-iptables.html

用 iptables 屏蔽来自中国的 IP
http://www.vpser.net/security/iptables-block-countries-ip.html