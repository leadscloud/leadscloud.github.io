---
title: wordpress 任务丢失 定时发布文章 修复
id: 313389
categories:
  - Wordpress学习
date: 2012-05-31 08:13:56
tags: wordpress
---

## 修改 `/wp-includes/cron.php`

找到timeout = 0.01 ， 把0.01改为5或更大值。默认是0.01秒，如果超进就出现了任务丢失现象。

## 通过Mysql, 进入phpmyadmin

```sql
update wp_posts set post_status = 'publish' where post_date < now();
```

## 通过插件

WP Missed Schedule