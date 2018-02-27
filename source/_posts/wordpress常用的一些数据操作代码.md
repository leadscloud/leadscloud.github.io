---
title: wordpress常用的一些数据操作代码
tags:
  - wordpress
id: 313221
categories:
  - Wordpress学习
date: 2011-09-26 05:03:36
---

**1、替换posts中的字符**

UPDATE wp_posts SET post_content = replace(post_content, '原字符', '替换后的字符');

**2、禁止修订版本 **

编辑 wp-config.php 文件（博客根目录），在下面代码之前：

define('ABSPATH', dirname(__FILE__).'/');

添加以下代码：

define('WP_POST_REVISIONS', false);

**3、删除文章修订记录**

DELETE FROM wp_posts WHERE post_type=‘revision‘;

DELETE FROM wp_postmeta WHERE post_id IN (SELECT id FROM wp_posts WHERE post_type = ‘revision‘);

DELETE FROM wp_term_relationships WHERE object_id IN (SELECT id FROM wp_posts WHERE post_type=‘revision‘); DELETE FROM wp_posts WHERE post_type=‘revision‘;