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


## 20180307更新

添加两个page rules 301规则也行，之前的always https没这个选项了

```
curl -X POST "https://api.cloudflare.com/client/v4/zones/<zone_id>/pagerules" \
     -H "X-Auth-Email: <email>" \
     -H "X-Auth-Key: <api_key>" \
     -H "Content-Type: application/json" \
     --data '{"targets":[{"target":"url","constraint":{"operator":"matches","value":"http://love4026.org/*"}}],"actions":[{"id":"forwarding_url","value":{"url": "https://www.love4026.org/$1", "status_code": 301}}],"priority":1,"status":"active"}'

curl -X POST "https://api.cloudflare.com/client/v4/zones/<zone_id>/pagerules" \
     -H "X-Auth-Email: <email>" \
     -H "X-Auth-Key: <api_key>" \
     -H "Content-Type: application/json" \
     --data '{"targets":[{"target":"url","constraint":{"operator":"matches","value":"http://www.love4026.org/*"}}],"actions":[{"id":"forwarding_url","value":{"url": "https://www.love4026.org/$1", "status_code": 301}}],"priority":1,"status":"active"}'

curl -X POST "https://api.cloudflare.com/client/v4/zones/<zone_id>/pagerules" \
     -H "X-Auth-Email: <email>" \
     -H "X-Auth-Key: <api_key>" \
     -H "Content-Type: application/json" \
     --data '{"targets":[{"target":"url","constraint":{"operator":"matches","value":"https://love4026.org/*"}}],"actions":[{"id":"forwarding_url","value":{"url": "https://www.love4026.org/$1", "status_code": 301}}],"priority":1,"status":"active"}'
```

设置好后使用

```
curl -I http://love4026.org
``` 

看下结果即可

```
[root@centos-1gb-nyc3-01 ~]# curl -I http://love4026.org
HTTP/1.1 301 Moved Permanently
Date: Wed, 07 Mar 2018 02:14:15 GMT
Connection: keep-alive
Cache-Control: max-age=3600
Expires: Wed, 07 Mar 2018 03:14:15 GMT
Location: https://www.love4026.org/
Server: cloudflare
CF-RAY: 3f798c2c75a346f8-EWR
```