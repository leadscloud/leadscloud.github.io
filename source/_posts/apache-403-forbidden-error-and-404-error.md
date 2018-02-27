---
title: apache-403-forbidden-error-and-404-error
tags:
  - .htaccess
  - 301重定向
id: 24001
categories:
  - HTML/CSS
date: 2010-09-01 11:43:06
---

<pre class="brush: plain">Options +FollowSymLinks
RewriteEngine on
RewriteCond %{HTTP_HOST} ^rockscrusher.com [NC]
RewriteRule ^(.*)$ http://www.rockscrusher.com/$1 [L,R=301]
RewriteCond %{THE_REQUEST} ^.*/index.html
RewriteRule ^(.*)index.html$ http://www.rockscrusher.com/$1 [R=301,L]
RewriteCond %{THE_REQUEST} ^.*/index.php
RewriteRule ^(.*)index.php$ http://www.rockscrusher.com/$1 [R=301,L]

ErrorDocument 404 /404/
ErrorDocument 403 /403.html

&lt;Limit GET HEAD POST&gt;
order allow,deny
deny from 116.236.
#deny from 114.92.
allow from all
&lt;/Limit&gt;
</pre>

上面是我的htaccess的文件。可以设置404错误，403错误。以及301重定向。

404错误不仅对用户友好，对google也是友好的。

403错误一般是为了禁止某IP或一段IP访问，也可能为了防止索引images文件夹。

301重定向告诉google目标网页已永久转移。

apache 服务器才可以用.htaccess文件设置。由于windows下不能新建.htaccess文件，可以在服务器上新建.htaccess文件，然后下载下来在自己电脑上修改。把.htaccess文件上传在服务器根目录下就行了。

### 如何把旧域名转向到新域名

<pre class="brush: plain">
Options +FollowSymLinks
RewriteEngine on
RewriteRule (.*) http://www.newdomain.com/$1 [R=301,L]
</pre>

另外htaccess有个功能可以让你自己的服务器下新建许多文件来，然后让其它域名解析到这个空间，对应不同的文件夹。

<pre class="brush: plain">
RewriteCond %{REQUEST_URI} !^/ver1.0/
RewriteCond %{REQUEST_FILENAME} !-f
RewriteCond %{REQUEST_FILENAME} !-d
RewriteRule ^(.*)$ /ver1.0/$1
RewriteCond %{HTTP_HOST} ^(www.)binqcrusher.net$
RewriteRule ^(/)?$ ver1.0/ [L]
</pre>

这样访问binqcrusher.net实际访问是的根目录下的ver1.0文件夹。

### wordpress下二级目录建站时的重定向问题

如果你的网站二级目录下有wordpress建的站，它本身的.htaccess文件会和目前设置的301重定向文件(根目录的.htaccess)有冲突，一般情况下为，你输入二级目录时不带"/"会定向到错误的目录。依我的站为例case目录下用wordpress建的。当你输入http://www.rockscrusher.com/case时不会定向到http://www.rockscrusher.com/case/，下面的htaccess文件能解决此问题

<pre class="brush: shell">
# BEGIN WordPress
RewriteEngine on
#
# Unless you have set a different RewriteBase preceding this
# point, you may delete or comment-out the following
# RewriteBase directive:
RewriteBase /
#
#Start 301 redirect
RewriteCond %{HTTP_HOST} ^rockscrusher.com [NC]
RewriteRule ^(.*)$ http://www.rockscrusher.com/$1 [L,R=301]
RewriteCond %{THE_REQUEST} ^.*/index.html
RewriteRule ^(.*)index.html$ http://www.rockscrusher.com/$1 [R=301,L]
RewriteRule ^case/rock-crusher$ http://www.rockscrusher.com/case/mining-crusher/$1 [R=301,L]
RewriteRule ^case/rock-crusher/(.*)$ http://www.rockscrusher.com/case/mining-crusher/$1 [R=301,L]
#End 301 redirect
# if this request is for "/" or has already been rewritten to WP
RewriteCond $1 ^(index\.php)?$ [OR]
# or if request is for image, css, or js file
RewriteCond $1 \.(gif|jpg|css|js|ico)$ [NC,OR]
# or if URL resolves to existing file
RewriteCond %{REQUEST_FILENAME} -f [OR]
# or if URL resolves to existing directory
RewriteCond %{REQUEST_FILENAME} -d
# then skip the rewrite to WP
RewriteRule ^(.*)$ - [S=1]
# else rewrite the request to WP
RewriteRule . /case/index.php [L]
# END wordpress
</pre>

### 附：PHP 下的301 重定向

<pre class="brush: plain">
&lt;?php Header( "HTTP/1.1 301 Moved Permanently" );
Header( "Location: http://www.rockscrusher.com" );?&gt;
</pre>

**相关阅读**

[301重定向 - goole站长帮助文件](http://www.google.com/support/webmasters/bin/answer.py?hl=cn&amp;answer=93633)

[How to Redirect a Web Page](http://www.webconfs.com/how-to-redirect-a-webpage.php)

[HTTP状态代码](http://www.google.com/support/webmasters/bin/answer.py?hl=cn&amp;answer=40132)