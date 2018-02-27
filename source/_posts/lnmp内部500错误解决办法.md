---
title: lnmp内部500错误解决办法
tags:
  - lnmp
id: 313793
categories:
  - 个人日志
date: 2014-05-15 05:12:05
---

LNMP安装后，打开 ftp 空白页面，原来是发生了内部500错误。说下解决办法

你可以在发生错误的php页面头部加入以下代码，显示详细错误信息

ini_set('display_errors','1');
error_reporting(E_ALL);

然后根据详情查看错误原因。

我的是出现下面这样的错误

open_basedir restriction  in effect. is not within the allowed  path(s): 

修改php.ini，找到下面的这几行，删掉就行了。
vi /usr/local/php/etc/php.ini

[HOST=www.vpser.net]
open_basedir=/home/wwwroot/www.vpser.net/:/tmp/
[PATH=/home/wwwroot/www.vpser.net]
open_basedir=/home/wwwroot/www.vpser.net/:/tmp/