---
title: 使用php将大文件导入到数据库中
id: 313613
categories:
  - 转载
date: 2013-06-22 10:55:14
tags:
---

将 170w行的txt文件.按行把数据导入到数据库中.


```php
header ( "Content-type: text/html;charset=utf-8" ); 
set_time_limit(0); 
include('Database.class.php'); 
$db = new Database('127.0.0.1', 'root', 'root', 'test'); //数据库 
$fp = fopen('171w.txt', 'r'); //文件 
$i=1; //开始行数 
$array = array();  //用来存放从XXX-XXX行的数据的数组 
//回调函数 
function callback($now) { 
    global $db, $array, $i, $fp; 
    if(empty($array)) {             //为了节省资源..我们只生成一次数组 
        while (!feof($fp)) { 
           if($i == $now) {         //循环到需要读取的行数时 
               for($j=$i;$j<=$i+999;$j++) {         //读取下面的1000行并存储到数组中 
                   $array[$j] = stream_get_line($fp, 1000000, "\n"); 
               } 
               break; 
           } 
           stream_get_line($fp, 1000000, "\n");    //实践证明 stream_get_line 比 fgets 快很多.. 
           $i++; 
        } 
    } 
    $db->insert("INSERT INTO test(name) VALUES('{$array[$now]}')");  //插入到数据库中 
} 
include('SkiyoProcess.class.php'); 
$sp = new SkiyoProcess(2, 1000, 171000);  //间隔为2秒  每次插入1000条数据 一共171000行数据 
$sp->process('callback');
```

原文:http://blogread.cn/it/article/1825?f=wb