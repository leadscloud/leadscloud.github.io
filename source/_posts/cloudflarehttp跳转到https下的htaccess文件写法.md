---
title: cloudflare http跳转到https下的htaccess文件写法
id: 313941
categories:
  - 技术
date: 2015-03-19 19:42:15
tags: [htaccess, cloudflare, 301]
---

 
```
RewriteEngine on
RewriteCond %{THE_REQUEST} ^.*\/index\.html\ HTTP/
RewriteRule ^(.*)index\.html$ /$1 [R=301,L]
RewriteCond %{HTTP_HOST} !^www\.
RewriteRule ^(.*)$ http://www.%{HTTP_HOST}/$1 [R=301,L]
# below is only for cloudflare
RewriteCond %{HTTP:CF-Visitor} '"scheme":"http"'
RewriteRule ^(.*)$ https://%{HTTP_HOST}/$1 [R=301,L]
```