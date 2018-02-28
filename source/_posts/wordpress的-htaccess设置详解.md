---
title: wordpress的-htaccess设置详解
tags:
  - .htaccess
  - wordpress
id: 254001
categories:
  - 转载
date: 2010-12-15 12:34:03
---

对于Apache服务器，使用.htaccess文件可以进行很多相关网络服务访问的配置。而以下的10个技巧则专门针对WordPress所进行的设置，推荐大家参考使用：

10 awesome .htaccess hacks for WordPress</a>

### RSS Feed

重定向WordPress的RSS Feed链接地址到Feedburner地址：

除了修改WP的模板文件来定制其输出的RSS Feed链接地址外，还可以使用.htaccess文件来进行设置(替换yourrssfeedlink为自己的Feedburner地址)。

```
# temp redirect wordpress content feeds to feedburner
<ifModule mod_rewrite.c>
RewriteEngine on
RewriteCond %{HTTP_USER_AGENT} !FeedBurner    [NC]
RewriteCond %{HTTP_USER_AGENT} !FeedValidator [NC]
RewriteRule ^feed/?([_0-9a-z-]+)?/?$ http://feeds2.feedburner.com/catswhocode [R=302,NC,L]
</ifModule>
```

How to redirect WordPress rss feeds to feedburner</a>

### category

去除WordPress分类链接中的&ldquo;/category/&rdquo;：

默认情况下，WordPress的分类链接显示的样式为：

http://e-spacy.com/blog/category/tech

其实其中的category部分没有任何意义，如果想去掉它可以修改.htaccess文件(替换yourblog为自己的网址)。

```
RewriteRule ^category/(.+)$ http://www.yourblog.com/$1 [R=301,L]
```

How to remove category from your WordPress url</a>

### 浏览器缓存

可以修改.htaccess文件让访问者使用浏览器缓存来优化其访问速度。

```
FileETag MTime Size
<ifmodule mod_expires.c>
<filesmatch "\.(jpg|gif|png|css|js)$">
ExpiresActive on
ExpiresDefault "access plus 1 year"
</filesmatch>
</ifmodule>
```

Comment accelerer le temps de chargement de votre blog</a>

### 压缩静态数据

可以修改.htaccess文件来压缩需要访问的数据(传输后在访问端解压)，从而可以减少访问流量和载入时间。

```
AddOutputFilterByType DEFLATE text/html text/plain text/xml application/xml application/xhtml+xml text/javascript text/css application/x-javascript
BrowserMatch ^Mozilla/4 gzip-only-text/html
BrowserMatch ^Mozilla/4.0[678] no-gzip
BrowserMatch bMSIE !no-gzip !gzip-only-text/html
```

### Post name

重定向日期格式的WP Permalink链接地址为Postname格式：

如果你目前的Permalink地址为/%year%/%monthnum%/%day%/%postname%/ 的格式，那么我强烈推荐你直接使用/%postname%/ ，这样对搜索引擎要舒服得多。首先你需要在WordPress的后台设置输出的Permalinks格式为/%postname%/ 。然后修改.htaccess文件来重定向旧的链接，不然别人以前收藏你的网址都会转成404哦!(替换yourdomain为自己的网址)

```
RedirectMatch 301 /([0-9]+)/([0-9]+)/([0-9]+)/(.*)$ http://www.yourdomain.com/$4
```

Redirect day and name permalinks to postname</a>

### 垃圾评论

阻止没有referrer来源链接的垃圾评论：

设置.htaccess文件可以阻止大多数无Refferrer来源的垃圾评论机器人Bot Spammer。其会查询访问你网站的来源链接，然后阻止其通过wp-comments-post.php来进行垃圾评论。

```
RewriteEngine On
RewriteCond %{REQUEST_METHOD} POST
RewriteCond %{REQUEST_URI} .wp-comments-post\.php*
RewriteCond %{HTTP_REFERER} !.*yourblog.com.* [OR]
RewriteCond %{HTTP_USER_AGENT} ^$
RewriteRule (.*) ^http://%{REMOTE_ADDR}/$ [R=301,L]4
```

How to deny comment posting to no referrer requests</a>

### 维护页面

定制访问者跳转到维护页面：

当你进行网站升级，模板修改调试等操作时，最好让访问者临时跳转到一个声明的维护页面(和404错误页面不同)，来通知网站暂时无法访问，而不是留 下一片空白或者什么http bad错误。(替换maintenance.html为自己定制的维护页面网址，替换123.123.123.123为自己目前的IP地址，不然你自己访 问也跳转哦)

```
RewriteEngine on
RewriteCond %{REQUEST_URI} !/maintenance.html$
RewriteCond %{REMOTE_ADDR} !^123\.123\.123\.123
RewriteRule $ /maintenance.html [R=302,L]
```

Comment faire une page d&rsquo;accueil pour les internautes</a>

### 防盗链

设置你的WordPress防盗链：

盗链是指其它网站直接使用你自己网站内的资源，从而浪费网站的流量和带宽，比如图片，上传的音乐，电影等文件。(替换mysite为自己的网址和/images/notlink.jpg为自己定制的防盗链声明图片)

```
RewriteEngine On
#Replace ?mysite\.com/ with your blog url
RewriteCond %{HTTP_REFERER} !^http://(.+\.)?mysite\.com/ [NC]
RewriteCond %{HTTP_REFERER} !^$
#Replace /images/nohotlink.jpg with your "don't hotlink" image url
RewriteRule .*\.(jpe?g|gif|bmp|png)$ /images/nohotlink.jpg [L]
```

How to protect your WordPress blog from hotlinking</a>

### wp-admin限制IP

只允许自己的IP访问wp-admin：

如果你不是团队合作Blog，最好设置只有自己能够访问WP的后台。前提是你的IP不是像我一样动态的哦。(替换xx.xx.xx.xx为自己的IP地址)

```
AuthUserFile /dev/null
AuthGroupFile /dev/null
AuthName "Example Access Control"
AuthType Basic
<limit GET>
order deny,allow
deny from all
allow from xx.xx.xx.xx
</limit>
```

Protecting the WordPress wp-admin folder</a>

### 阻止指定IP的访问

如果你想要阻止指定IP的访问，来防止其垃圾评论，那么你可以创建自己的Backlist黑名单。(替换xx.xx.xx.xx为指定的IP地址)

```
<limit GET POST>
order allow,deny
deny from xx.xx.xx.xx
allow from all
</limit>
```

The easiest way to ban a WordPress spammer</a>