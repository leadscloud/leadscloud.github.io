---
title: 禁用或移除-wordpress文章修订版本-revision-post-features
tags:
  - wordpress
id: 255001
categories:
  - PHP学习
date: 2010-12-17 11:19:12
---

wordpress默认的文章修订版本功能帮助博主保留文章修订时的记录，包括修改作者和修改时间，也可以在任何时候恢复以前的版本。然而过多的修订版本会影响博客的加载与打开速度。这意味着浏览者要等待更长的时间才能看到博客的内容。另外，太多的修订版本也会引起服务器上CPU的超载。

<span style="font-family: Tahoma, Verdana, Arial, sans-serif; color: #222222; line-height: 18px;">修订功能将每个修改版在 post 数据表里插入一条记录，如果经常修改内容的话，post 表会增大N倍，大大的降低博客速度和性能。这个功能对很小的一部分用户可能有帮助，但对于一般的博客，根本用不上。</span>

<span style="font-family: Tahoma, Verdana, Arial, sans-serif; color: #222222;"><span style="line-height: 18px;">如果想关闭这个功能，在wordpress根目录，找到wp-config.php在代码 </span></span><span style="font-family: Tahoma, Verdana, Arial, sans-serif; color: #222222; line-height: 18px;">define('ABSPATH', dirname(__FILE__).'/'); 之前 加上以下代码</span>

<pre class="lang:php decode:true " >define('WP_POST_REVISIONS', false);</pre> 

<pre class="php" style="font-family: monospace;"><span style="color: #990000;">define</span><span style="color: #009900;">(</span><span style="color: #0000ff;">'WP_POST_REVISIONS'</span><span style="color: #339933;">,</span> <span style="color: #009900; font-weight: bold;">false</span><span style="color: #009900;">)</span><span style="color: #339933;">;</span></pre>

上述代码是屏蔽掉“Revision”，有几个参数可选，根据实际需要修改（<span style="border-style: initial; border-color: initial; font-weight: inherit; font-style: inherit; font-size: 12px; font-family: inherit; vertical-align: baseline; color: #009900; border-width: 0px; padding: 0px; margin: 0px;">绿色</span>部分）：

*   true（默认）或者 -1：保存所有修订版本
*   false 或者 0：不保存任何版本（除了自动保存的版本）
*   大于 0的整数 n：保存 n 个修订版本（+1 只保存自动保存版本），旧的版本将被删除。
你也可以在phpMyAdmin里用以下SQL语法删除wordpress文章修订版本。
<pre class="mysql" style="font-family: monospace;"><span style="color: #990099; font-weight: bold;">DELETE</span> a<span style="color: #000033;">,</span>b<span style="color: #000033;">,</span>c
<span style="color: #990099; font-weight: bold;">FROM</span> wp_posts a
<span style="color: #000099;">LEFT</span> <span style="color: #990099; font-weight: bold;">JOIN</span> wp_term_relationships b <span style="color: #990099; font-weight: bold;">ON</span> <span style="color: #ff00ff;">(</span>a.ID <span style="color: #cc0099;">=</span> b.object_id<span style="color: #ff00ff;">)</span>
<span style="color: #000099;">LEFT</span> <span style="color: #990099; font-weight: bold;">JOIN</span> wp_postmeta c <span style="color: #990099; font-weight: bold;">ON</span> <span style="color: #ff00ff;">(</span>a.ID <span style="color: #cc0099;">=</span> c.post_id<span style="color: #ff00ff;">)</span>
<span style="color: #990099; font-weight: bold;">WHERE</span> a.post_type <span style="color: #cc0099;">=</span> <span style="color: #008000;">'revision'</span></pre>
<pre class="lang:pgsql decode:true">DELETE a,b,c FROM wp_posts a LEFT JOIN wp_term_relationships b ON (a.ID = b.object_id) LEFT JOIN wp_postmeta c ON (a.ID = c.post_id) WHERE a.post_type = 'revision';</pre>
**在执行些语句前请确保你已经备份你的数据库。**

另外有一个插件可以代替此操作。

1.  下载插件 WP Cleaner（[访问插件主页](http://www.jiangmiao.org/blog/138.html)）
2.  将下载的文件解压后上传到博客 wp-content/plugins/ 目录下
3.  在后台的“插件”项中启用
4.  点击“设置”即可看到“WP Cleaner”项
5.  按提示删除修订版。