---
title: 防止其它网址解析到你的ip
id: 33001
categories:
  - HTML/CSS
date: 2010-09-10 05:20:15
tags:
---

刚做的新站[http://www.smecrusher.com](http://www.smecrusher.com)&nbsp; 昨天google site的时候终于出现首页了，然后打开快照看，竟然是imynow.cn这个站的，之后又site这个站，竟然是个垃圾站，难怪我的站一直不收录首页。别人解析到我的网站应该对我的站没什么损害的，但实际好像不是这样的，主要是因为它是个垃圾站吧。今天在网上找了个方法，把那个网址给301重定向了。
`Options +FollowSymLinks 
RewriteEngine on 
RewriteCond %{HTTP_HOST} ^imynow.cn$ [OR]
RewriteCond %{HTTP_HOST} ^www.imynow.cn$
RewriteRule ^(.*)$ http://www.gov.cn/$1 [R=301,L]
`