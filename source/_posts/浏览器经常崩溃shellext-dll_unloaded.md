---
title: 浏览器经常崩溃shellext-dll_unloaded
id: 313601
categories:
  - 个人日志
date: 2013-06-13 12:22:26
tags:
---

最近浏览器在保存图片或上传文件时经常崩溃, 个人猜测是因为windows资源管理器的问题, 一直无法解决,今天能过windows的事件查看器,看到以下错误,在网上搜索,果然发现有类似问题, 其实不是浏览器的问题, 以前经常是搜索chrome经常崩溃怎么办, 所以没的到解决办法.

Application Error

错误应用程序名称: chrome.exe，版本: 26.0.1410.64，时间戳: 0x5163bfb1
错误模块名称: shellext.dll_unloaded，版本: 0.0.0.0，时间戳: 0x50d2bf97
异常代码: 0xc0000005
错误偏移量: 0x11df83fa
错误进程 ID: 0x620
错误应用程序启动时间: 0x01ce67dd5bda0094
错误应用程序路径: C:\Program Files\Google\Chrome\Application\chrome.exe
错误模块路径: shellext.dll
报告 ID: 719d9e97-d420-11e2-9e59-50e5494efd95

问题出在 shellext.dll, 是软件桌面工具,http://www.wenjian.cn/xijie/shellext.dll.html .

根据这篇文章([http://blog.csdn.net/phoenix2121/article/details/8854501](http://blog.csdn.net/phoenix2121/article/details/8854501))确定是快用青苹果助手的问题. 把快用助手卸载掉就行了.