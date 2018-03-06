---
title: wordpress面包屑导航完美解决方案
tags:
  - wordpress
id: 313131
categories:
  - Wordpress学习
date: 2011-03-31 06:38:10
---

##### 方法一：直接在相关页面添加代码

把以下代码直接添加到你想出现面包屑导航的位置，比如 header.php 里面，也可以放在 single.php 页面的导航标题上面，你有可能需要添加的页面可能有：archive.php、archives.php、links.php、page.php。

```
当前位置：[<?php bloginfo('name'); ?>](<?php bloginfo() »
<?php
if( is_single() ){
$categorys = get_the_category();
$category = $categorys[0];
echo( get_category_parents($category->term_id,true,' » ') );
the_title();
} elseif ( is_page() ){
the_title();
} elseif ( is_category() ){
single_cat_title();
} elseif ( is_tag() ){
single_tag_title();
} elseif ( is_day() ){
the_time('Y年Fj日');
} elseif ( is_month() ){
the_time('Y年F');
} elseif ( is_year() ){
the_time('Y年');
} elseif ( is_search() ){
echo $s.' 的搜索结果';
}
?>
```

##### 方法二：通过 functions.php 调用

首先把以下代码添加到主题的 functions.php 文件中

```
function dimox_breadcrumbs() {

  $delimiter = '»';
  $name = 'Home'; //text for the 'Home' link
  $currentBefore = '<span>';
  $currentAfter = '</span>';

  if ( !is_home() &amp;&amp; !is_front_page() || is_paged() ) {

    echo '<div id="crumbs">';

    global $post;
    $home = get_bloginfo('url');
    echo '' . $name . ' ' . $delimiter . ' ';

    if ( is_category() ) {
      global $wp_query;
      $cat_obj = $wp_query->get_queried_object();
      $thisCat = $cat_obj->term_id;
      $thisCat = get_category($thisCat);
      $parentCat = get_category($thisCat->parent);
      if ($thisCat->parent != 0) echo(get_category_parents($parentCat, TRUE, ' ' . $delimiter . ' '));
      echo $currentBefore . 'Archive by category '';
      single_cat_title();
      echo ''' . $currentAfter;

    } elseif ( is_day() ) {
      echo '' . get_the_time('Y') . ' ' . $delimiter . ' ';
      echo '' . get_the_time('F') . ' ' . $delimiter . ' ';
      echo $currentBefore . get_the_time('d') . $currentAfter;

    } elseif ( is_month() ) {
      echo '' . get_the_time('Y') . ' ' . $delimiter . ' ';
      echo $currentBefore . get_the_time('F') . $currentAfter;

    } elseif ( is_year() ) {
      echo $currentBefore . get_the_time('Y') . $currentAfter;

    } elseif ( is_single() ) {
      $cat = get_the_category(); $cat = $cat[0];
      echo get_category_parents($cat, TRUE, ' ' . $delimiter . ' ');
      echo $currentBefore;
      the_title();
      echo $currentAfter;

    } elseif ( is_page() &amp;&amp; !$post->post_parent ) {
      echo $currentBefore;
      the_title();
      echo $currentAfter;

    } elseif ( is_page() &amp;&amp; $post->post_parent ) {
      $parent_id  = $post->post_parent;
      $breadcrumbs = array();
      while ($parent_id) {
        $page = get_page($parent_id);
        $breadcrumbs[] = '' . get_the_title($page->ID) . '';
        $parent_id  = $page->post_parent;
      }
      $breadcrumbs = array_reverse($breadcrumbs);
      foreach ($breadcrumbs as $crumb) echo $crumb . ' ' . $delimiter . ' ';
      echo $currentBefore;
      the_title();
      echo $currentAfter;

    } elseif ( is_search() ) {
      echo $currentBefore . 'Search results for '' . get_search_query() . ''' . $currentAfter;

    } elseif ( is_tag() ) {
      echo $currentBefore . 'Posts tagged '';
      single_tag_title();
      echo ''' . $currentAfter;

    } elseif ( is_author() ) {
       global $author;
      $userdata = get_userdata($author);
      echo $currentBefore . 'Articles posted by ' . $userdata->display_name . $currentAfter;

    } elseif ( is_404() ) {
      echo $currentBefore . 'Error 404' . $currentAfter;
    }

    if ( get_query_var('paged') ) {
      if ( is_category() || is_day() || is_month() || is_year() || is_search() || is_tag() || is_author() ) echo ' (';
      echo __('Page') . ' ' . get_query_var('paged');
      if ( is_category() || is_day() || is_month() || is_year() || is_search() || is_tag() || is_author() ) echo ')';
    }

    echo '</div>';

  }
}
```

最后在适当的地方（如方法一中提到的几个文件）添加以下代码调用


```
<?php if (function_exists('dimox_breadcrumbs')) dimox_breadcrumbs(); ?> 
```
