---
title: lnmpa修改安装时绑定的默认域名
tags:
  - lnmpa
id: 313519
categories:
  - Linux
date: 2012-12-12 10:47:11
---

/usr/local/nginx/conf/nginx.conf 
/usr/local/apache/conf/extra/httpd-vhosts.conf

vi 编辑 以上两个文件，查找你绑定的域名，然后修改成其它域名即可。另外，初次安装lnmpa时，建议不要使用顶级域名绑定。