---
title: 修改hosts文件解决google加密搜索无法访问
tags:
  - hosts文件
id: 313181
categories:
  - Google SEO
date: 2011-08-05 05:50:12
---

google.com 的英文版经常会出现此链接被重置的现象，用google的加密搜索便能解决此问题。由于https://encrypted.google.com 被DNS污染，可用以下办法解决。

使用文本编辑器打开hosts文件：C:\Windows\System32\drivers\etc\hosts

在文件中添加如下内容：

> 64.233.183.99 encrypted.google.com