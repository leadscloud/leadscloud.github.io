---
title: Github Page绑定二级域名
tags:
  - github
id: 313851
categories:
  - 技术
date: 2014-06-16 09:20:14
---

Github Page绑定二级域名或者顶级域名，需要做两件事，一个是在github page下面创建 CNAME文件，一个就是设置你的DNS。

## CNAME

创建一个CNAME文件，内容是你的域名，如：
domain.org
然后把此文件添加到Github仓库，上传到Github。Github服务器会设置domain.org为你的主域名，然后将www.domain.org和demo.github.com重定向到domain.org。

有一个在线的编辑器  http://prose.io/ 使用它可以在线修改你的github page，非常方便，适合不会使用命令的同学。

如果是想绑定二级域名，上面的设置还是不够的，比如你想把二级域名sub.domain.org 绑定到 demo.github.com ，你需要在CNAME文件里加上sub.demo.org

## DNS

登陆你的域名管理界面。创建一条A记录，指向207.97.227.245这个IP地址。
以`sub.domain.org`为博客域名，指向Github Page。
需要做的设置：


*   创建CNAME文件，内容为`sub.domain.org`。
*   登陆域名管理，创建CNAME记录，sub -> `demo.github.com`。


Github作免费空间有300M的空间限制 。