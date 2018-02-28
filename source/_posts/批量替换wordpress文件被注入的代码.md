---
title: 批量替换wordpress文件被注入的代码
tags:
  - wordpress
  - wordpress注入
id: 313293
categories:
  - Wordpress学习
date: 2012-04-11 11:55:46
---

wordpress有时会被别人注入代码，特别是有时所有的php文件都被加上一段编码后的长代码。如果是vps利用 linux 命令可以轻易解决注入代码问题。

```
find 要查找的目录 -name '文件类型或者名字' -mtime 多长时间内修改 -print0 | xargs -0 perl -pi -e "s/查找的字符/要替换的字符/g"
```
假设注入的代码正则表达式为：

```
\<\?php.*\/\*.*off.*?\?>
```
则相应的命令为：

```
find /home/wwwroot/ -name '*.php' -mtime -10 -print0 | xargs -0 perl -pi -e "s/\<\?php.*\/\*.*off.*?\?>//g"
```

另外，一般wordpress被注入大部分和漏洞有关，其中wordpress常用的一个timthumb 缩略图程序，老版本会引起这个问题，它会使别人任意更改你的。使用新版本会避免这个问题。所以请务必注意！

到这儿更新：

http://timthumb.googlecode.com/svn/trunk/timthumb.php