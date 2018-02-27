---
title: ix空间虚拟主机wordpress遭sql注入恶意js代码
tags:
  - sql注入
  - wordpress
id: 313177
categories:
  - Wordpress学习
date: 2011-07-19 07:56:45
---

今天发现放在ix空间上的一个网站，被注入恶意代码，google搜索结果出现 [This site may harm your computer.](http://www.google.com/support/bin/answer.py?answer=45449&amp;topic=360&amp;hl=en&amp;?sa=X&amp;ei=wzYlTr_-FKPiiAKQobmACg&amp;ved=0CBoQ2gEwAA) ，提交tickets ，只是告诉我说被sql注入，然后说已经帮我清理完毕，但请我升级当前的应用程序。  个人感觉原因不应该是wordpress版本的问题，因为wordpress是3.1.1的。

下面是我的一些处理办法，今天刚刚发现的，这些办法也不知道是不是有用，但至少可以暂时去掉这些可恶的恶意代码 ，这些恶意代码其实就是一小段js，放置在网站文章中最后。形似&lt;script src="http://123.com"&gt;&lt;/script&gt; ，如果发现可以先在数据库中去掉这些代码。

UPDATE wp_posts SET post_content = replace(post_content, '要去的内容', '');

用上面这句sql语句就行了。其它的就是升级你的wordpress版本，希望这样便能解决你的问题，我也是这样希望的。静候佳音!