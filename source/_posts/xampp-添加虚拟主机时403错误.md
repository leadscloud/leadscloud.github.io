---
title: xampp-添加虚拟主机时403错误
tags:
  - XAMPP
id: 313176
categories:
  - 个人日志
date: 2011-07-16 11:28:53
---

XAMPP添加虚拟主机如果不在默认的目录下（`/xampp/htdocs`只能在这下面），会出现403禁止访问的问题，主要原因是apache Directory  权限问题，比如我的虚拟主机在`E:/phpsite/wordpress`，  在 `httpd.cof` 最后一行添加如下代码即可。

```
<VirtualHost 127.0.0.2:80>       
    DocumentRoot "E:/phpsite/wordpress"    
    ServerName wordpress
</VirtualHost>
<Directory "E:/phpsite">
  Options Indexes FollowSymLinks Includes ExecCGI
  AllowOverride All
  Order allow,deny    Allow from all
</Directory>
```