---
title: 几个常用的操作wordpress的mysql语句
tags:
  - MySQL
  - wordpress
id: 313514
categories:
  - Wordpress学习
date: 2012-11-09 08:34:38
---


## 删除wordpress修订版本

```sql
DELETE a,b,c FROM wp_posts a LEFT JOIN wp_term_relationships b ON (a.ID = b.object_id) LEFT JOIN wp_postmeta c ON (a.ID = c.post_id) WHERE a.post_type = 'revision';
```

## 删除特定post_meta的文章，根据post_meta删除文章

```sql
delete a,b from wp_posts a left join wp_postmeta b on (a.ID = b.post_id) where b.meta_value = 'GwebSearch'
```

## 根据post_meta更新wp_posts中的内容

```sql
update wp_posts set post_content="" where ID in (select post_id from wp_postmeta WHERE meta_key = 'post_type' and meta_value = 'GwebSearch')
```