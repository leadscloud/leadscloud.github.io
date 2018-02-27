---
title: ie6下使用滤镜后链接不能点击或onclick功能不能用的bug
tags:
  - IE6
  - IE6滤镜
id: 313138
categories:
  - HTML/CSS
date: 2011-04-09 07:43:05
---

大家可能都知道IE6下使用DXImageTransform.Microsoft.AlphaImageLoader滤镜（用于PNG32 Alpha透明）后链接不能点击的BUG，大家也都知道只要在a标签上加相对定位的属性（position:relative）就可以点击了。

见demo页面中的例子1：[http://www.css88.com/demo/ie6bug_filter/](http://www.css88.com/demo/ie6bug_filter/)(使用IE6查看)；

非常好！但是如果在使用滤镜容器的中加上绝对定位，悲剧发生了！a标签上加相对定位的属性（position:relative）链接依然不能点击！

见demo页面中的例子2：[http://www.css88.com/demo/ie6bug_filter/](http://www.css88.com/demo/ie6bug_filter/)(使用IE6查看)；

经过近半个小时的折腾终于有了解决方案，就是在使用滤镜的容器外面再加上一个容器，这个容器加上绝对定位。a标签上加相对定位的属性（position:relative）就可以点击了。

见demo页面中的例子3：[http://www.css88.com/demo/ie6bug_filter/](http://www.css88.com/demo/ie6bug_filter/)(使用IE6查看)；

原因可能如下：

DXImageTransform.Microsoft.AlphaImageLoader可能改变了容器的层级，真好正好定位属性也能改变元素层级。

如果你知道原因或者有更好的解决方案欢迎留言斧正，探讨。谢谢！

原文地址：http://www.css88.com/archives/2916