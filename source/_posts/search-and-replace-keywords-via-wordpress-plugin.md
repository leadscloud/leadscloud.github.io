---
title: 通过插件替换wordpress关键词
id: 313345
categories:
  - Wordpress学习
date: 2012-04-26 13:58:34
tags:
---

[Search and Replace](http://wordpress.org/extend/plugins/search-and-replace/ "wodpress 下载地址")（搜索和替换）是一个允许你搜索和替换数据库中任意文本的 WordPress 插件。

## 注意：

但是这个插件同样也在存在着风险，因为它是直接[使用 SQL 进行文本替换](http://www.love4026.org/313338/find-and-replace-in-wordpress-using-mysql/ "通过Mysql批量替换WordPress的关键字")，它直接操作修改了数据库，并且这样的修改时不可撤销的，所以不建议 WordPress 初级用户使用这个插件，对于 WordPress 有一定熟悉的用户，建议使用这个插件进行操作之前，对数据库进行备份，这样万一出错还有修正的机会。

Search and Replace 是直接使用 MySQL 的 Replace 进行替换操作的，所以这个插件是**大小写敏感**的，并且不支持使用正则表达式进行文本替换，所以这是这个插件小小的一个缺憾，但是它完整的界面和易用性，保证了它能够完成了我们大部分的批量文本修改替换工作，并且这个插件只在后台使用，所以使用之后我们可以直接关闭它，完全不会占用任何系统资源。

## 相关资源：

插件作者：[http://fairyfish.net/2010/05/31/search-and-replace/](http://fairyfish.net/2010/05/31/search-and-replace/)

wordpress下载地址：[http://wordpress.org/extend/plugins/search-and-replace/](http://wordpress.org/extend/plugins/search-and-replace/)

相关文章：[http://www.love4026.org/313338/find-and-replace-in-wordpress-using-mysql/](http://www.love4026.org/313338/find-and-replace-in-wordpress-using-mysql/)