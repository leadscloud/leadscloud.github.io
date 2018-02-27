---
title: wordporess-自定义分类显示文章数分页时显示404错误
tags:
  - query_posts
  - wordpress
  - 分页失效
id: 313171
categories:
  - Wordpress学习
date: 2011-07-05 11:56:07
---

这个问题可能描述的不正确，也很难描述，具体表现为在wordpress loop循环中使用query_posts(array('paged'=&gt;get_query_var('paged'),'showposts'=&gt;4)); 导致分页失效，（假如你有12篇文章）如果你使用 par_pagenavi 这样的插件时显示 为3页，但是如果在/page/3时会显示404错误，我们想要的效果应该是一共3页，但是第三页是404，说明wordpress仍然使用每页10个的默认数。无论怎么设置都不行。 目前还没有找到很好的方法，不过有个方法是能解决的，就是在控制面板中的 设置=》阅读 选项下选择 博客页面至多显示 10篇文章改为你想要的数值，这样就行了，小于你想要的数量也行。比如你想每页显示8篇文章，那这个数值只要小于8就行了。

下面是找到的这方面的问题，由于是英文的，看的不是很明白 。如果你能看懂并且理解请告诉我。不胜感激。

[http://wordpress.org/support/topic/error-404-on-pagination-when-changing-posts_per_page-on-query_posts](http://wordpress.org/support/topic/error-404-on-pagination-when-changing-posts_per_page-on-query_posts)

[http://wordpress.org/support/topic/pagination-with-custom-post-type-listing?replies=23#post-1637753](http://wordpress.org/support/topic/pagination-with-custom-post-type-listing?replies=23#post-1637753)