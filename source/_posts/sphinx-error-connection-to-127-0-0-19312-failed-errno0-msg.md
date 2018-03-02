---
title: sphinx error connection to 127.0.0.1:9312 failed (errno=0, msg=)
tags:
  - sphinx
id: 313535
categories:
  - Linux
date: 2012-12-19 03:49:50
---

sphinx安装好之后，无论如何不能使用php api访问，查找了两天，重装了几次VPS，今天上午，终于找到答案了。在这儿连接里 http://stackoverflow.com/questions/13929949/sphinx-error-connection-to-127-0-0-19845-failed-errno-0-msg  ，第一次看时没有注意，今天一句一句的看完了，才发现错误原因。看来学好英语是多么的重要，如果第一次看明白不会浪费这么多的时间了。浪费了一天的时间再研究它。以为没有答案了。

原因很简单，是因为lnmpa服务器下，禁用了一些函数，包括sphinx api必需的一个函数 fsockopen。 修改php.ini

<pre class="lang:sh decode:true " >/usr/local/php/etc/php.ini</pre> 

找到disable_functions 把fsockopen从里面删除就行了。另外再说明下，lnmpa的php配置文件默认也关闭了scandir，这会导致wordpress主题文件显示为空。把它也删了就行了。

http://sphinxsearch.com/forum/view.html?id=5414