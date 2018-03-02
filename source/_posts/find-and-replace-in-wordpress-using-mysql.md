---
title: 通过Mysql批量替换WordPress的关键字
tags:
  - MySQL
  - replace
  - wordpress
id: 313338
categories:
  - Wordpress学习
date: 2012-04-24 04:38:16
---

wordpress有时需要批量替换某个关键词。通过插件可以实现，但也可以通过mysql快速替换，不仅可以替换文章内容，还包括文章标题等。

### 方法:

1\. 使用PHPMYADMIN进入数据库管理, 搜索errorkeywords, 你就可以看到哪些表里面包含了这个字段.
2\. 点击SQL, 执行SQL语句:

`UPDATE ‘表名’ SET ‘字段’ = REPLACE(’字段’,’待替换内容’,’替换值’);`

### 示例:

```
update wp_posts set post_content=replace(post_content,'errorkeywords','keywords')
```

WordPress数据库里面几个重点替换的表和字段:

表wp_posts里面的post_content (文章内容)
表wp_posts里面的pinged (ping内容)
表wp_posts里面的guid (WordPress默认链接结构)
表wp_comments里面的comment_author_url (留言作者URL地址 )

当然, 上面几个是最重要的.还有其它字段, 你根据搜索结果自己查找.