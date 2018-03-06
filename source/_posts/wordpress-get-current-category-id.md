---
title: Wordpress获取当前目录的ID
id: 313376
categories:
  - Wordpress学习
date: 2012-05-23 06:24:34
tags: wordpress
---

 
```
function get_current_category_id() {
 	$current_category = single_cat_title('', false); //获得当前分类目录名称
 	return get_cat_ID($current_category); //获得当前分类目录ID
}
```

上面用到的两个wordpress函数的介绍：

http://codex.wordpress.org/Function_Reference/get_cat_ID
http://codex.wordpress.org/Function_Reference/single_cat_title