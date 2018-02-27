---
title: wordpress搜索结果url重定向
id: 313420
categories:
  - Wordpress学习
date: 2012-06-13 09:25:20
tags:
---

 
<pre class="lang:php decode:true " >
<?php
if($_GET['s']!=''){ 
$change = array('+',' '); 
$kwds = strtolower( $_GET['s'] );
$kwds = trim($kwds);
$searchredirect = get_settings('home') . '/search/' . str_replace($change, '-' ,$kwds). '/'; 
header("HTTP/1.1 301 Moved Permanently");
header( "Location: $searchredirect" );
}
?></pre> 