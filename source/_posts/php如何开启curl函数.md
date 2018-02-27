---
title: php如何开启curl函数
id: 313431
categories:
  - PHP学习
date: 2012-06-19 01:20:52
tags:
---

PHP如何开启curl函数？

如果你使用的是XAMPP, 在安装目录下面的，php文件夹下。找到php.ini ,查找 php_curl.dll ,把前的注释 分号(;)去掉即可。 

File_get_contents函数找开https url 时，会提示错误，没有安装openssl支持远程打开https文件。 如何解决？

找到php.ini 加上这段代码，或把此代码前面的注释去掉，XAMPP没有这句话，加上去即可。 把;extension=php_openssl.dll 改为 extension=php_openssl.dll 

或者直接加上 extension=php_openssl.dll