---
title: wordpress搜索结果修饰
id: 313359
categories:
  - Wordpress学习
date: 2012-05-07 10:19:49
tags:
---

在wp-includes/query.php的2180行，添加 $q['s'] = str_replace(array( '+', '%20', '-' ),  array( ' ', ' ' , ' '), $q['s']); 