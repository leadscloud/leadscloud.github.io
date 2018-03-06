---
title: 新增apache虚拟目录
tags:
  - PHP
  - apache
id: 39001
categories:
  - PHP学习
date: 2010-09-12 11:02:42
---

设置Apache的根目录很简单，但只设置一个根目录是远远不够的，有时我们会有很多程序要调试，都放在根目录是不合适的，所以要工apache下建立虚拟目录。下面我自己电脑上建的虚拟目录。打开`apache`的`httpd.conf`文件，在最下面增加下面代码就行了。主要就是设置一个别名，和你程序放在的目录。

```
Alias /sme/ "F:/WebSite/stonecrushermachine.net/"
<Directory "F:/WebSite/stonecrushermachine.net/">
    Options Indexes FollowSymLinks
    AllowOverride None
    Order allow,deny
    Allow from all
</Directory>
```

设置好之后在浏览器中打开 `http://localhost/sme/` 就成功了。
