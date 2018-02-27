---
title: mysql错误：is-marked-as-crashed-and-should-be-repaired
id: 313472
categories:
  - 转载
date: 2012-07-16 07:48:26
tags:
---

我的wordpress网站出问题了，访问一看，果然全屏报错，检查mysql日志，错误信息为：

Table '.\wp_posts' is marked as crashed and should be repaired

提示说cms的文章表dede_archives被标记有问题，需要修复。于是赶快恢复历史数据，上网查找原因。最终将问题解决。解决方法如下：

找到mysql的安装目录的bin/myisamchk工具，在命令行中输入：

<pre class="lang:sh decode:true " >./myisamchk -c -r /usr/local/mysql/data/wp\@002dsouthafricacrusher\@002dcom/wp_posts.MYI</pre> 

然后myisamchk 工具会帮助你恢复数据表的索引。重新启动mysql，问题解决。

问题分析：

1、错误产生原因，有网友说是频繁查询和更新dede_archives表造成的索引错误，因为我的页面没有静态生成，而是动态页面，因此比较同意这种说法。还有说法为是MYSQL数据库因为某种原因而受到了损坏，如：数据库服务器突发性的断电、在提在数据库表提供服务时对表的原文件进行某种操作都有可能导致MYSQL数据库表被损坏而无法读取数据。总之就是因为某些不可测的问题造成表的损坏。