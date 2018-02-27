---
title: timthumb优化
tags:
  - timthumb
id: 313149
comment: false
categories:
  - 个人日志
date: 2011-05-15 09:06:28
---

&nbsp;

&nbsp;
<div style="font-family: Arial, Verdana, sans-serif; font-size: 12px; color: rgb(34, 34, 34); background-color: rgb(255, 255, 255); ">

TimThumb是一个简洁高效的创建图片缩略图的程序。它功能非常强大，并且制定性很强。通过对多个参数的控制，你可以灵活地设置缩略图片的输出样式。

&nbsp;

然而，有时候具体应用时，会产生一些性能问题。由于它的调用方式

&nbsp;

&lt;IMG alt=&rdquo;&quot; src=&rdquo;/scripts/timthumb.php?src=/images/whatever.jpg&amp;h=150&amp;w=150&amp;zc=1&Prime;&gt;

&nbsp;

服务器可能不会自动对图片进行压缩，也不会自动添加图片的客户端缓存过期时间。下面我们来看一下如何解决这些问题。

&nbsp;

## 开启cache

TimThumb是有cache功能的，如果你的图片没有cached，请查看timthumb.php文件第45行左右

&nbsp;

check_cache....

移除前面的#或//符号，这将使服务器响应时间加快5倍（100ms降低到20ms）。

&nbsp;

修改cache目录

&nbsp;

最好将cache目录设为网站上传目录（upload目录）（有人如此建议）。第35行：

&nbsp;

$cache_dir = &lsquo;./cache&rsquo;;

&nbsp;

计算timthumb.php文件所在目录深度，.将cache_dir设为../&hellip; /uploads/

&nbsp;

## 设置最大压缩比

PNG图片的最后一个参数不是质量级别而是压缩级别。我们可以单独修改这个参数达到最大压缩比。

&nbsp;

找到timthumb.php文件第174行左右

&nbsp;

$quality = floor($quality * 0.09);

在下面添加：

&nbsp;

$quality = 9;

## 加快图片的载入速度

&nbsp;

你可以把以下规则添加进你的.htaccess文件中，可加速图片载入速度：

&nbsp;

RewriteEngine on

&nbsp;

RewriteRule .* &ndash; [E=HTTP_IF_MODIFIED_SINCE:%{HTTP:If-Modified-Since}]

&nbsp;

RewriteRule .* &ndash; [E=HTTP_IF_NONE_MATCH:%{HTTP:If-None-Match}]

&nbsp;

## 设置客户端缓存

将第317行左右的最大有效期设为：

&nbsp;

header(&ldquo;Cache-Control: max-age=315360000,public&rdquo;);

&nbsp;

下两行左右位置，设为：

&nbsp;

header(&ldquo;Expires: &rdquo; . gmdate(&ldquo;D, d M Y H:i:s&rdquo;, time() + 315360000) . &ldquo;GMT&rdquo;);

&nbsp;

## 设置静态地址

将图片的动态地址改为静态地址也会加快服务器的响应速度。

&nbsp;

参考：

&nbsp;

http://www.speedingupwebsite.com/2010/02/11/hacking-timthumb-php-all-the-best-practices/

&nbsp;

关于timthumb.php更多用法：

&nbsp;

http://code.google.com/p/timthumb/
</div>