---
title: wordpress-获得分类下的文章列表
tags:
  - wordpress
id: 313132
categories:
  - Wordpress学习
date: 2011-04-03 12:03:03
---

最近在用wordpress做一个网站，需要获得某个分类下的文章列表，下面是我网站上的代码。具体关于 WP_Query的用法可以参考：[http://codex.wordpress.org/Function_Reference/WP_Query](http://codex.wordpress.org/Function_Reference/WP_Query)

<pre class="lang:php decode:true " >&lt;?php 
$recent = new WP_Query();
$recent-&gt;query('category_name='.$cat_name.'&amp;showposts=20'); 
while($recent-&gt;have_posts()) : 
	$recent-&gt;the_post();
	the_title(); 
endwhile;
?&gt;</pre> 