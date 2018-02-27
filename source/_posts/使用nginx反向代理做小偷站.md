---
title: 使用nginx反向代理做小偷站
tags:
  - Nginx
id: 313248
categories:
  - 个人日志
date: 2012-01-09 02:48:42
---

用Nginx的反向代理可以轻松山寨对方的网站,但是反向代理后的网站还是有对方的绝对链接时，怎么办？所以要用替换链接方法。

1 使用官方的的模块 编译参数–with-http_sub_module
ub_filter 源网站链接 替换自己的链接;
sub_filter_once off;
只能匹配1行

http://wiki.nginx.org/HttpSubModule

2 使用第三方模块
svn checkout http://substitutions4nginx.googlecode.com/svn/trunk/substitutions4nginx-read-only
编译参数–add-module=模块地址

http://wiki.nginx.org/HttpSubsModule#Installation

3 自己加广告等等代码可以
sub_filter ” ‘你的XXX代码’;
sub_filter_once on;

更为详细

相信大家都已经很熟悉 Apache 和 Nginx, 其实它们本身都有关键词替换功能，也就是说，你根本不需要安装任何额外的软件，甚至连 php/mysql 都省了，只要用 Apache 或者 nginx 就可以实现网站克隆/伪原创。

要点只有2个:

1\. 反向代理

2\. 关键词替换

下面就讲讲过程 (centos-32bit)

1\. nginx + substitutions 安装

nginx 自带一个Substitution模块，但该模块只能写一行，所以我们改用 substitutions

下面是安装一些预备软件

复制内容到剪贴板

代码:

yum -y –noplugins install wget zip

yum -y –noplugins install unzip

yum -y –noplugins install gcc

yum -y –noplugins install make

yum -y –noplugins install pcre-devel

yum -y –noplugins install openssl-devel

下载软件

复制内容到剪贴板

代码:

wget -c http://www.nginx.org/download/nginx-1.0.8.tar.gz //下载nginx

svn checkout http://substitutions4nginx.googlecode.com/svn/trunk/ substitutions4nginx-read-only //下载substitutions

编译软件

复制内容到剪贴板

代码:

tar zxf nginx-1.0.8.tar.gz

cd nginx-1.0.8.tar.gz

./configure ./configure –add-module=path/substitutions4nginx-read-only //注意这里的path是相对应的真实路径

make

make install

此时，nginx应该安装在于 /usr/local/nginx 下面

配置 nginx.conf

复制内容到剪贴板

代码:

server_name www.urdomain.com;

location / {

subs_filter ca-pub-9805743306566114 ca-pub-98057433063434; //把google ad 的用户号 ca-pub-9805743306566114 改成你自己的，比如 ca-pub-98057433063434

subs_filter 6121088089 612108343455; //把google ad 的广告号 6121088089 改成你自己的，比如 612108343455 ，你懂的！：D

proxy_pass www.urdomain.com; //反向代理美国主机村。 最好找一些带有google 广告的网站，主机村在 google 收录 34万条，百度收录几乎没有，这或许是.info 的失败，也是为什么我们选择这样的网站来反代的原因。

index index.html index.htm;

}

记住subs_filter 命令的格式，你想替换设么就随你了。比如我把网站的网址 www.urdomain.com替换成了 www.urdomain-2.com

另外， 反向代理的个数是不限制的。只要你掌握了规则，一个网站下可以包含n多个网站的镜像。 一个nginx 上也可以跑 n多个网站。就看你自己怎么运用了。

别忘了吧logo地址替换成自己的.