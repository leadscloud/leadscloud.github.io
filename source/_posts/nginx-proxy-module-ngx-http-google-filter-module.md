---
title: nginx 反向代理Google扩展 ngx_http_google_filter_module
date: 2018-03-01 10:29:20
tags: 
    - nginx
id: 316008
categories:
    - 技术
---

Github上面的一个项目 [Nginx Module for Google](https://github.com/cuber/ngx_http_google_filter_module) ，可以实现快捷部署Google镜像。

## 重新编绎Nginx

```
[root@AY1407181147267575e9Z ~]# nginx -V
nginx version: nginx/1.6.0
built by gcc 4.4.7 20120313 (Red Hat 4.4.7-4) (GCC) 
TLS SNI support enabled
configure arguments: --user=www --group=www --prefix=/usr/local/nginx --with-http_stub_status_module --with-http_ssl_module --with-http_gzip_static_module --with-ipv6
```

我使用的是lnmp.org的一键安装包，其它情形查看 https://github.com/cuber/ngx_http_google_filter_module ,上面有详细的说明。

```
git clone https://github.com/cuber/ngx_http_google_filter_module
git clone https://github.com/yaoweibin/ngx_http_substitutions_filter_module
cd nginx-1.6.0/
./configure --user=www --group=www --prefix=/usr/local/nginx --with-http_stub_status_module  \
--with-http_ssl_module --with-http_gzip_static_module --with-ipv6 \
--add-module=../ngx_http_google_filter_module \
--add-module=../ngx_http_substitutions_filter_module

make && make install
ln -s /usr/local/nginx/sbin/nginx /usr/bin/nginx
nginx -t
service nginx restart
```

## 虚拟主机配置

`vi /usr/local/nginx/conf/vhost/demo.website.com.conf`, 保持内容如下：

```
# https的可以使用lnmp的脚本配置，在添加虚拟主机的时候有提示是否使用ssl
server {
    listen 443 ssl http2;
    server_name demo.website.com;
    ssl_certificate /usr/local/nginx/conf/ssl/demo.website.com.crt;
    ssl_certificate_key /usr/local/nginx/conf/ssl/demo.website.com.key;
    ssl_session_timeout 10m;
    ssl_protocols TLSv1 TLSv1.1 TLSv1.2;
    ssl_prefer_server_ciphers on;
    ssl_ciphers CHACHA20:ECDHE-RSA-AES256-GCM-SHA384:ECDHE-RSA-AES128-GCM-SHA256:ECDHE-RSA-AES256-SHA384:ECDHE-RSA-AES128-SHA256:ECDHE-RSA-RC4-SHA:ECDHE-RSA-AES256-SHA:DHE-RSA-AES256-SHA:DHE-RSA-AES128-SHA:RC4-SHA:!aNULL:!eNULL:!EXPORT:!DES:!3DES:!MD5:!DSS:!PKS;
    ssl_session_cache builtin:1000 shared:SSL:10m;
    resolver 8.8.8.8 8.8.4.4 valid=300s;
    resolver_timeout 5s;
    location / {
        google on;
        google_scholar on;  # google_scholar 依赖于 google, 所以 google_scholar 无法独立使用。由于谷歌学术近日升级, 强制使用 https 协议, 并且 ncr 已经支持, 所以不再需要指定谷歌学术的 tld
        google_language en;  # 语言偏好，默认使用 zh-CN (中文)
    }
}
server {
    listen 80;
    server_name demo.website.com;
    rewrite ^(.*)$ https://$host$1 permanent; # 访问http跳转至https
}
```

保存配置文件，重启nginx即可。

## 参考资料

[Nginx Module for Google](https://github.com/cuber/ngx_http_google_filter_module) 