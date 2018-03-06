---
title: LNMPA 下 htaccess 301 静态网页重定向问题
id: 313650
categories:
  - [Linux]
  - [技术]
date: 2013-10-22 03:03:11
tags: [lnmpa,htaccess,301]
---

在lnmpa下使用.htaccess重定向整个域名，或者把非www重定向到www域名上，会出现，.html后缀的网页无法实现重定向，但在lamp服务器下没有问题，经检查是因为lnmpa服务器下，apache处理php文件，nginx处理静态文件，比如html,js,css文件，所以这些文件无法重定向成功，只有在nginx下设置重定向。

在apache下设置域名`stonecrushingplant.net`全部重定向到`en.stonecrushingplant.net`上，htaccess文件写法如下：

```
RewriteEngine On
RewriteCond %{HTTP_HOST} ^stonecrushingplant.net [OR]
RewriteCond %{HTTP_HOST} ^www.stonecrushingplant.net [NC]
RewriteRule ^(.*)$ http://en.stonecrushingplant.net/$1 [L,R=301]
```

在lnmpa下，你还需要在nginx配置文件下写上

```
if ($host != 'en.stonecrushingplant.net' ) {
	rewrite ^/(.*)$ http://en.stonecrushingplant.net/$1 permanent;
}
```

nginx修改的位置在`/usr/local/nginx/conf/vhost/stonecrushingplant.net.cof`

```
server
{
  listen       80;
  server_name stonecrushingplant.net www.stonecrushingplant.net en.stonecrushingplant.net;
  index index.html index.htm index.php default.html default.htm default.php;
  root  /home/wwwroot/stonecrushingplant.net;

  if ($host != 'en.stonecrushingplant.net' ) {
    rewrite ^/(.*)$ http://en.stonecrushingplant.net/$1 permanent;
  }
}
```


