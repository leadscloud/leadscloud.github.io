---
title: linode vps 使用sendmail发送邮件
tags:
  - linode
  - Linux
  - Sendmail
id: 313885
categories:
  - [Linux]
  - [技术]
date: 2014-07-04 09:46:44
---

安装sendmail并启动它

```
yum install sendmail
service sendmail start
```


设置sendmail开机自动运行

```
yum install chkconfig
chkconfig sendmail on
```


测试邮件发送功能

```
echo "This is test mail" | mail -s 'Test mail' xxxxx@qq.com
```


如果提示 mail: command not found， 那么就是没有安装mail命令，此时需要安装mail命令：

```
yum install mailx -y
```

安装过mail后就可以发送了，我测试了下，发送到我的QQ邮箱中是没有问题，并且不会识别为垃圾邮件。

如果想配置php的mail发送函数，按以下设置：

修改下php.ini的配置，调用sendmail功能

```
vim /usr/local/php/etc/php.ini
```


找到有关sendmail_path的那一行，去掉行首注释，并改成如下的样子：

```
sendmail_path = /usr/sbin/sendmail -t -i
```

