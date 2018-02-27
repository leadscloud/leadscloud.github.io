---
title: wordpress中魔法函数magic_quotes_gpc自动转义单双引号
tags:
  - PHP
  - wordpress
id: 259001
categories:
  - PHP学习
date: 2010-12-20 05:31:22
---

今天在装wordpress插件时，发现magic_quotes_gpc好像是默认开启的，即使我的php.ini文件中magic_quotes_gpc = off ,$_POST["string"] 还是会自动转义符，比如我加script代码，双引号"会变成\" &nbsp;。

get_magic_quotes_gpc函数取得PHP环境变数magic_quotes_gpc 的值。
如果magic_quotes_gpc没有打开，可用addslashes()函数进行转义。

PHP中提供了自动在字符串中加入或去除转义字符的函数addcslashes和stripcslashes&nbsp;

下面简单介绍这两个函数的用法：

&nbsp;string addcslashes(string str,string charlist)：第1个参数str为待失物原始字符串，第2个参数charlist说明需要在原始串的哪些字符前加上字符“\”。
string stripcslashes(string str)：去掉字符串中的“\”。

于是把$_POST["code"]替换成stripcslashes($_POST["code"]) 就解决了插件总是在wp-options中插入\"的问题。