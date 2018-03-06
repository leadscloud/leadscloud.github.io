---
title: 使用.htaccess替换网站页面中的关键词
tags:
  - .htaccess
id: 313493
categories:
  - Linux
date: 2012-08-27 09:21:22
---

替换网站页面中的(似乎只有VPS可以。虚拟空间是不行的。)。  VPS只要在 httpd.conf中修改就可以保证些服务器下的所有页面都如此。

```
<IfModule mod_substitute.c>
  <Location />
    AddOutputFilterByType SUBSTITUTE text/html
    Substitute s/foo/bar/ni
  </Location>
</IfModule>
```

如果是替换域名中的关键词：

```
RewriteRule ^oldword/(.*)   /newword/$1   [R=301,L]
```

参考文章：

[http://corpocrat.com/2008/09/19/install-apache-mod_substitute/](http://corpocrat.com/2008/09/19/install-apache-mod_substitute/)

[http://httpd.apache.org/docs/2.2/mod/mod_substitute.html](http://httpd.apache.org/docs/2.2/mod/mod_substitute.html)

[http://stackoverflow.com/questions/799809/htaccess-redirect-after-replace-a-word](http://stackoverflow.com/questions/799809/htaccess-redirect-after-replace-a-word)

补充：

最近我的wordpress需要替换搜索中的一些关键词，主要是url也不能出现。修改代码比较麻烦。直接用.htaccess比较简单。这是我的写法

```
# BEGIN WordPress
<IfModule mod_rewrite.c>
RewriteEngine On
RewriteBase /
RewriteRule ^search/(.*)symons(.*)   search/$1simons$2   [R=301,L]
RewriteRule ^index\.php$ - [L]
RewriteCond %{REQUEST_FILENAME} !-f
RewriteCond %{REQUEST_FILENAME} !-d
RewriteRule . /index.php [L]
</IfModule>

# END WordPress
```

这样之后

`http://youdomain.com/search/used-symons-cone-crusher/` 

会自动跳转到 

`http://youdomain.com/search/used-simons-cone-crusher/`