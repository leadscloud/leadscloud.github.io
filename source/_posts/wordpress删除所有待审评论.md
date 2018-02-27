---
title: wordpress删除所有待审评论
tags:
  - wordpress
id: 313294
categories:
  - Wordpress学习
date: 2012-04-11 12:11:44
---

插件可以删除待审核(pending)的评论。

http://wordpress.org/extend/plugins/delete-pending-comments/

删除所有评论可以用以下方法，当然，前提你得[备份你的wordpress](http://codex.wordpress.org/WordPress_Backups)，以防万一。

DELETE FROM wp_comments WHERE comment_approved = 0