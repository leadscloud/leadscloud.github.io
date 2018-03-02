---
title: Wordpress 转为 Hexo 静态博客
tags:
  - hexo
  - wordress
id: 315000
categories:
  - 个人日志
date: 2017-06-16 12:28:54
---

wordpress转为hexo博客，导出的时候有些小问题，记录一下。


## 下划线转义问题

`hexo-util/lib/slugize.js`
va rSpecial 更改下下划线

## 文章标题中含有特殊字符串问题

`hexo-migrator-wordpress/index.js`

90多行上下, 改为: `title: slug || title`



