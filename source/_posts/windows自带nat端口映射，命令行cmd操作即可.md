---
title: windows自带nat端口映射，命令行cmd操作即可
id: 313935
categories:
  - 转载
date: 2015-01-26 09:37:04
tags:
---

Windows本身命令行支持配置端口映射，条件是已经安装了IPV6，启不启用都无所谓，我在win7和server2008上是可以的。xp，2003装了ipv6协议也是可以的。

CMD下操作

增加端口映射，将10.10.10.10的11111映射到10.10.10.11的80端口 
netsh interface portproxy add v4tov4 listenport=11111 listenaddress=10.10.10.10 connectport=80 connectaddress=10.10.10.11

删除端口映射 
netsh interface portproxy del v4tov4 listenport=11111 listenaddress=10.10.10.10

查看已存在的端口映射 
netsh interface portproxy show v4tov4

可以通过命令 netstat -ano|find “11111” 查看端口是否已在监听

telnet 10.10.10.10 11111 测试端口是否连通