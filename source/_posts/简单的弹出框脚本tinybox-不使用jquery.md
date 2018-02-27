---
title: 简单的弹出框脚本tinybox-不使用jquery
tags:
  - JavaScript
id: 35001
categories:
  - HTML/CSS
date: 2010-09-11 09:15:38
---

<span style="font-family: Arial; font-size: 14px; color: rgb(65, 65, 65); line-height: 22px; "></span>

[TinyBox](http://www.leigeber.com/2009/05/javascript-popup-box/)&nbsp;是一个轻量级并且独立的弹出窗口脚本，该脚本只有 3.94KB，虽然只有很简单的功能，但可以显示任何的 AJAX 和 HTML 内容，还支持图片，并且能够自动隐藏，你可以通过修改 CSS 来定制样式的效果。TinyBox 已经在 Firefox 2/3, IE 6/7/8, Opera, Safari 和 Chrome 中测试过。使用 TinyBox 非常简单，通过一下代码即可：
<pre style="margin-top: 0px; margin-right: 0px; margin-bottom: 20px; margin-left: 0px; padding-top: 4px; padding-right: 4px; padding-bottom: 4px; padding-left: 4px; background-image: initial; background-attachment: initial; background-origin: initial; background-clip: initial; background-color: rgb(237, 243, 222); white-space: pre-wrap; word-wrap: break-word; background-position: initial initial; background-repeat: initial initial; ">TINY.box.show('advanced.html',1,300,150,1,3)
</pre>

它一共有6个参数，第一个是要显示的 AJAX 或 HTML 内容。第二个是设置是否为 AJAX。第三个是宽度，0 为自动。第四个是高度，0 为自动。第五个是是否设置隐藏，第六个则是设置是否自动隐藏的时间。

[演示](http://sandbox.leigeber.com/tinybox/)&nbsp;+&nbsp;[下载](http://sandbox.leigeber.com/tinybox/tinybox.zip)