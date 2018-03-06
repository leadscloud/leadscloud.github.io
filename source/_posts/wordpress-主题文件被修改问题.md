---
title: Wordpress主题文件被修改问题
tags:
  - wordpress注入
id: 313243
categories:
  - Wordpress学习
date: 2012-01-05 03:17:22
---

由于WordPress缩略图插件timthumb.php 有严重漏洞，可能导致主题被外部写入文件。黑客可以利用这个漏洞，上传任意恶意程序到你的网站。如果你的博客主题有使用timthumb.php，请尽快更新到修复版！

在timthumb中默认定义了一个包括 Flickr、Picasa等著名图片分享网站的白名单。黑客可以通过timthumb对这些白名单验证上的漏洞，使一些来自像“http://flickr.com.yourdomain.com”这样的域名，获取上传执行PHP代码的权限。也就是说，如果你的主题有使用timthumb.php来动态生成缩略图，黑客可以通过timthumb的这个漏洞，任意上传各种恶意程序到你的timthumb.php定义的图片缓存目录！！！

注意，timthumb.php开发者的网站已经被黑客成功的通过这种方式入侵！现在，作者已经更新了timthumb.php，修复了这个漏洞。如果你的wordpress主题有使用timthumb.php生成缩略图，请更新timthumb至最新版，修复漏洞版本地址：[http://timthumb.googlecode.com/svn/trunk/timthumb.php](http://timthumb.googlecode.com/svn/trunk/timthumb.php)