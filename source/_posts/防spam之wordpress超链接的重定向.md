---
title: 防spam之wordpress超链接的重定向
id: 313374
categories:
  - HTML/CSS
date: 2012-05-22 10:55:22
tags:
---

下面的代码是在你的wordpress评论里，把所有的链接都改变为链接形式为：`http://yourdomain.com/?r=http://www.userdomain.com` 的形式。然后在robots.txt里加上 Disallow: /?r=*

```
//评论链接跳转
add_filter('get_comment_author_link', 'add_redirect_comment_link', 1);
add_filter('comment_text', 'add_redirect_comment_link', 99);
function add_redirect_comment_link($text = ''){
    $text=str_replace('href="', 'href="'.get_option('home').'/?r=', $text);
    $text=str_replace("href='", "href='".get_option('home')."/?r=", $text);
    return $text;
}
add_action('init', 'redirect_comment_link');
function redirect_comment_link(){
    $redirect = $_GET['r'];
    $re_home=get_option('home')."/";
    if($redirect){
        if(strpos($_SERVER['HTTP_REFERER'],get_option('home')) !== false){
            header("Location: $redirect");
            exit;
        }
        else {
            header("Location: $home");
            exit;
        }
    }
}
```


当然在网页里的其它代码里也能使用此方法。