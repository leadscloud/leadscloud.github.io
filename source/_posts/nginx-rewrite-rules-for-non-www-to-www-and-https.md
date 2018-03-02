---
title: Nginx下301重定向设置
date: 2017-10-10 11:56:19
tags: nginx 
id: 315030
categories: 技术
---


## 非www到 www 的规则 

```
if ($request_uri ~ ^(.*/)index.html$) {
    return 301 $1;
}
# non-www to www
if ($host !~* ^www\.){
    rewrite ^(.*)$ $scheme://www.$host$1 permanent;
}

```

## http 到 https 的

```
# http to https
if ( $scheme = http ){
    return 301 https://$server_name$request_uri;
}
```

## 使用了cloudflare的https重定向设置

如果使用了cloudflare，http 到https的转向需要到cloudflare上面设置

[How do I redirect all visitors to HTTPS/SSL?](https://support.cloudflare.com/hc/en-us/articles/200170536-How-do-I-redirect-all-visitors-to-HTTPS-SSL-)