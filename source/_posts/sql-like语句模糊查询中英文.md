---
title: sql-like语句模糊查询中英文
tags:
  - PHP
  - SQL
  - 学习笔记
id: 281001
categories:
  - PHP学习
date: 2011-01-11 14:01:20
---

<div>SQL语句实现模糊查询，有些东西老是既不清楚，现在做个笔记吧。</div>
<div>我们可以在where子句中使用like来达到模糊查询的效果；在Where子句中，可以对datetime、char、varchar字段类型的列用Like子句配合通配符选取那些“很像...”的数据记录，以下是可使用的通配符：</div>
<div>% &nbsp; 零或者多个字符</div>
<div>_ &nbsp; &nbsp;单一任何字符（下划线）</div>
<div>\ &nbsp; &nbsp; 特殊字符</div>
<div>[] &nbsp; &nbsp; 在某一范围内的字符，如[0-9]或者[aeth] &nbsp;</div>
<div>[^] &nbsp; &nbsp;不在某范围内的字符，如[^0-9]或者[^aeth]</div>
<div>后两种，需要Oracle 10g以上使用支持like的正则regexp_like。</div>
<div>其中关于条件，Oralce中SQL语句提供了四种匹配模式：</div>
<div>

</div>
<div>1，%：表示任意0个或多个字符。可匹配任意类型和长度的字符，有些情况下若是中文，请使用两个百分号（%%）表示。</div>
<div>比如 SELECT * FROM [user] WHERE u_name LIKE '%三%'</div>
<div>将会把u_name为“张三”，“张猫三”、“三脚猫”，“唐三藏”等等有“三”的记录全找出来。</div>
<div>另外，如果需要找出u_name中既有“三”又有“猫”的记录，请使用and条件</div>
<div>SELECT * FROM [user] WHERE u_name LIKE '%三%' AND u_name LIKE '%猫%'</div>
<div>

</div>
<div>若使用 SELECT * FROM [user] WHERE u_name LIKE '%三%猫%'</div>
<div>虽然能搜索出“三脚猫”，但不能搜索出符合条件的“张猫三”。</div>
<div>

</div>
<div>2，_： 表示任意单个字符。匹配单个任意字符，它常用来限制表达式的字符长度语句：</div>
<div>比如 SELECT * FROM [user] WHERE u_name LIKE '_三_'</div>
<div>只找出“唐三藏”这样u_name为三个字且中间一个字是“三”的；</div>
<div>再比如 SELECT * FROM [user] WHERE u_name LIKE '三__';</div>
<div>只找出“三脚猫”这样name为三个字且第一个字是“三”的；</div>
<div>

</div>
<div>

</div>
<div>3，[ ]：表示括号内所列字符中的一个（类似正则表达式）。指定一个字符、字符串或范围，要求所匹配对象为它们中的任一个。</div>
<div>比如 SELECT * FROM [user] WHERE u_name LIKE '[张李王]三'</div>
<div>将找出“张三”、“李三”、“王三”（而不是“张李王三”）；</div>
<div>如 [ ] 内有一系列字符（01234、abcde之类的）则可略写为“0-4”、“a-e”</div>
<div>SELECT * FROM [user] WHERE u_name LIKE '老[1-9]'</div>
<div>将找出“老1”、“老2”、……、“老9”；</div>
<div>

</div>
<div>4，[^ ] ：表示不在括号所列之内的单个字符。其取值和 [] 相同，但它要求所匹配对象为指定字符以外的任一个字符。</div>
<div>比如SQL Server: SELECT * FROM [user] WHERE u_name LIKE '[^张李王]三' &nbsp; &nbsp;将找出不姓“张”、“李”、“王”的“赵三”、“孙三”等；</div>
<div>Oracle 10g以上的用法为：</div>
<div>select*fromtablewhereregexp_like(name,'[张李王]三');</div>
<div>SELECT * FROM [user] WHERE u_name LIKE '老[^1-4]';</div>
<div>将排除“老1”到“老4”，寻找“老5”、“老6”、……</div>
<div>注：oracle like 不支持正则，你可以使用支持like的正则regexp_like</div>
<div>

</div>
<div>5，查询内容包含通配符时</div>
<div>由于通配符的缘故，导致我们查询特殊字符“%”、“_”、“[”的语句无法正常实现，而把特殊字符用“[ ]”括起便可正常查询。据此我们写出以下函数：</div>
<div>

</div>

```
function sqlencode(str)
str=replace(str,"[","[[]") '此句一定要在最前
str=replace(str,"_","[_]")
str=replace(str,"%","[%]")
sqlencode=str
end function
```