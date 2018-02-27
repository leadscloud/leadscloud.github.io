---
title: linode-vps-使用sendmail发送邮件
tags:
  - linode
  - Linux
  - Sendmail
id: 313885
categories:
  - Linux
date: 2014-07-04 09:46:44
---

安装sendmail并启动它
<pre class="lang:sh decode:true">yum install sendmail
service sendmail start
</pre>
设置sendmail开机自动运行
<pre class="lang:sh decode:true">yum install chkconfig
chkconfig sendmail on
</pre>
测试邮件发送功能
<pre class="lang:sh decode:true">echo "This is test mail" | mail -s 'Test mail' xxxxx@qq.com
</pre>
如果提示 mail: command not found， 那么就是没有安装mail命令，此时需要安装mail命令：
<pre class="lang:sh decode:true">yum install mailx -y</pre>
安装过mail后就可以发送了，我测试了下，发送到我的QQ邮箱中是没有问题，并且不会识别为垃圾邮件。

如果想配置php的mail发送函数，按以下设置：

修改下php.ini的配置，调用sendmail功能
<pre class="lang:sh decode:true">vim /usr/local/php/etc/php.ini
</pre>
找到有关sendmail_path的那一行，去掉行首注释，并改成如下的样子：
<pre class="lang:sh decode:true">sendmail_path = /usr/sbin/sendmail -t -i
</pre>