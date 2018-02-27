---
title: lnmpa中apache的status问题解决方法
tags:
  - lnmpa
  - VPS
id: 313474
categories:
  - Linux
date: 2012-07-17 06:12:21
---

LNMPA中Apache的/root/lnmpa status问题解决方法

高手请无视，小白可借鉴。

问题描述：

LNMP0.7升级到LNMPA后
运行命令/root/lnmpa status
Apache的status一项会出现错误提示：
/etc/init.d/httpd: line 112: lynx: command not found
或者
Error 403 Access forbidden!

解决方法：
出现lynx: command not found错误提示的需要完成Step1&amp;Step2
出现Error 403 Access forbidden!错误提示的只需要完成Step2

Step1
安装lynx
<pre class="lang:sh decode:true">yum install lynx -y</pre>
Step2
运行命令
<pre class="lang:sh decode:true">vi /usr/local/apache/conf/extra/httpd-info.conf</pre>
将
<pre class="lang:sh decode:true">&lt;Location /server-status&gt;
    SetHandler server-status
    Order deny,allow
    Deny from all
    Allow from .example.com
&lt;/Location&gt;</pre>
改成
<pre class="lang:sh decode:true">&lt;Location /server-status&gt;
    SetHandler server-status
    Order deny,allow
    Deny from all
    Allow from 127.0.0.1
&lt;/Location&gt;</pre>
重启Apache
<pre class="lang:sh decode:true">service httpd restart</pre>
再用/root/lnmpa status或者service httpd status查看Apache状态就是正常的了
还可以用http://youripordomain/server-status访问通过Web查看

附： LNMPA 常见问题整理(不定期更新)

[http://bbs.vpser.net/thread-2792-1-1.html](http://bbs.vpser.net/thread-2792-1-1.html "LNMPA 常见问题整理(不定期更新)")