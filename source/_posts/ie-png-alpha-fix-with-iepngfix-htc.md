---
title: ie-png-alpha-fix-with-iepngfix-htc
tags:
  - IE6
  - PNG透明
id: 313272
categories:
  - 前端设计
date: 2012-02-27 09:55:46
---

使用iepngfix.htc文件解决png图片在IE6下不透明的问题。

什么是htc文件？

从5.5版本开始，Internet Explorer（IE）开始支持Web 行为的概念。这些行为是由后缀名为.htc的脚本文件描述的，它们定义了一套方法和属性，程序员几乎可以把这些方法和属性应用到HTML页面上的任何元素上去。Web 行为是非常伟大的因为它们允许程序员把自定义的功能“连接”到现有的元素和控件，而不是必须让用户下载二进制文件（例如ActiveX 控件）来完成这个功能。Web 行为还是推荐的扩展IE对象模型和控件集的方法。 [更多介绍](http://baike.baidu.com/view/1540585.htm)

下面这个网站给出了解决方法：

[http://www.twinhelix.com/css/iepngfix/](http://www.twinhelix.com/css/iepngfix/)

[http://www.twinhelix.com/css/iepngfix/demo/](http://www.twinhelix.com/css/iepngfix/demo/)

一点介绍：

This is a IE5.5+ "behavior" that automatically adds near-native PNG support to MSIE 5.5 and 6.0 without any changes to the HTML document itself. Supported features include:

*   Automatic activation of transparency for PNGs in the page.
*   Support for &lt;IMG SRC=""&gt; elements.
*   Support for background PNG images (unlike many other scripts!)
*   Support for CSS1 background repeat and position (via optional add-on)
*   Background images can be defined inline or in external stylesheets.
*   Automatically handles changed SRC/background via normal JavaScript  (e.g. mouseover rollovers) -- no special coding needed.
*   Change support includes CSS 'className' changes on elements.
*   Incorporates automatic workaround for &lt;a href=""&gt; elements within  PNG-background elements.
*   Tiny script (for fast downloads).
*   Licensed under a Free Software license.