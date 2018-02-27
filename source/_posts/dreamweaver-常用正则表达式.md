---
title: dreamweaver-常用正则表达式
tags:
  - 正则表达式
id: 313238
categories:
  - 前端设计
date: 2011-12-01 06:41:18
---

&lt;[^&gt;]*&gt;   //去除所有的标签

 &lt;script[^&gt;]*?&gt;.*?&lt;/script&gt; //去除所有脚本，中间部分也删除

 &lt;img[^&gt;]*&gt;  //去除图片的正则

 &lt;(?!br).*?&gt;    //去除所有标签，只剩br

 &lt;table[^&gt;]*?&gt;.*?&lt;/table&gt;    //去除table里面的所有内容

 &lt;(?!img|br|p|/p).*?&gt;    //去除所有标签，只剩img,br,p
\n\s*\r  //匹配空白行
[\u4e00-\u9fa5]   //匹配中文

^\s*|\s*$  //匹配首尾空白字符的正则表达式