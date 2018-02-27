---
title: install-and-configure-sphinx-search-engine-for-wordpress-on-centos
tags:
  - sphinx
id: 313355
categories:
  - Linux
  - Wordpress学习
date: 2012-05-07 06:02:31
---

1, Download Sphinx search engine from Sphinx
<pre class="lang:sh decode:true">wget http://www.sphinxsearch.com/downloads/sphinx-0.9.8.tar.gz

tar xzvf sphinx-0.9.8.tar.gz</pre>
2, Install MySQL mysql-devel
<pre class="lang:sh decode:true">yum install mysql-devel</pre>
3, Configure Sphinx
<pre class="lang:sh decode:true">cd sphinx-0.9.8
./configure --prefix /home/sphinx/sphinxsearch --with-mysql
make
make install</pre>
&nbsp;

4, Create a configuration file
<pre class="lang:sh decode:true ">cd /home/sphinx/sphinxsearch/etc
cp sphinx.conf.dist sphinx.conf</pre>

5, Edit sphix.conf
<pre class="lang:sh decode:true ">vi sphinx.conf</pre>

Configuration file sphinx.conf for wordpress
<pre class="lang:sh decode:true ">source mywhiteboard
{
type = mysql
sql_host = localhost
sql_user = mywhiteboard
sql_pass = a1b2c3z4y5x6
sql_db = ivdb
sql_port = 3306
sql_query = SELECT id, post_title, post_content FROM wp_posts
sql_query_info = SELECT * FROM wp_posts WHERE id =$id
}

index mywhiteboard
{
source = mywhiteboard
path = /home/sphinx/sphinxsearch/var/data/mywhiteboard
docinfo = extern
mlock = 0
morphology = stem_en
enable_star=1

stopwords = /home/sphinx/sphinxsearch/var/data/stopwords.txt
min_word_len = 3
charset_type = sbcs
min_prefix_len = 0
min_infix_len = 3
html_strip = 1
html_remove_elements = style, script
}

indexer
{
mem_limit = 256M
}
searchd
{
port = 3312
log = /home/sphinx/sphinxsearch/var/log/searchd.log
query_log = /home/sphinx/sphinxsearch/var/log/query.log
read_timeout = 5
max_children = 30
pid_file = /home/sphinx/sphinxsearch/var/log/searchd.pid
max_matches = 1000
seamless_rotate = 1
preopen_indexes = 0
unlink_old = 1
}</pre>
6, make a directory for indexes
<pre class="lang:sh decode:true ">mkdir /home/sphinx/sphinxsearch/var/data/mywhiteboard</pre>

7,  Start indexer:
<pre class="lang:sh decode:true ">/home/sphinx/sphinxsearch/bin/indexer --config  /home/sphinx/sphinxsearch/etc/sphinx.conf --all

Sphinx 0.9.8-release (r1371)
Copyright (c) 2001-2008, Andrew Aksyonoff

using config file '/home/sphinx/sphinxsearch/etc/sphinx.conf'...
indexing index 'mywhiteboard'...
collected 1104407 docs, 1938.9 MB
sorted 6551.8 Mhits, 98.5% donedone
total 1104407 docs, 1938867135 bytes
total 5126.826 sec, 378180.78 bytes/sec, 215.42 docs/sec</pre>
8, To test if it is working:
<pre class="lang:sh decode:true ">
/home/sphinx/sphinxsearch/bin/search  --config /home/sphinx/sphinxsearch/etc/sphinx.conf insulin

....
20\. document=9345, weight=3
    id=9345
....
words:
1\. 'insulin': 30601 documents, 109926 hits
<pre class="lang:sh decode:true ">
ls -la
/home/sphinx/sphinxsearch/var/data/mywhiteboard
drwxr-xr-x 3 root root 4096 Oct 21 16:20 .
drwxr-xr-x 4 root root 4096 Sep 11 20:08 ..
-rw-r--r-- 1 root root 0 Oct 21 15:32 mywhiteboard.spa
-rw-r--r-- 1 root root 14925566596 Oct 21 16:20 mywhiteboard.spd
-rw-r--r-- 1 root root 237 Oct 21 16:20 mywhiteboard.sph
-rw-r--r-- 1 root root 57254921 Oct 21 16:20 mywhiteboard.spi
-rw-r--r-- 1 root root 0 Oct 21 15:32 mywhiteboard.spm
-rw-r--r-- 1 root root 22721504506 Oct 21 16:20 mywhiteboard.spp
</pre>

wordpress-sphinx-search 插件的安装教程

http://www.ivinco.com/software/wordpress-sphinx-search-tutorial/