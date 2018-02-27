---
title: lnmpa下的https-wordpress循环重定向
id: 313905
categories:
  - Wordpress学习
date: 2014-09-18 16:39:58
tags:
---

/usr/local/nginx/conf/proxy.conf 添加上一行
<pre class="lang:default decode:true " >proxy_set_header   X-Forwarded-Proto $scheme;</pre> 

wordpress 的 wp-config.php 添加上：
<pre class="lang:default decode:true " >if ($_SERVER['HTTP_X_FORWARDED_PROTO'] == 'https') $_SERVER['HTTPS']='on';</pre> 

wordpress wp_options中的home，改为https的地址。