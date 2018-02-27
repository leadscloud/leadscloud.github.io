---
title: wordpress文章置顶的方法
tags:
  - wordpress
id: 200001
categories:
  - HTML/CSS
date: 2010-11-27 05:32:10
---

&nbsp; 和以往wordpress相关问题解决方案一样，WordPress文章置顶的方案也分为无插件方案和使用插件两种方法。<span id="more-1787"></span>

**<span style="color: rgb(255, 102, 0);">无插件WordPress文章置顶方法</span>**

不使用插件让Wordpress文章置顶非常简单，只是这个功能被很多网友忽略了，文章发表后可以在快速编辑模式可以将文章直接设置为置顶，如下图：

[![](http://www.iewb.net/wp-content/uploads/2010/09/wp-300x87.jpg "wp")](http://www.iewb.net/wp-content/uploads/2010/09/wp.jpg)

在快速编辑模式除了设置置顶，还可以为文章加密码，相信这两个功能有不少网友都忽略了（其中就包括我）。

什么？找不到快速编辑？1、写好文章并发布 2、点击博客后台文章菜单下的“编辑”选项，进入文章列表 3、把鼠标移到需要置顶的文章上，在文章标题下就会显示出“编辑”、“快速编辑”、“删除”、“查看”四个选项，点击“快速编辑”，就会看到上面的图片。

**小技巧**：Wordpress文章标题能识别Html代码，网友可以为置顶的文章改下标题颜色，代码示例:

<div class="hl-surround"><div class="hl-main">&lt;span style="color: #43bc65;"&gt;[置顶]WordPress文章置顶的方法&lt;/span&gt;</div></div>

Wordpress的文章置顶插件有不少，推荐[Classic Posts](http://www.chrisvschris.com/classic-posts/)与[sticky](http://lesterchan.net/wordpress/readme/wp-sticky.html)。

与上面的方法相比，使用插件显的有些多余，不过插件的功能会多一些，都能很方便的管理置顶文章，比如可以设置显示选定文章的全文或者摘要，并且摘要数字可调，设置当天文章置顶之类。有这些特殊要求的网友可以选择插件方式。

注：这两个插件安装的时候都需要在Wordpress模板中插入相关代码。