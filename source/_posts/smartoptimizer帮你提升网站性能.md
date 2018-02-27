---
title: smartoptimizer帮你提升网站性能
tags:
  - SmartOptimizer
  - 网站性能
id: 313276
categories:
  - 前端设计
date: 2012-03-01 06:17:09
---

SmartOptimizer （以前叫做 JSmart）,是一个PHP程序，帮助你提升网站性能。比如为你的网站增加CSS，JS压缩，缓存。 因为IX空间默认是不支持Gzip的，它在IX空间上，可以使用，并且可以让你的网站有可观的性能提升。 另外它是一个开源程序。 [https://github.com/farhadi/SmartOptimizer](https://github.com/farhadi/SmartOptimizer)

安装它之后，你的网站Pagespeed评分会更高。[https://developers.google.com/pagespeed/](https://developers.google.com/pagespeed/)

## 安装要求：

*   php 4.3或更高
*   Apache 的 mod_rewrite 要开启

## 下载地址：

[http://farhadi.ir/downloads/smartoptimizer-1.8.tar.gz](http://farhadi.ir/downloads/smartoptimizer-1.8.tar.gz)

## 安装指南：

注意以下安装指南针对apache服务，如果你不是apache服务器，移步到这里查看英文介绍。[http://farhadi.ir/works/smartoptimizer](http://farhadi.ir/works/smartoptimizer)

解压文件，把smartoptimizer文件夹上传到你网站根目录。

SmartOptimizer 需要访问cache目录，把smartoptimizer下的cache目录设置属性为777

把.htaccess 上传到你网站根目录，如果你已经有.htaccess文件，想办法把它们合并，一般把你的.htaccess文件里的内容放到最前面就行了（wordpress这样设置就行）。