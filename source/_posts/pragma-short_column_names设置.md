---
title: SQLite pragma short_column_names设置
id: 313806
categories:
  - 技术
date: 2014-05-26 05:57:46
tags: [sqlite]
---

```
PRAGMA short_column_names;
PRAGMA short_column_names = 0 | 1;
```

查询或修改 short-column-names 标志。 该标志会影响当 SELECT 查询后面的列表是一个 “表-列名” 或 “*”时 SQLite返回列名的方式。 通常， 如果 SELECT 语句连接两个或多个表， 结果列名将是 <表名/别名><列名>； 而若仅仅对单个表查询时，将是 。 但如果设置了 short-column-names 标志，列名将永远是 ， 而不管是只查询一个表或同时连接多个表。

如果 short-column-names 和 full-column-names 都设置了， 则以 full-column-names 标志为准。

如果在pdo sqlite中使用join查询时，返回的关联数组会带有表名，如table.filed形式的，如果你不想带有表名，使用<span style="color: #000000;">`PRAGMA short_column_names = ON`可强制取消。以下是具体的说明：</span>

http://www.php.net/manual/en/function.sqlite-fetch-array.php

Typecho博客程序就有此问题，它会影响目录页面，导致目录页面无法获取文章，因为sqlite数据库下，返回的关联数组的key，都带有表名，但是在程序引用的时候，是没有带有表名的，会导致很多错误情况。


> [Editor's note: to get short column names there's an undocumented PRAGMA setting. You can exec "PRAGMA short_column_names = ON" to force that behavior.] 
>
>    I noticed that if you use Joins in SQL queries, the field name is messed up with the dot! 
    for example if you have this query: 
    SELECT n.*, m.nickname FROM news AS n, members AS m WHERE n.memberID = m.id; 
>
>    now if you want to print_r the results returned using SQLITE_ASSOC type, the result array is like this : 
    array 
    ( 
      [n.memberID] => 2 
      [n.title] => test title 
      [m.nickname] => NeverMind 
      [tablename.fieldname] => value 
    ) 
>
>    and I think it looks horriable to use the variable ,for example, $news['m.nickname'] I just don't like it! 
>
>    so I've made a small function that will remove the table name (or its Alias) and will return the array after its index is cleaned 
    ```
    <?php 
    function CleanName($array) 
    { 
      foreach ($array as $key => $value) { 
        //if you want to keep the old element with its key remove the following line 
          unset($array[$key]); 

      //now we clean the key from the dot and tablename (alise) and set the new element 
          $key = substr($key, strpos($key, '.')+1); 
          $array[$key] = $value; 
      } 
      return $array; 
    } 
    ?>
    ```