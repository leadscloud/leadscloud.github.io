---
title: pragma-short_column_names设置
id: 313806
categories:
  - 个人日志
date: 2014-05-26 05:57:46
tags:
---

PRAGMA short_column_names;
PRAGMA short_column_names = 0 | 1;

查询或修改 short-column-names 标志。 该标志会影响当 SELECT 查询后面的列表是一个 “表-列名” 或 “*”时 SQLite返回列名的方式。 通常， 如果 SELECT 语句连接两个或多个表， 结果列名将是 &lt;表名/别名&gt;&lt;列名&gt;； 而若仅仅对单个表查询时，将是 。 但如果设置了 short-column-names 标志，列名将永远是 ， 而不管是只查询一个表或同时连接多个表。

如果 short-column-names 和 full-column-names 都设置了， 则以 full-column-names 标志为准。

如果在pdo sqlite中使用join查询时，返回的关联数组会带有表名，如table.filed形式的，如果你不想带有表名，使用<span style="color: #000000;">PRAGMA short_column_names = ON可强制取消。以下是具体的说明：</span>

http://www.php.net/manual/en/function.sqlite-fetch-array.php

Typecho博客程序就有此问题，它会影响目录页面，导致目录页面无法获取文章，因为sqlite数据库下，返回的关联数组的key，都带有表名，但是在程序引用的时候，是没有带有表名的，会导致很多错误情况。

<span style="color: #000000;">[Editor's note: to get short column names there's an undocumented PRAGMA setting. You can exec "PRAGMA short_column_names = ON" to force that behavior.] </span>

<span style="color: #000000;">I noticed that if you use Joins in SQL queries, the field name is messed up with the dot! </span>
<span style="color: #000000;">for example if you have this query: </span>
<span style="color: #000000;">SELECT n.*, m.nickname FROM news AS n, members AS m WHERE n.memberID = m.id; </span>

<span style="color: #000000;">now if you want to print_r the results returned using SQLITE_ASSOC type, the result array is like this : </span>
<span style="color: #000000;">array </span>
<span style="color: #000000;">( </span>
<span style="color: #000000;">  [n.memberID] =&gt; 2 </span>
<span style="color: #000000;">  [n.title] =&gt; test title </span>
<span style="color: #000000;">  [m.nickname] =&gt; NeverMind </span>
<span style="color: #000000;">  [tablename.fieldname] =&gt; value </span>
<span style="color: #000000;">) </span>

<span style="color: #000000;">and I think it looks horriable to use the variable ,for example, $news['m.nickname'] I just don't like it! </span>

<span style="color: #000000;">so I've made a small function that will remove the table name (or its Alias) and will return the array after its index is cleaned </span>
<span class="default" style="color: #336699;">&lt;?php
</span><span class="keyword" style="color: #669933;">function </span><span class="default" style="color: #336699;">CleanName</span><span class="keyword" style="color: #669933;">(</span><span class="default" style="color: #336699;">$array</span><span class="keyword" style="color: #669933;">)
{
foreach (</span><span class="default" style="color: #336699;">$array </span><span class="keyword" style="color: #669933;">as </span><span class="default" style="color: #336699;">$key </span><span class="keyword" style="color: #669933;">=&gt; </span><span class="default" style="color: #336699;">$value</span><span class="keyword" style="color: #669933;">) {
</span><span class="comment" style="color: #4f5b93;">//if you want to keep the old element with its key remove the following line
</span><span class="keyword" style="color: #669933;">unset(</span><span class="default" style="color: #336699;">$array</span><span class="keyword" style="color: #669933;">[</span><span class="default" style="color: #336699;">$key</span><span class="keyword" style="color: #669933;">]);

</span><span class="comment" style="color: #4f5b93;">//now we clean the key from the dot and tablename (alise) and set the new element
</span><span class="default" style="color: #336699;">$key </span><span class="keyword" style="color: #669933;">= </span><span class="default" style="color: #336699;">substr</span><span class="keyword" style="color: #669933;">(</span><span class="default" style="color: #336699;">$key</span><span class="keyword" style="color: #669933;">, </span><span class="default" style="color: #336699;">strpos</span><span class="keyword" style="color: #669933;">(</span><span class="default" style="color: #336699;">$key</span><span class="keyword" style="color: #669933;">, </span><span class="string" style="color: #cc3333;">'.'</span><span class="keyword" style="color: #669933;">)+</span><span class="default" style="color: #336699;">1</span><span class="keyword" style="color: #669933;">);
</span><span class="default" style="color: #336699;">$array</span><span class="keyword" style="color: #669933;">[</span><span class="default" style="color: #336699;">$key</span><span class="keyword" style="color: #669933;">] = </span><span class="default" style="color: #336699;">$value</span><span class="keyword" style="color: #669933;">;
}
return </span><span class="default" style="color: #336699;">$array</span><span class="keyword" style="color: #669933;">;
}
</span><span class="default" style="color: #336699;">?&gt;</span>

&nbsp;