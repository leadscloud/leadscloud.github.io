---
title: phpMyAdmin 3.4.3.1 安装过程
tags:
  - php
  - phpmyadmin
id: 313172
categories:
  - PHP学习
date: 2011-07-14 07:51:11
---

直接来步骤，以前总是安装失败，以为直接复制过来就行了，上网搜的教程全是抄的。没一个顶用的。

<wbr>

下面是我的本地安装步骤：

1、下载 phpMyAdmin-3.4.3.1-all-languages.zip 到网站根目录

2、解压到当前目录 phpMyAdmin-3.4.3.1-all-languages ，然后改名为phpmyadmin

3、进入phpmyadmin 新建文件夹 config ， 并把phpmyadmin目录下的 config.sample.inc.php 复制到config目录下。

4、输入[http://你的网址/phpmyadmin/setup/](http://xn--6qqv5qbo2armh/phpmyadmin/setup/) 进行安装。 我的是 [http://192.168.1.41/phpmyadmin/](http://192.168.1.41/phpmyadmin/)

5、新建一个服务器就行。 基本设置里 只需 服务器主机名 这一项必填。 我的是127.0.0.1 或locahost ，有时localhost不行，换成127.0.0.1就OK了。 在 认证 选 项下 Config 认证 留空就行了。 仔细看最下面，找到保存按钮，保存就行了。如果成功，在config文件夹下会生成一个文件 config.inc.php，复制它到phpmyadmin文件夹下就行了。

到此安装完成！

以下是我的`config.inc.php`文件。你应该可以复制过去，然后修改下就能用的。

```
<?php
/*
* Generated configuration file
* Generated by: phpMyAdmin 3.4.3.1 setup script
* Date: Sat, 09 Jul 2011 19:53:58 +0800
*/

/* Servers configuration */
$i = 0;

/* Server: 127.0.0.1 [1] */
$i++;
$cfg["Servers"][$i]["verbose"] = "";
$cfg["Servers"][$i]["host"] = "127.0.0.1";
$cfg["Servers"][$i]["port"] = "";
$cfg["Servers"][$i]["socket"] = "";
$cfg["Servers"][$i]["connect_type"] = "tcp";
$cfg["Servers"][$i]["extension"] = "mysqli";
$cfg["Servers"][$i]["auth_type"] = "cookie";
$cfg["Servers"][$i]["user"] = "";
$cfg["Servers"][$i]["password"] = "";

/* End of servers configuration */

$cfg["blowfish_secret"] = "4e184129b41c99.74270742";
$cfg["DefaultLang"] = "en";
$cfg["ServerDefault"] = 1;
$cfg["UploadDir"] = "";
$cfg["SaveDir"] = "";
?>

```