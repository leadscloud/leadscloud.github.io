---
title: lnmp下的nginx301重定向设置
tags:
  - 301重定向
  - lnmp
  - nginx
id: 313739
categories:
  - 个人日志
date: 2014-03-08 03:54:08
---

LNMP下的301重定向与lnmpa下的重定向不太一样，需要设置nginx的重写规则。比如常用的非www域名重定向到www域名上，或者把index.html重定向到目录下 `/ `

下面是找到的关于lnmpa下的nginx配置规则

```
if ( $request_uri ~* /index\.(html|htm|php)$ ) {
	rewrite ^(.*)index\.(html|htm|php)$ $1 permanent;
}
if ($host !~* ^www\.) {
    rewrite ^/(.*)$ $scheme://www.$host/$1 permanent;
}
```

如果你添加一个虚拟主机，在server下 添加上面的规则即可。