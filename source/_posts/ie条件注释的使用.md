---
title: ie条件注释的使用
tags:
  - IE
id: 44001
categories:
  - HTML/CSS
date: 2010-09-18 12:09:37
---

    最近做网站为了网站的兼容性，用到了IE注释，主要是因为不想在CSS中使用CSS Hack了。顺便说一句，IE6 must died.
    &lt;!--[if IE]&gt;这是Internet Explorer&lt; ![endif]--&gt;
    &lt;!--[if IE 5]&gt;这是Internet Explorer 5&lt; ![endif]--&gt;

    &lt;!--[if IE 7]&gt;这是Internet Explorer 7&lt; ![endif]--&gt;
    &lt;!--[if gte IE 5]&gt;这是Internet Explorer 5 或者更高&lt; ![endif]--&gt;
    &lt;!--[if lt IE 6]&gt;这是版小于6的Internet Explorer&lt; ![endif]--&gt;
    &lt;!--[if lte IE 5.5]&gt;这是Internet Explorer 5.5或更低&lt; ![endif]--&gt;

    注意两个特殊的语法：
    gt: 大于 
    lte: 小于或等于 
    !IE 感叹号的使用
    