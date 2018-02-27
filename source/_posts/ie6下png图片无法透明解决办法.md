---
title: ie6下png图片无法透明解决办法
tags:
  - IE6
id: 264001
categories:
  - HTML/CSS
date: 2010-12-28 03:33:47
---

<span style="font-family: verdana, sans-serif; font-size: 14px; line-height: 21px; ">**Microsoft.AlphaImageLoader**是**IE滤镜**的一种，其主要作用就是对图片进行透明处理。虽然FireFox和IE7以上的IE浏览器已经支持透明的PNG图片，但是就IE5-IE6而言还是有一定的意义。

</span><div class="cssColumnTitle">语法：</div><div>**filter : progid:DXImageTransform.Microsoft.AlphaImageLoader ( enabled=**_bEnabled_**&nbsp;, sizingMethod=**_sSize_**&nbsp;, src=**_sURL_**&nbsp;)**</div><div class="cssColumnTitle">属性：</div><table border="1" cellpadding="1" cellspacing="1"><tbody><tr><td nowrap="nowrap">**enabled**</td><td nowrap="nowrap">**:　**</td><td>可选项。布尔值(Boolean)。设置或检索滤镜是否激活。<span class="cssDefault">**true**</span>&nbsp;|&nbsp;**false**<table border="1" cellpadding="1" cellspacing="1"><tbody><tr><td nowrap="nowrap">**true**</td><td nowrap="nowrap">**:　**</td><td>**默认值**。滤镜激活。</td></tr><tr><td nowrap="nowrap">**false**</td><td nowrap="nowrap">**:　**</td><td>滤镜被禁止。</td></tr></tbody></table></td></tr><tr><td nowrap="nowrap">**sizingMethod**</td><td nowrap="nowrap">**:　**</td><td>可选项。字符串(String)。设置或检索滤镜作用的对象的图片在对象容器边界内的显示方式。<table border="1" cellpadding="1" cellspacing="1"><tbody><tr><td nowrap="nowrap">**crop**</td><td nowrap="nowrap">**:　**</td><td>剪切图片以适应对象尺寸。</td></tr><tr><td nowrap="nowrap">**image**</td><td nowrap="nowrap">**:　**</td><td>**默认值**。增大或减小对象的尺寸边界以适应图片的尺寸。</td></tr><tr><td nowrap="nowrap">**scale**</td><td nowrap="nowrap">**:　**</td><td>缩放图片以适应对象的尺寸边界。</td></tr></tbody></table></td></tr><tr><td nowrap="nowrap">**src**</td><td nowrap="nowrap">**:　**</td><td>必选项。字符串(String)。使用绝对或相对_&nbsp;url&nbsp;_地址指定背景图像。假如忽略此参数，滤镜将不会作用。</td></tr></tbody></table><div class="cssColumnTitle">特性：</div><table border="1" cellpadding="1" cellspacing="1"><tbody><tr><td nowrap="nowrap">**Enabled**</td><td nowrap="nowrap">**:　**</td><td>可读写。布尔值(Boolean)。参阅**&nbsp;enabled&nbsp;**属性。</td></tr><tr><td nowrap="nowrap">**sizingMethod**</td><td nowrap="nowrap">**:　**</td><td>可读写。字符串(String)。参阅**&nbsp;sizingMethod&nbsp;**属性。</td></tr><tr><td nowrap="nowrap">**src**</td><td nowrap="nowrap">**:　**</td><td>可读写。字符串(String)。参阅**&nbsp;src&nbsp;**属性。</td></tr></tbody></table><div class="cssColumnTitle">说明：</div><div>在对象容器边界内，在对象的背景和内容之间显示一张图片。并提供对此图片的剪切和改变尺寸的操作。如果载入的是PNG(Portable Network Graphics)格式，则0%-100%的透明度也被提供。
PNG(Portable Network Graphics)格式的图片的透明度不妨碍你选择文本。也就是说，你可以选择显示在PNG(Portable Network Graphics)格式的图片完全透明区域后面的内容。
</div><div class="cssColumnTitle">示例：</div><div id="idSimpleCode">#idDiv{position:absolute; left:140px; height:400; width:400;filter:progid:DXImageTransform.Microsoft.AlphaImageLoader(src='rain1977.gif',sizingMethod='scale');}
.dream{filter:progid:DXImageTransform.Microsoft.AlphaImageLoader(src='images/earglobe.gif');}</div><div class="cssColumnTitle">MSDN:&nbsp;[http://msdn2.microsoft.com/en-us/library/ms532969.aspx](http://msdn2.microsoft.com/en-us/library/ms532969.aspx)</div>

P.S. 当想使用backgroundimage属性时，如果不想让图片原尺寸显示，而是类似于IMG width=100% heigth=100% 的效果，可以通过此filter实现。

Example：
span.style.filter="progid:DXImageTransform.Microsoft.AlphaImageLoader(src='test.jpg', sizingMethod='scale')";
引用：最后说说关于FF和IE效果调和问题。这个滤镜效果只适用于IE,在FF下面无法显示，我想这是前辈说他很难实现的最终问题了。以往我们用*或者_来修复IE下和FF的区别．这一次是要找方法修复FF不能实现的问题.
其实想到的话,也很简单了.就是先让FF正常显示该图片,然后,用*或_ 来清除IE下的显示效果，最后用*或_ 来做以上的滤镜效果。大功告成！

以上是官方的说明。事实上实际操作中需要注意:AlphaImageLoader滤镜会导致该区域的链接和按钮无效，一般情况下的解决办法是为链接或按钮 添加：position:relative使其相对浮动 要注意的是，当加载滤镜的区域的父层有position:absolute绝对定位的时候使用position:relative也不能使链接复原。建议 使用浮动办法处理。

**具体操作：**

1.  为预览区域（比如要在某个&nbsp;div 中预览）添加样式：filter:progid:DXImageTransform.Microsoft.AlphaImageLoader(sizingMethod=scale);。
2.  为 AlphaImageLoader 设置 src 属性。