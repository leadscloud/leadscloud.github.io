---
title: apache下用 htaccess控制及破解图片防盗链
tags:
  - 防盗链
  - apache
  - htaccess
id: 313004
categories:
  - PHP学习
date: 2011-02-12 21:12:25
---

如是你在自己的网站或博客上引用我博客上的图片会出现这样的提示![图片盗链后显示的图片](http://www.love4026.org/wp-content/uploads/2011/02/love4026.png)，由于我的博客用的是apache的服务器，所以可以在根目录下.htaccess文件中设置防盗链。以下是我.htaccess文件中的防盗链设置：
<!--more-->

```
RewriteCond %{HTTP_REFERER} !^$
RewriteCond %{HTTP_REFERER} !^http://(www\.)?love4026.org/.*$ [NC]

RewriteCond %{HTTP_REFERER} !google\.com [NC]
RewriteCond %{HTTP_REFERER} !baidu\.com [NC]
RewriteCond %{HTTP_REFERER} !bloglines\.com [NC]
RewriteCond %{HTTP_REFERER} !feedburner\.com [NC]

RewriteRule \.(gif|jpg|png)$ http://pic.yupoo.com/love4026/AQsyXqNU/2JUSD.png [R,L]
```

很多网上提供的方法是不能实现防盗链的，比如这个：

```
#disable hotlinking of images
RewriteEngine on
RewriteCond %{HTTP_REFERER} !^$
RewriteCond %{HTTP_REFERER} !^http://(www\.)?yourdomain.com/.*$ [NC]
#RewriteRule \.(gif|jpg|png)$ http://www.yourdomain.com/stealingisbad.gif [R,L]
```

它替换显示的图片本身就在防盗的目录下，所以这个代码仅仅能防盗链，但不会出现相应的替换图片。
下面详细说下防盗链的原理和设置方法：

### 一、在根目录.htaccess设置防盗链

理论上，在Apache中，可以针对每个目录分别设置.htaccess，通过许可权的继承与覆盖可以实现相当复杂的功能，不过，过多的.htaccess往往会增加管理的难度，修改.htaccess稍有遗漏就可能造成网站出现问题,对于wordpress更是如此。

默认情况只是想禁止其它网站链接到你的图片（盗链），原理即当其他网站使用&lt;img src="http://yourdomain.com/someimg.jpg"&gt;盗链时，服务器会自动重定向，当然，从降低对服务器带宽占用的角度考虑，你可以简单地拒绝其访问，让其网页上图片位置以红”X”号代替。
允许特定访问来源：单纯针对图片来说，我们也不可能禁止所有除你自己网站之外的其他访问，比如说Google，如果你希望通过Google图片搜索获得一定的访问的话，必须让其能够正确读取真正的图片，再如应能够让RSS订阅用户看feed中的图片。
运行特定目录下的文件被外部网站使用：完全禁止外部网站有时会带来不便，很多时候，我们自己也可能需要在外部网站使用部分文件，当然，放入这些目录的文件要有一定的限制，不然，便失去设置防盗链的意义了。
设置.htaccess禁止图片盗链，下面是禁止图片盗链的.htaccess设置部分
RewriteEngine on
RewriteCond %{REQUEST_URI} ^/(allow1|allow2)
RewriteRule ^.*$ – [L]
首先，设置允许可“盗链”即外部网站可以使用的文件所在的目录，上面我们设置了两目录，分别为allow1和allow2，当然，如果你只有一个目录的话，可以将其改为：
RewriteCond %{REQUEST_URI} ^/allow1
接下来判断是否为图片文件：
RewriteCond %{REQUEST_FILENAME} \.(gif|jpeg|png)$ [NC]
你也可以根据自己的需要设置更多的文件类型：
RewriteCond %{HTTP_REFERER} !^$
上面这一行意在允许空“HTTP_REFERER”的访问，即允许用户在浏览器地址栏中直接输入图片地址的显示，一般而言，这是可以选的，不过建议这样设置，如果强迫必须具有“HTTP_REFERER”才能访问，可能会带来某些问题，比如说在用户通过代理访问时。
RewriteCond %{HTTP_REFERER} !love4026.org [NC]
RewriteCond %{HTTP_REFERER} !google.com [NC]
RewriteCond %{HTTP_REFERER} !baidu.com [NC]
设置允许访问的HTTP来源，包括Google，百度以及自己的网站，
RewriteRule (.*) /allow1/images.gif [R,NC,L]
将不满足上述条件的访问重定向到images.gif ，你可能已经注意到，images.gif位于允许“盗链”的目录allow1下，这一点很重要，不然，你的警告资讯图片将无法在对方网站上显示。
其它类型文件的防盗链设定，如果你您的网站上存在其它较大的文件，如flash、mp3被其他网站盗链，可以同样采取上述方法，比如说flash文档，可以类似如下的设置：

```
RewriteCond %{REQUEST_URI} ^/allow1
RewriteRule ^.*$ – [L]
RewriteBase /
RewriteCond %{REQUEST_FILENAME} \.swf$ [NC]

RewriteCond %{HTTP_REFERER} !^$
RewriteCond %{HTTP_REFERER} !shuai.be [NC]
(……其它允许访问来源)
RewriteRule (.*) /allow1/images.swf [R,NC,L]
```

当然，需要事先先创建一个声明版权资讯的Flash文件“images.swf”，其它防止mp3文件、压缩文件盗链的设置与此类似，不再赘述。

### 二、在图片目录.htaccess设置防盗链：

.htaccess文件将影响其所在的目录及其子目录，因此，如果我们要保护的内容（此处以防止图片盗链为例，即图片）位于网站内多个目录下，可以考虑将其放在根目录下；而如果图片有单独的子目录如“/images/”，则只需将其放置在该目录下（当然也可以放到根目录中）。

需要注意的是，如果通过FTP方式将创建好的.htaccess上传到服务器上，传输模式应为ASCII而非Binary。上传到服务器后，应将其属性通过 CHMOD修改为644 或“RW-R–R–”，这样，可以保证服务器能够使用同时无法通过浏览器修改，当然，.htaccess的可读属性也存在一定的风险：攻击者可通过它找出您要保护的对象或认证文件位置——解决办法是将认证文件.htpasswd放到网站根目录之外，这样，便无法通过网络找到它了。
使用.htaccess禁止盗链

通过.htaccess来防止网站的图片、压缩文件、或视频等非Html文件被盗链的方法相当简单，通过在该文件中加入几句命令即可保护我们宝贵的带宽。例如：

```
RewriteEngine on
RewriteCond %{HTTP_REFERER} !^$ [NC]
RewriteCond %{HTTP_REFERER} !love4026.org [NC]
RewriteCond %{HTTP_REFERER} !google.com [NC]
RewriteCond %{HTTP_REFERER} !baidu.com [NC]

RewriteRule .*\.(gif|jpg)$ http://nobing.cn/no.png [R,NC,L]
```

简单的解释一下上述语句：

1、RewriteCond %{HTTP_REFERER} !^$ [NC]

允许空“HTTP_REFERER”的访问，即允许用户在浏览器地址栏中直接输入图片地址时图片文件的显示。一般而言，这是可选的，不过，建议这么设置，如果强迫必须具有“HTTP_REFERER”才能访问，可能会带来某些问题，比如说在用户通过代理服务器访问时。

2、RewriteCond %{HTTP_REFERER} !shuai.be [NC]

设置允许访问的HTTP来源，包括我们的站点自身、Google、Baidu等。

3、RewriteRule .*\.(gif|jpg|png)$ http://nobing.cn/no.png [R,NC,L]

定义被盗链时替代的图片，让所有盗链 jpg、gif、png 等文件的网页，显示根目录下的 no.png 文件。注意：替换显示的图片不要放在设置防盗链的目录中，并且该图片文件体积越小越好。当然你也可以不设置替换图片，而是使用下面的语句即可：

RewriteRule .*\.(gif|jpg|png)$ – [F]

4、说明一下其中的R、NC 和 L

R 就是转向的意思

NC 指的是不区分大小写

L 的作用是指明本次转向到此结束，后续的转向不受先前判断语句的影响

5、防止盗链的文件类型

上例中是 gif、jpg、png，而根据需要，可更改或添加其他文件类型，如rar、mov等，不同文件扩展名间使用“|”分割。

这样的话，就可以基本做到简单的防止被盗链情况的发生，而且可以尽最大可能的减少服务器流量的无畏消耗。

### 三、防盗链的破解：如何引用网易、新浪、百度相册上的图片 

方法很简单，就是在相册图片的地址前加上：http://www.zhuaxia.com/readpic.php?url=　(不过目前已失效)，还有就是你只要把 http://替换为http://www.hongkongfans.cn/, 如要引用百度相册上的一张照片，地址为：http://hiphotos.baidu.com/love4026/pic/item/b79afefc4ab1db81b801a002.jpg　，在博客中引用时则把地址改为：http://www.hongkongfans.cn/hiphotos.baidu.com/love4026/pic/item/b79afefc4ab1db81b801a002.jpg，下图为引用自百度相册。
图片地址: http://hiphotos.baidu.com/love4026/pic/item/b79afefc4ab1db81b801a002.jpg
直接引用：
![百度相册防盗破解显示的图片](http://hiphotos.baidu.com/love4026/pic/item/b79afefc4ab1db81b801a002.jpg)
破解防盗链引用
![百度相册防盗破解显示的图片](http://www.hongkongfans.cn/hiphotos.baidu.com/love4026/pic/item/b79afefc4ab1db81b801a002.jpg)