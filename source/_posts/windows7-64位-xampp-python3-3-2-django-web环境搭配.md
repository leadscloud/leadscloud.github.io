---
title: windows7-64位-xampp-python3-3-2-django-web环境搭配
id: 313755
categories:
  - 个人日志
date: 2014-03-13 13:59:54
tags:
---

windows7 64位 XAMPP python3.3.2 web环境搭配

本来根据网上的资料想使用mod_python，可是没有对应python3.3.2的版本，在http://stackoverflow.com/questions/3319545/mod-wsgi-mod-python-or-just-cgi这个问题上，发现是建议使用mod_wsgi
从http://code.google.com/p/modwsgi/wiki/DownloadTheSoftware?tm=2 了解到mod wsgi在window下的安装过程。

mod_wsgi的下载地址为：http://www.lfd.uci.edu/~gohlke/pythonlibs/#mod_wsgi

根据版本号下载相应文件，python3.3.2对应
http://www.lfd.uci.edu/~gohlke/pythonlibs/bmsicnqj/mod_wsgi-3.4.ap24.win-amd64-py3.3.zip

解压mod_wsgi.so并复制到你的apache安装目录下的modules文件夹下，比如我的使用的是xampp，相应的apache目录为 D:\xampp\apache\modules

在httpd.conf文件中加入

LoadModule wsgi_module modules/mod_wsgi.so

但总是失败 can not load modules/mod_wsgi.so into server ，最后是把xampp中的apache替换成 http://www.apachelounge.com/download/ 这个网站上的相应版本的apache,然后才成功。 【Apache2.4.4需要VC10库支持】

下载2.4后，mod_wsgi可以用了，但xampp与php的联系不可用了，重新下载php5.4 VC11 x64解决问题。
http://windows.php.net/downloads/releases/php-5.5.10-Win32-VC11-x64.zip

还需要修改httpd.conf ，添加以下代码

```
WSGIScriptAlias /googlescrape "D:/workfiles/wwwroot/googlescrape/"
<Directory "D:/workfiles/wwwroot/googlescrape">
    Order allow,deny
    Allow from all
</Directory>
```

在xampp中，你也可以添加到httpd-vhosts.conf中

也行你会发现新装php后，mysql连接不能用了
解决办法
复制一份php.ini-development为php.ini, 在PHP.ini中找到  
`extension_dir = "ext"   （大约852行）`
改为 
`extension_dir = "d:/php/ext"`
并去掉注释

找到;extension=php_mysql.dll    （大约1005行）
将';'去掉，改为
extension=php_mysql.dll

重启apache服务即可。

Django 是 使用 easy_install Django 安装的。

进入相应目录(例如：D:\workfiles\wwwroot\)使用Django-admin.py startproject googlescrape 生成相应项目
如果需要数据库使用：
执行 manage.py syncdb 生成数据库。

```
D:\workfiles\wwwroot\googlescrape>manage.py syncdb
Creating tables ...
Creating table django_admin_log
Creating table auth_permission
Creating table auth_group_permissions
Creating table auth_group
Creating table auth_user_groups
Creating table auth_user_user_permissions
Creating table auth_user
Creating table django_content_type
Creating table django_session

You just installed Django's auth system, which means you don't have any superuse
rs defined.
Would you like to create one now? (yes/no): yes
Username (leave blank to use 'administrator'): admin
Email address: xxx@gmail.com
Password:
Password (again):
Superuser created successfully.
Installing custom SQL ...
Installing indexes ...
Installed 0 object(s) from 0 fixture(s)
```


注：
有个相关教程在里：http://enkoding.blogspot.jp/2013/01/setup-python-for-web-in-7-steps-on.html， 可能需要翻墙，我的安装比较麻烦，主要是我的xampp不支持上面的各种mod_wsgi，我最后不得不在http://www.apachelounge.com/download/重新下载apache2.4

查到相关资料，可能是因为mod_wsgi必须是apache版本64位的，所以32位的会出问题，可以尝试下载一个64位的xampp试试，我目前还没有尝试。

参考资料：
http://agong.org/2013/windows64-python3-apache-wsgi-django.html
http://www.cnblogs.com/zhoujie/archive/2013/05/11/django1.html
http://www.cnblogs.com/wang_yb/archive/2011/04/14/2016513.html
http://www.vimer.cn/2010/09/apachemod_wsgidjango%E5%9C%A8windows%E4%B8%8B%E7%9A%84%E9%83%A8%E7%BD%B2.html