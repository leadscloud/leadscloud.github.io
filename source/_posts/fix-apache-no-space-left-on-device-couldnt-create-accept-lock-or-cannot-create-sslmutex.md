---
title: >-
  fix-apache-no-space-left-on-device-couldnt-create-accept-lock-or-cannot-create-sslmutex
id: 313438
categories:
  - Linux
date: 2012-06-25 10:06:25
tags:
---

最近VPS上有个网站总是挂掉，应该是耗CPU太厉害了。因为是 wordpress mu 站。 但是重启httpd时，总是不成功。

提示 httpd dead but pid file exists

解决办法：

tails -n 20 /var/log/httpd/error_log

查看日志，看有什么错误 ，我的错误显示：

[Mon Jun 25 17:54:02 2012] [emerg] (28)No space left on device: Couldn't create accept lock (/usr/local/apache/logs/accept.lock.3610) (5)

解决办法：http://carlosrivero.com/fix-apache---no-space-left-on-device-couldnt-create-accept-lock

ipcs -s | grep apache | perl -e 'while (&lt;STDIN&gt;) { @a=split(/\s+/); print `ipcrm sem $a[1]`}'
<pre class="lang:sh decode:true ">ipcs -s | grep apache | perl -e 'while (&lt;STDIN&gt;) { @a=split(/\s+/); print `ipcrm sem $a[1]`}'</pre>
&nbsp;

然后再试试： service httpd start 应该就没问题了