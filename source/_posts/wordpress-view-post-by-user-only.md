---
title: wordpress-view-post-by-user-only
id: 313348
categories:
  - Wordpress学习
date: 2012-04-26 14:07:30
tags:
---

 
我们增加一个自定义字段：user_only，如果这个值不为零，这这篇日志或者页面是只能给注册用户浏览，然后通过 the_content 来控制内容显示，这样就能简单的并且灵活设置具体到哪篇文章或者页面是只能注册用户浏览。详细代码如下：

<pre class="lang:php decode:true " >&lt;?php
/*
Plugin Name: User only
Plugin URI: http://fairyfish.net/m/post-for-user-only/
Description:通过给 user_only 这个自定义字段设置为 true 来设置当前文章仅限于会员浏览。
Author: Denis
Version: 1.0
Author URI: http://wpjam.com
*/
add_filter('the_content', 'post_user_only');
function post_user_only($text){
    global $post;

    $user_only = get_post_meta($post-&gt;ID, 'user_only', true);
    if($user_only){
        global $user_ID;
        if(!$user_ID){
            $redirect = get_permalink($post-&gt;ID);
            $text = '该内容仅限于会员浏览，请&lt;a href="'.wp_login_url($redirect).'"&gt;登录&lt;/a&gt;！';
        }
    }
    return $text;
}
?&gt;
</pre> 

把上面带复制成一个PHP文件上传到插件目录，激活即可。

原文件地址：http://fairyfish.net/m/post-for-user-only/