---
title: 用relexternal代替target_blank
tags:
  - JavaScript
  - JS
id: 273002
categories:
  - HTML/CSS
date: 2011-01-05 05:51:56
---

虽然一般情况下用target="_blank"没有什么错误，但如果你想让你的HTML通过CSS Strict验证则不能使用这个属性。作为替代方案，rel="external" 可以用JS来解决。

首先要加载一个js

```
<script type="text/javascript" src="external.js"></script>
```

a 标签要这样写

```
<a rel="external">external link</a>
```

下面是JS代码

```
function externalLinks() {
 if (!document.getElementsByTagName) return;
 var anchors = document.getElementsByTagName("a");
 for (var i=0; i<anchors.length; i++) {
   var anchor = anchors[i];
   if (anchor.getAttribute("href") &amp;&amp;

       anchor.getAttribute("rel") == "external")
     anchor.target = "_blank";
 }
}
window.onload = externalLinks;
```

不过我在网上也看到另外一个版本的在新窗口找开链接的JS，JS比较长，你可以作为参考。

[http://www.456bereastreet.com/archive/200610/opening_new_windows_with_javascript_version_12/](http://www.456bereastreet.com/archive/200610/opening_new_windows_with_javascript_version_12/)