---
title: abbr和acronym标签简介与使用
id: 313343
categories:
  - HTML/CSS
tags:
---

很多人都喜欢使用缩略词来表述特定的事物或是事件，这样做的好处是方便快递地传达信息，而不用每次都去打那么长的文字，特别是对于重复出现的词汇。例如XFN，如果知道的人自然会明白是[xhtml](http://www.yzznl.cn/category/xhtml "xhtml") Friends Network，可是还有很多没听过的人呢？这种情况下就要用到[园子](http://www.yzznl.cn/about "园子")介绍的两个标签——**abbr**与**acronym**。

这两个标签的大致用途是一样的，但是也还是有细节上的不同。总结如下：

*   &lt;abbr&gt;&lt;/abbr&gt;的作用是表明标签中的内容为缩写形式。例如：
<div>
<div>
<pre>&lt;abbr title=”World Wide Web”&gt;WWW&lt;/abbr &gt;</pre>
</div>
</div>
*   &lt;acronym&gt;&lt;/acronym&gt;的作用是表明标签中的内容是首字母缩写词。例如：
<div>
<div>
<pre>&lt;acronym title=”Radio detecting and ranging”&gt; Radar&lt;/acronym&gt;</pre>
</div>
</div>
一般来讲acronym要比abbr在英文中常用，但是在中文正好相反。因为中文中没有首字母缩写。也许有首字缩写但这也比较少有。例如：中华人民共和国，简称是中国；全国人民代表大会，简称是人代会；这些都不是首字缩写，这里园子倒是觉得文中出现中国成语的时候应该使用abbr。当然光只有这个标签还不行，因为只知道他是个缩略词还不行，至少还要给出详细的名称啊。所以这两个标签在使用的时候还要再加上一个title属性。正确的写法应该是这样的。
<div>
<div>
<pre>&lt;acronym title=”European Computer Manufacturers Association”&gt;ECMA&lt;/acronym&gt;</pre>
</div>
</div>
<div>
<div>
<pre>&lt;abbr title=”这个是介绍XHTML知识的专题”&gt;XHTML专题&lt;/abbr&gt;</pre>
</div>
</div>
在浏览器上并不会直接显示title里的内容，只有当鼠标移动到那个位置后才会出现悬浮提示。当然一般缩写标签只在缩略词第一次出现的时候使用，以后文章中再出现就可以不用了。在使用&lt;abbr&gt;还有一个问题，就是IE6及以下版本的IE浏览器并不认识这个标签，不过也有变相解决的方式，例如用插入span的方式来代替。

说到这里还有一种情况，有的时候，一个词别人不一定知道是什么，但又不是缩略语，这就用到了&lt;dfn&gt;标签，例如：
<div>
<div>
<pre>&lt;p&gt;&lt;dfn title=”Mozilla公司推出的一款网页浏览器”&gt;Firefox&lt;/dfn&gt;作为开发工具很不错。&lt;/p&gt;</pre>
</div>
</div>
它有点像我们写文章时的：“Firefox（Mozilla基金会推出的一款网页浏览器）作为开发工具很不错”，dfn英文原意是definition，也就是术语定义的意思。