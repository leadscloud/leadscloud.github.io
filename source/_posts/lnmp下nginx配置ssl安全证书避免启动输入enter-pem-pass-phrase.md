---
title: lnmp下nginx配置ssl安全证书避免启动输入enter-pem-pass-phrase
tags:
  - Nginx
  - SSL
id: 313864
categories:
  - Linux
date: 2014-06-24 10:28:42
---

从Startssl免费申请到ssh证书后，把自己的一个网站搭建成了https网站。但是由于生成私钥key文件时输入了密码，导致每次重启nginx时都提示Enter PEM pass phrase ， 这样会导致自己VPS上的重启脚本无法自动工作，每次都要人工重启。

在网上搜索后找到了解决办法。

在key的目录执行：openssl rsa -in server.key -out server.key.unsecure  然后在配置文件里使用unsecure这个文件名就行了

修改后的nginx配置如下：

<pre class="lang:sh decode:true " ># 这里是SSL的相关配置
server {
  listen 443;
  server_name www.example.com; # 你自己的域名
  root /home/wwwroot/www.example.com;
  ssl on;
  ssl_certificate /etc/ssl/certs/server.crt;
  # 修改下面这一行指向我们生成的server.key.unsecure文件
  ssl_certificate_key /etc/ssl/certs/server.key.unsecure;
}</pre> 

然后使用/etc/init.d/nginx restart重启Nginx.不提示便表示成功了。