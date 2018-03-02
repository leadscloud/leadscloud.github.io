---
title: lnmpa下的https wordpress循环重定向
id: 313905
categories:
  - Wordpress学习
date: 2014-09-18 16:39:58
tags: [lnmpa,wordpress,301]
---

`/usr/local/nginx/conf/proxy.conf` 添加上一行

```
proxy_set_header   X-Forwarded-Proto $scheme;
```

wordpress 的 wp-config.php 添加上：

```
if ($_SERVER['HTTP_X_FORWARDED_PROTO'] == 'https') $_SERVER['HTTPS']='on';
```


wordpress wp_options中的home，改为https的地址。