---
title: ie浏览器使用ssh代理翻墙
tags:
  - SSH
  - 代理
  - 翻墙
id: 19001
categories:
  - 个人日志
date: 2010-08-28 02:52:21
---

[SSHwall](http://www.sshwall.com/)是个很好用的翻墙工具，目前有免费版的，虽然有时会不稳定，但大部分还是正常的。并且速度快，这是ssh翻墙不同于其它的代理的一个优点。SSH配合Firefox是最完美的组合，但是由于工作原因有时会用到IE，但是ssh使用的是socks5代理，而我们平时使用的是web代理也就是http代理，所以如果用IE必须将socks5代理转化成http代理了。这儿就必须用到一个软件了。

[SSH百度百科](http://baike.baidu.com/view/16184.htm?fr=ala0_1_1)

### Privoxy

下载地址：[http://sourceforge.net/projects/ijbswa/](http://sourceforge.net/projects/ijbswa/)

下载安装完成后，在privoxy的主界面中选择“Options”—&gt;”Edit Main Configuration” ，之后会打开一个txt文档，在最后面追加两行代码，如下：

`listen-address 127.0.0.1:8118 
 ``forward-socks5 / 127.0.0.1:7070 . ` 
 别忘了7070后有个小点。 7070是代理软件MyEntunnel的端口，8181是自己设置的，不要和其它端口有冲突，自己可以换个的。

最后重启，如没有错误提示就是成功了，然后在IE的连接里配置代理地址为 127.0.0.1 8118

有关SSH代理翻墙的方法你可以到[这个网站](http://www.sshwall.com)去查看帮助文件,如果你想用免费的建议用它们的[一体包](http://www.sshwall.com/ssh_mianfei_zhangha/)，内置有免费的账号。

Ps:  如果你希望局域网中的其它的电脑共享你的代理，请把 listen-address 127.0.0.1:8118 设置为192.168.1.1:8118(也就是你自己电脑的IP地址)