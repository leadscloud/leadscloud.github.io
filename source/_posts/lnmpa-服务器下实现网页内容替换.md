---
title: LNMPA 服务器下实现网页内容替换
id: 313526
categories:
  - 技术
date: 2012-12-17 06:06:17
tags: lnmpa
---

最近公司需要替换很多页面中的关键词，对于一个网站很好办，但对于很多网站，并且有些是动态的，有些是静态的，就比较麻烦了。以前想到可以用apache的hhtpd.conf替换，不过我的服务器用的lnmpa，那个方法不太好实现，现在用的办法是使用nginx第三方组件完成，运行比较完美！

首先需要了解下[substitutions4nginx](http://code.google.com/p/substitutions4nginx/)，这是一个nginx模块，可以实现内容的批量替换功能，支持正则表达式。

[http://code.google.com/p/substitutions4nginx/](http://code.google.com/p/substitutions4nginx/)

下面是我在centos上安装它。
<pre class="lang:sh decode:true">svn checkout http://substitutions4nginx.googlecode.com/svn/trunk/ substitutions4nginx-read-only</pre>
如果提示没有安装svn, centos下请使用yum -y install subversion  debian下请使用 apt-get install subversion  安装。

下面是查看你的nginx版本和编绎参数。
<pre class="lang:sh decode:true">/usr/local/nginx/sbin/nginx -V</pre>
根据你的nginx版本，重新编绎它。比如我安装的是lnmpa0.9
<pre class="lang:sh decode:true">cd /root/lnmp0.9/nginx-1.2.5/

./configure --user=www --group=www --prefix=/usr/local/nginx --with-http_stub_status_module --with-http_ssl_module --with-http_gzip_static_module --with-ipv6 --with-pcre --with-http_sub_module --add-module=/root/substitutions4nginx-read-only
make
make install</pre>
重启你的nginx
<pre class="lang:sh decode:true">/etc/init.d/nginx</pre>
然后会对不同的网站修改你的nginx网站配置文件
<pre class="lang:sh decode:true">vi /usr/local/nginx/conf/vhost/www.clinkergrindingmill.com.conf</pre>
在location / 加上，默认只对html起作用，如果想对php文件也起作用，请在location @apache  location ~ .*\.(php|php5)?$下面也加上这代码。
<pre class="lang:default decode:true">subs_filter ' ' 'SBM' gi;</pre>
这是一个示例：

[![](http://www.love4026.org/wp-content/uploads/2012/12/sub_replace.png "示例图片")](http://www.love4026.org/wp-content/uploads/2012/12/sub_replace.png)

另外如果你只想匹配单词请使用，' \b'  \b代表单词的边界，这样就只匹配一个完整的单词。

如果想启用正则匹配：
<pre class="lang:sh decode:true">subs_filter '( | )' 'SBM' gir;</pre>
如果你想把所在VPS下的网站都启用相同的替换功能，请修改vi /usr/local/nginx/conf/nginx.conf
<pre class="lang:sh decode:true">vi /usr/local/nginx/conf/nginx.conf</pre>
把替换规则写在http之下，server之上。

对于lnmp如果你想替换整个VPS上的网站，可以直接把subs_filter追加到/usr/local/nginx/conft/nginx.conf的 http 里。 即可实现替换。
对lnmpa我详细解释下放到location / 的意思。
location / 对所有静态文件启用
localtion @apache 对于伪静态，比如目录启用。
location ~ .*\.(php|php5)?$  对于php文件启用。
放到最外面，即是对所有文件启用，包括css文件及其它文件。

substitutions4nginx参数：

g(default):替换所有匹配的字符串。
i: 执行不区分大小写的匹配。
o: 只需将第一个。
r: 该模式是作为一个正则表达式处理，默认是固定的字符串。

如果是替换中文词组则需要将nginx的配置文件保存为utf-8格式！