---
title: wordpress优化头部-去掉版权等信息
tags:
  - wordpress
id: 197001
categories:
  - HTML/CSS
date: 2010-11-21 12:48:51
---

wordpress默认情况下，头部会出现很多我们平时用不到的html代码,比如


```
<link rel="alternate" type="application/rss+xml" title="RSS 2.0 - all posts" href="http://blog.rockscrusher.com/feed" />
<link rel="alternate" type="application/rss+xml" title="RSS 2.0 - all comments" href="http://blog.rockscrusher.com/comments/feed" />
<link rel="pingback" href="http://blog.rockscrusher.com/xmlrpc.php" />
<link rel="EditURI" type="application/rsd+xml" title="RSD" href="http://blog.rockscrusher.com/xmlrpc.php?rsd" />
<link rel="wlwmanifest" type="application/wlwmanifest+xml" href="http://blog.rockscrusher.com/wp-includes/wlwmanifest.xml" />
<link rel='index' title='SBM Stone Crusher Machine|Grinding Mill' href='http://blog.rockscrusher.com' />
<meta name="generator" content="WordPress 3.0.1" />
```


网上有方法说主题目录下的 functions.php里增加以下代码.

```
function wpbeginner_remove_version() {
return &rdquo;;
}
add_filter('the_generator', 'wpbeginner_remove_version');//wordpress的版本号
remove_action('wp_head', 'feed_links', 2);// 包含文章和评论的feed。
remove_action('wp_head', 'index_rel_link');//当前文章的索引。
remove_action('wp_head', 'wlwmanifest_link'); // 外部编辑器如windows live writer必须。
remove_action('wp_head', 'feed_links_extra', 3);// 额外的feed，例如category, tag页。
remove_action('wp_head', 'start_post_rel_link', 10, 0);// 开始篇
remove_action('wp_head', 'parent_post_rel_link', 10, 0);// 父篇
remove_action('wp_head', 'adjacent_posts_rel_link', 10, 0); // 上、下篇.
```

自己试验了下，只有部分可行，有些代码还是去不掉，但还有另个一个更直接的方法。就是在wodpress目录下修改wp-includes目录下的default-filters.php，大概在180多行


```
//add_action( 'wp_head',             'feed_links',                    2     );
//add_action( 'wp_head',             'feed_links_extra',              3     );
//add_action( 'wp_head',             'rsd_link'                             );
//add_action( 'wp_head',             'wlwmanifest_link'                     );
//add_action( 'wp_head',             'index_rel_link'                       );
//add_action( 'wp_head',             'parent_post_rel_link',          10, 0 );
//add_action( 'wp_head',             'start_post_rel_link',           10, 0 );
//add_action( 'wp_head',             'adjacent_posts_rel_link_wp_head', 10, 0 );
add_action( 'wp_head',             'locale_stylesheet'                    );
add_action( 'publish_future_post', 'check_and_publish_future_post', 10, 1 );
add_action( 'wp_head',             'noindex',                       1     );
add_action( 'wp_head',             'wp_print_styles',               8     );
add_action( 'wp_head',             'wp_print_head_scripts',         9     );
//add_action( 'wp_head',             'wp_generator'                         );
//add_action( 'wp_head',             'rel_canonical'                        );
add_action( 'wp_footer',           'wp_print_footer_scripts'              );
//add_action( 'wp_head',             'wp_shortlink_wp_head',          10, 0 );
add_action( 'template_redirect',   'wp_shortlink_header',           11, 0 );
```

不需要的直接//注释掉就行了。一般看下就应该明白是什么意思的。这样可以保证html头部不再有其它的代码了。

前几天Wordpress 3.0.1版本可以用上面的第一种方法，这样仅改下主题就行了。在主题根目录下的function.php中加入如下代码

```
function wpbeginner_remove_version() {
return &rdquo;;
}
add_filter('the_generator', 'wpbeginner_remove_version');//wordpress的版本号
remove_action('wp_head', 'feed_links', 2);// 包含文章和评论的feed。
remove_action('wp_head', 'index_rel_link');//当前文章的索引。
remove_action('wp_head', 'wlwmanifest_link'); // 外部编辑器
remove_action('wp_head', 'feed_links_extra', 3);// 额外的feed，例如category, tag页
remove_action('wp_head', 'start_post_rel_link', 10, 0);// 开始篇
remove_action('wp_head', 'parent_post_rel_link', 10, 0);// 父篇
remove_action('wp_head', 'adjacent_posts_rel_link', 10, 0); // 上、下篇.
remove_action( 'wp_head','rsd_link');//ML-RPC
remove_action( 'wp_head','adjacent_posts_rel_link_wp_head', 10, 0 );//rel="pre"
remove_action( 'wp_head', 'wp_shortlink_wp_head', 10, 0 );//rel="shortlink"
remove_action( 'wp_head', 'rel_canonical' );
```