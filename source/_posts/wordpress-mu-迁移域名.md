---
title: wordpress mu 迁移域名
tags:
  - wordpress mu
  - wordpress
id: 313408
categories:
  - Wordpress学习
date: 2012-06-10 05:35:03
---

迁移时可以把原先的数据库导出为.sql格式，然后再用notepad++或其它工具替换里面的所有域名为自己的新域名比如，替换crusherknowledge.com为crushertech.net ，这样你再导入新的数据库，这样便完成的数据库的迁移工作。

创建数据库并为新数据库添加用户名

```sql
CREATE DATABASE 'newdbname';
CREATE USER 'username'@'localhost' IDENTIFIED BY 'passwd';
GRANT ALL PRIVILEGES ON 'newdbname'.* TO 'usrname'@'localhost' IDENTIFIED BY 'passwd';
```

如果你没有这样做，这些表中的内容你需要修改。可以先修改wp_options, wp_blogs, wp_site 这几个重要的。然后再把所有的wp_N_posts和wp_N_options表中的内容替换下。

主要修改的表为：
wp_N_posts (N为每个博客的ID，下同)
wp_N_options
wp_blogs
wp_site

网站迁移好之后需要重定向，这个比较重要。如果你的wpu是二级域名格式的。可以这样重定向到新域名：

下面的例子为 http://crusherknowledge.com 重定向到 http://crushertech.net 

```
RewriteEngine On
RewriteCond %{HTTP_HOST} !^www\.crusherknowledge.com\.com
RewriteCond %{HTTP_HOST} ^(.*)\.crusherknowledge\.com$ [NC]
RewriteRule ^(.*)$ http://%1.crushertech\.net/$1 [R=301,L]
RewriteCond %{HTTP_HOST} ^crusherknowledge.com$ [NC]
RewriteRule ^(.*)$ http://crushertech.net/$1 [L,R=301]
```

这样便和原先的网站一模一样，只是域名不同而已。

了解更多关于`htaccess`的重写规则请访问：
http://man.chinaunix.net/newsoft/Apache2.2_chinese_manual/mod/mod_rewrite.html

从google中删除你网页的索引：

https://sites.google.com/site/webmasterhelpforum/zh-cn/how-to-remove-and-block-content-from-search-result