---
title: php获取当前页面的url
tags:
  - PHP
id: 36001
categories:
  - PHP学习
date: 2010-09-11 09:28:55
---

PHP获取当前URL，这是我在网上找到的一段代码。写的很好，自己修改了下。

```
<?php
function get_current_url{
    $current_page_url = 'http';
    if ($_SERVER["HTTPS"] == "on") {
        $current_page_url .= "s";
    }
     $current_page_url .= "://";
     if ($_SERVER["SERVER_PORT"] != "80") {
    $current_page_url .= $_SERVER["SERVER_NAME"].":".$_SERVER["SERVER_PORT"].$_SERVER["REQUEST_URI"];
    } else {
        $current_page_url .= $_SERVER["SERVER_NAME"].$_SERVER["REQUEST_URI"];
    }
    return $current_page_url;
}
?>
```

最后就可以使用 `get_current_url()` 获取当前页面的URL了