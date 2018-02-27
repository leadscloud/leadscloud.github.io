---
title: 测试php空间是否支持sqlite3
tags:
  - SQLite
  - SQLite3
id: 313760
categories:
  - 个人日志
date: 2014-03-14 09:25:08
---

测试代码如下：
<pre class="lang:php decode:true" title="测试代码sqlite_support.php">&lt;?php
if (extension_loaded('sqlite')) { 
    echo 'Support'; 
}else{ 
    echo 'Not Support'; 
} 
?&gt;</pre>
另外一个测试代码，测试sqlite3的
<pre class="lang:php decode:true">&lt;?php
$db = new SQLite3('mysqlitedb.db');

$results = $db-&gt;query('SELECT bar FROM foo');
while ($row = $results-&gt;fetchArray()) {
    var_dump($row);
}
?&gt;</pre>
在linux命令下测试：
<pre class="lang:sh decode:true">php -i | grep -i sqlite3</pre>
应该会出现以下代码：
<pre class="lang:sh decode:true">sqlite3
SQLite3 support =&gt; enabled
SQLite3 module version =&gt; 0.7-dev
sqlite3.extension_dir =&gt; no value =&gt; no value</pre>
我的php5.2.3默认是支持sqlite3的，如果不支持，你可以升级下PHP

SQLite3 扩展自 PHP 5.3.0 起已默认启用。 允许在编译时使用 _--without-sqlite3_ 禁用之。

Windows 用户必须启用 <var>php_sqlite3.dll</var> 方可使用该扩展。自 PHP 5.3.0 起，此扩展的 <acronym title="Dynamic Link Library">DLL</acronym> 文件 已包含于 Windows 版的 PHP 发行包中。

军哥的LNMP0.9  PHP 5.2.17p1 (cli) 可能不支持sqlie3
你可以选择升级PHP，或者使用以下方法安装：

<pre class="lang:sh decode:true " >cd ~
wget http://pecl.php.net/get/sqlite3-0.6.tgz
tar -zxf sqlite3-0.6.tgz
cd sqlite3-0.6/
phpize
./configure --with-php-config=/usr/local/php/bin/php-config
make
make install
/etc/init.d/httpd restart</pre> 

安装完成后如果还是不行，需要修改php.ini( vi /usr/local/php/etc/php.ini)一个配置
 [在命令下查看配置文件路径的方法： `php -i | grep 'Configuration File'`]
<pre class="lang:default decode:true " >; Directory in which the loadable extensions (modules) reside.
extension_dir = "/usr/local/php/lib/php/extensions/no-debug-non-zts-20060613/"
extension = "memcache.so"
extension = "pdo_mysql.so"
</pre> 
修改为
<pre class="lang:default decode:true " >; Directory in which the loadable extensions (modules) reside.
extension_dir = "/usr/local/php/lib/php/extensions/no-debug-non-zts-20060613/"
extension = "memcache.so"
extension = "pdo_mysql.so"
extension = "sqlite3.so"
</pre> 
重启服务即可。

但是当我执行 文件时出错了
SQLite header and source version mismatch
解决办法参考：
http://stackoverflow.com/questions/6696861/how-do-i-upgrade-my-sqlite3-package-on-debian-lenny

### 其它

sqlite3 数据库错误，Error: database disk image is malformed 目前搜索的解决的方案都说无法解决。只能通过备份解决，此问题是在本地测试正常，上传到服务器时出现此错误，你可以在本地通过备份操作，先导出数据库为sql文件，然后上传sql文件，在服务器端重新创建。

备份操作：
sqlite3  testdb ".dump" > dump
mv testdb.mdb testdb.mdb.backup
cat dump | sqlite3 testdb.mdb

更新： 由于使用ftp工具直接上传的sqlite数据库，所以出现问题，你可以把传输模式改为二进制。或者打包成压缩后再传输。经测试可以解决上传之后的sqlite数据库database disk image is malformed问题。