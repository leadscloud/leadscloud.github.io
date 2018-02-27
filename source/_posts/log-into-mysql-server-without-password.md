---
title: log-into-mysql-server-without-password
tags:
  - MySQL
id: 313830
categories:
  - Linux
date: 2014-06-08 14:47:23
---

mysql 的一般登陆方式是这样的
<pre class="lang:sh decode:true " >mysql -u $MYSQL_ROOT -p $MYSQL_PASS -h 192.168.10.1</pre> 

但是，你有两个方式可以使用无密码提示的登陆，一个是修改/etc/my.cnf文件，一个是修改~/.my.conf 文件。

<pre class="lang:sh decode:true " >$ vi ~/.my.cnf</pre> 

`
[client]
user=alice
password=alice_passwd
host=192.168.10.1
`

如果是修改my.cnf文件，把它加到文件末尾就行了。你可以直接使用  
<pre class="lang:sh decode:true " >mysql -u root</pre>
登陆，不会再提示密码错误。但如果你仍然使用
<pre class="lang:sh decode:true " >mysql -u root -p</pre> 
的方式，它还是会提示你输入密码的。

确保文件是只读的
<pre class="lang:sh decode:true " >$ chmod 0600 ~/.my.cnf</pre> 