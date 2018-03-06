---
title: 无需 Javascript 支持的 Google Analytics 统计代码
tags:
  - Google Analytics
  - NoJSStats
id: 313009
categories:
  - 前端设计
date: 2011-02-11 01:40:02
---

众所周知，[Google Analytics](http://www.google.com/analytics/) 是一段Javascript代码，包含有一个用户的ID，例如：UA-123456。但是用户使用wap浏览器或者不支持javascript，你还想使用Google Analytics服务的话，怎么办呢？

试试[NoJSStats](http://nojsstats.blogspot.com/)吧。NoJSStats是部署在Google App Engine的免费统计服务。主要是用于不支持Javascript的统计服务，例如：

*   给Wordpress的Mobilepress插件提供统计功能，或者discuz,phpwind的wap访问统计。*   邮件查看次数统计。*   淘宝、拍拍、易趣等网店的访问统计。*   论坛帖子查看次数统计，可以关注自己发的帖子的阅读次数。  

**统计代码的格式:**

```
http://nojsstats.appspot.com/your-google-analytics-user-account/your-website.com
```

**一个例子:**

```
http://nojsstats.appspot.com/UA-123456/your-website.com
```

**HTML代码:**

```
<img src="http://nojsstats.appspot.com/UA-123456/yourwebsite.com" alt="" />
```

**BBCode代码:**

```
[img]http://nojsstats.appspot.com/UA-123456/mywebsite.com[/img]
```

**CSS代码:**

```
body{
background: url("http://nojsstats.appspot.com/UA-123456/mywebsite.com");
}
```

另外如果使用SSL的话， 需要使用SSL版本的代码（SSL统计代码只对SSL站点有效）:

`httpS://nojsstats.appspot.com/UA-123456/yourwebsite.com`

一般用户是免费的，大流量的话，需要向作者支付10美元。

### NoJSStats的实现机制

NoJSStats的实现机制就是网站分析中点击流数据获取的方式之一——Web Beacons，即在页面中嵌入一个1像素的透明图片，当该页面被浏览时，图片就会被请求加载，于是在后端的服务器日志中就会记录该图片的请求日志， 如打开我的博客首页，网页中的图片就会被请求，这样就可以获得如下的日志记录： 

> 114.92.96.15 - - [09/Feb/2011:14:14:02 +0800] "GET /wp-admin/images/white-grad.png HTTP/1.1" 200 486 "http://love4026.org/" "Mozilla/5.0 (Windows; U; Windows NT 6.1; en-US) AppleWebKit/534.7 (KHTML, like Gecko) Chrome/7.0.517.44 Safari/534.7"

请求类型是GET，请求的资源就是该图片的URI，而后面的referrer中记录了我的博客的首页URL，即用户浏览的页面，所以只要统计出现这类图片请求的日志记录就能获得嵌入图片的各页面被浏览的情况，Web Beacons就是通过这种方式来获取用户的浏览数据的。需要注意的是，Web Beacons方式是无法获取浏览的来源页面信息的，除非在图片的URI请求中带上referrer的参数，类似.png?ref=www.google.com。

**NoJSStats需要手动添加referrer,格式如下**

`http://nojsstats.appspot.com/UA-123456/website.com?r=http://www.the-referrer.com/`