---
title: lnmpa服务器下免费搭建https网站
tags:
  - Nginx
  - SPDY
  - SSL
id: 313867
categories:
  - [Linux]
  - [技术]
date: 2014-06-24 14:22:47
---

![20140624143525](/wp-content/uploads/2014/06/20140624143525.jpg)
本文讲述如何免费申请SSL证书，并搭建https网站，由于服务器是NGINX，顺便会介绍如何安装SPDY协议。

## StartSSL介绍

[StartSSL](http://www.startssl.com)是一家CA机构，它的根证书很久之前就被一些具有开源背景的浏览器支持（Firefox浏览器、谷歌Chrome浏览器、苹果Safari浏览器等）。
在今年9月份，StartSSL竟然搞定了微软：微软在升级补丁中，更新了通过Windows根证书认证程序（Windows Root Certificate Program）的厂商清单，并首次将StartCom公司列入了该认证清单，这是微软首次将提供免费数字验证技术的厂商加入根证书认证列表中。现在，在Windows 7或安装了升级补丁的Windows Vista或Windows XP操作系统中，系统会完全信任由StartCom这类免费数字认证机构认证的数字证书，从而使StartSSL也得到了IE浏览器的支持。

### StartSSL申请注意事项

（1）需要一个域名，并开通域名邮箱，邮箱前缀为：webmaster这样的信息，一定要开通一个webmaster@yourdomainname.com这样的域名，这个会用来验证你的域名；
（2）申请时一定要填写完整正确的信息，否则无法通过申请，我就是因为第一次填写的地址信息不全，没有通过，一般添写正确的地址很快就会通过的；
（3）打开网站 在control panel / sign-up 注意填写正确资料。收到邮件后复制验证码。然后可以生成一个证书，注意，startssl.com不是以用户名、密码来验证用户的，是用证书来验证用户的。所以生成证书后(火狐会导入证书)，注意备份证书。丢失证书后只能重新注册。
（4）登录后还要验证域名才能为该域名生成SSL证书，可以选择在whois里的邮箱、hostmaster@domain、postmaster@domain或者webmaster@domain
（5）然后就可以在Certificates wizard里就可以申请SSL证书了。
（6）有效期一年（到期前会收到邮件通知续期）。

## 申请流程

所有的资料都最好使用正确的。因为注册SSL是一件很严肃的事情。还有就是如果你的IP地址是在大陆，你输入香港也是会被拒绝的。而且你的地址也是也是要详细的。按照表单写完以后点击Continue按钮。然后你填写的邮箱会收到一个验证码。 上面说大概需要等6个小时收到通知，其实一般一两分钟就会出结果

打开你的邮箱，把验证码输入到你的浏览器Code的框里，然后继续。

通过后，会收到通过验证的邮件，然后给你一个URL，输入到浏览器中进行下一步安装证书。如果弹出的窗口依然还让你输入Code，那则输入邮件下面链接的Code。

点击Continue，接下来你的浏览器开始安装私钥，相当于建立用户名密码

然后密钥安装成功以后提示你开始安装证书。

证书安装完毕以后会祝贺你一下。点击完成。 这时给你会收到邮件说你安装好啦，可以使用了。

在Validations Wizard选择里验证你的域名。按照提示操作就行了，它会扫描你的网站上的邮箱，然后列出来，会给你的邮箱发一封信，所以你一定要有一个企业邮箱来收信的。域名验证成功后，接下来申请域名SSL证书。

点击Certificates Wizard ，选择下拉菜单中的Web Server SSL/TSL Certificate

然后进入下一步他会问你验证方式，这一步如果你跳过需要在VPS上设置，具体可以见网站：http://blog.nicky1605.com/the-free-ssl-configuration-startssl-on-nginx.html

如果没有跳过，你必须设置密码，不少于10位的。然后点击下一步生成一段字符串

这一小的操作中会出现两段字条串，一段类似这样的

```
-----BEGIN RSA PRIVATE KEY-----
Proc-Type: 4,ENCRYPTED
DEK-Info: AES-256-CBC,1FBB7A12C5332861D52FEDFA2E3E7AE3

....
```

复制内容保存为 `/etc/ssl/certs/xxxx.crt`
一段类似这样的

```
-----BEGIN CERTIFICATE-----
MIIGdTCCBV2gAwIBAgIDYTrWMA0GCSqGSIc3FQEBBQUAMIGMMQswCQYDVQQGEwJJ
...
```

复制内容保存为 `/etc/ssl/certs/xxxx.key`

下面就是配置你的VPS上的NGINX服务器了。

`vi /usr/local/nginx/conf/vhost/xxxx.conf`

在Server里添加

```
listen 443 ssl spdy;
ssl                     on;
ssl_certificate         /etc/ssl/certs/xxxx.crt;
ssl_certificate_key     /etc/ssl/certs/xxxx.key;
ssl_session_timeout     10m;
ssl_protocols           SSLv2 SSLv3 TLSv1;
ssl_ciphers             ALL:!ADH:!EXPORT56:RC4+RSA:+HIGH:+MEDIUM:+LOW:+SSLv2:+EXP;
ssl_prefer_server_ciphers       on;
```

如果你想让http跳转到https下，需要再加一段代码

```
if ($ssl_protocol = "") {
    rewrite ^/(.*)$ https://www.domain.com/$1 permanent;
}
```

如果出现循环重定向，检查下你的网站根目录下，是否有`.htaccess`文件，因为我的服务器是lnmpa的，apache的重定向文件还是会起作用的，检查下有无重定向到http的，一般是301重定向需要修改下。

上面这些做完之后，还需要另外对firefox浏览器作一些配置更改
到`/etc/ssl/certs/xxxx.crt`所在目录执行以下代码

```
wget http://cert.startssl.com/certs/sub.class1.server.ca.pem
cat ca.pem sub.class1.server.ca.pem >> xxxx.crt
```

就是向 xxx.crt里面追加一些内容，这样firefox就不会提示证书不安全了。

下就是重启你的nginx服务器，但这里会提示你需要输入Enter PEM pass phrase
总不能每次重启都要输入那个密码吧，这个可以跳过的，方法按照我之前的一篇文章操作

[/313864/lnmp%E4%B8%8Bnginx%E9%85%8D%E7%BD%AEssl%E5%AE%89%E5%85%A8%E8%AF%81%E4%B9%A6%E9%81%BF%E5%85%8D%E5%90%AF%E5%8A%A8%E8%BE%93%E5%85%A5enter-pem-pass-phrase/](/313864/lnmp%e4%b8%8bnginx%e9%85%8d%e7%bd%aessl%e5%ae%89%e5%85%a8%e8%af%81%e4%b9%a6%e9%81%bf%e5%85%8d%e5%90%af%e5%8a%a8%e8%be%93%e5%85%a5enter-pem-pass-phrase/ "LNMP下Nginx配置SSL安全证书避免启动输入Enter PEM pass phrase")

### SPDY协议安装

你要先下载最新的 OpenSSL，比如 1.0.1e，[这里](http://www.openssl.org/source/)是下载列表，红色标注的就是最新版了。因为前些时间的openssl漏洞，现在linode好像自动已经升级到最新版1.0.1e了。

但还是需要下载，解压

```
cd /tmp
wget http://www.openssl.org/source/openssl-1.0.1e.tar.gz
tar zxvpf openssl-1.0.1e.tar.gz
```

然后下载最新的[Nginx](http://nginx.org/en/download.html)

先用 /usr/local/nginx/sbin/nginx -V 这个是查看nginx安装了什么模块 安装的时候把这些都再加上

```
wget http://nginx.org/download/nginx-1.7.2.tar.gz
tar zxvf nginx-1.7.2.tar.gz
cd nginx-1.7.2
./configure --user=www --group=www --prefix=/usr/local/nginx --with-http_stub_status_module --with-http_ssl_module --with-http_gzip_static_module --with-ipv6 --with-pcre --with-http_sub_module --with-http_spdy_module --with-openssl=/tmp/openssl-1.0.1e
mv /usr/local/nginx/sbin/nginx /usr/local/nginx/sbin/nginx.old
cp objs/nginx /usr/local/nginx/sbin/nginx
/usr/local/nginx/sbin/nginx -t
make upgrade
/usr/local/nginx/sbin/nginx -v
```

上面需要注意的是`./configure --with-http_ssl_module --with-http_spdy_module --with-openssl=/tmp/openssl-1.0.1e` 这是最小安装方法，你需要根据自己的配置安装，上面是lnmpa下面的。

`--with-openssl=/tmp/openssl-1.0.1e` 路径就是刚下载的那个路径。

再配置完成后，执行 `/etc/init.d/nginx reload` 或 `/usr/local/nginx/sbin/nginx -s reload` 重载 Nginx 配置文件即可正常访问了。

如果你不想使用 SPDY ，记得修改Server里的 `listen 443 ssl spdy;` 改为 `listen 443 ssl;`

**如何查看有没有启用SPDY成功没**

在Chrome浏览器里打开 chrome://net-internals/#spdy 便能查看目前使用SPDY的连接。

或者使用插件查看， https://chrome.google.com/webstore/detail/spdy-indicator/mpbpobfflnpcgagjijhmgnchggcjblin

**补充：关于 “此网页包含的脚本来自于身份未经验证的源” 的提示信息**

出现这个一般是因为在网页内容中加载了其它不带https的内容，比如加载了google font, 

```
<link href='http://fonts.googleapis.com/css?family=Antic+Slab' rel='stylesheet' type='text/css'>
```

一般解决办法就是把资源下载到本地，然后使用相对路径，或者使用https的资源地址。
google 支持https连接，上面的情况你可以直接改为

```
<link href='https://fonts.googleapis.com/css?family=Antic+Slab' rel='stylesheet' type='text/css'>
```