---
title: wordpress显示相邻连续多篇文章
tags:
  - wordpress
  - wordpress相邻文章
id: 313175
categories:
  - Wordpress学习
date: 2011-07-14 08:05:26
---

功能： 显示当前文章前三篇文章与后三篇文章，显示数量可自定义。 两个参数，`$previous` 为布尔值，默认显示前三篇，false的话显示后三篇，`$count`是显示的文章数量。

```
<?php
function my_get_adjacent_post($previous = true,$count = 3){
	global $post, $wpdb;
	if ( empty( $post ) )
		return null;
	$current_post_date = $post->post_date;
	$op = $previous ? '<' : '>';
	$order = $previous ? 'DESC' : 'ASC';
	$sql = $wpdb->prepare("SELECT ID,post_date,post_title,guid FROM $wpdb->posts WHERE post_status = 'publish' AND post_type = 'post' AND post_date $op %s ORDER BY post_date $order LIMIT $count", $current_post_date);
	$result = $wpdb->get_results($sql);
	if ( null === $result )
		return NULL;
	else {
?>
<?php foreach($result as $res) {?>
		<li><a href="<?php echo get_permalink($res->ID); ?>"><?php echo get_the_title($res->ID); ?></a></li>
<?php } ?>
<?php
	}//return $result;
}
?>
```

用法:

在single.php 内容结尾处添加以下代码。

```
<h2>Related Posts</h2>
<ul>
    <?php if ( function_exists('my_get_adjacent_post') ) { my_get_adjacent_post();} ?>
    <?php if ( function_exists('my_get_adjacent_post') ) { my_get_adjacent_post(false);} ?>
</ul>
```

这样便能显示当前文章前三篇与后三篇的相邻文章。