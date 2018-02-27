---
title: 【php】json处理中文乱码的问题
tags:
  - JSON
  - PHP
id: 313560
categories:
  - PHP学习
date: 2013-01-27 05:18:28
---

在使用Ajax与后台php页面进行交互的时候都碰到过中文乱码的问题。JSON作为一种轻量级的数据交换格式，备受亲睐，但是用PHP作为后台交互，容易出现中文乱码的问题。JSON和js一样，对于客户端的字符都是以UTF8的形式进行处理的，也就是说，使用JSON作为提交和接收的数据格式时字符都采用UTF8编码处理，当我们的页面编码和数据库编码不是采用UTF8的时候，就极容易出现中文乱码的问题。解决办法自然是在用js或者PHP处理JSON数据的时候都采用UTF8的形式。
json_encode只支持UTF8编码的字符，否则，中文乱码或者空值就出现了。
Step1
保证在使用JSON处理的时候字符是以UTF8编码的。具体我们可以把数据库编码和页面编码都改为UTF8。当然喜欢用gbk编码的话，可以在进行JSON处理前，把字符转为UTF8形式。在PHP中有如下方法：
&lt;?php
$data="JSON中文";
$newData=iconv("GB2312","UTF-8//IGNORE",$data);
echo $newData;
//ignore的意思是忽略转换时的错误，如果没有ignore参数，所有该字符后面的字符都不会被保存。
//或是("GB2312","UTF-8",$data);
?&gt;
Step2
后台PHP页面（页面编码为UTF-8或者已经把字符转为UTF-8）使用json_encode将PHP中的array数组转为JSON字符串。例如：
&lt;?php
$testJSON=array('name'=&gt;'中文字符串','value'=&gt;'test');
echo json_encode($testJSON);
?&gt;
查看输出结果为：
{“name”:”\u4e2d\u6587\u5b57\u7b26\u4e32″,”value”:”test”}
可见即使用UTF8编码的字符，使用json_encode也出现了中文乱码。解决办法是在使用json_encode之前把字符用函数urlencode()处理一下，然后再json_encode，输出结果的时候在用函数urldecode()转回来。具体如下：
&lt;?php
$testJSON=array('name'=&gt;'中文字符串','value'=&gt;'test');
//echo json_encode($testJSON);
foreach ( $testJSON as $key =&gt; $value ) {
$testJSON[$key] = urlencode ( $value );
}
echo urldecode ( json_encode ( $testJSON ) );
?&gt;
查看输出结果为：
{“name”:”中文字符串”,”value”:”test”}
到此，成功地输出了中文字符。随意使用json_encode吧。这样子在PHP后台输出的JSON字符串在前台javascript中Ajax接收后eval出来也不会出现中文乱码，因为js在处理JSON格式数据是以UTF8的形式进行的，与PHP类似，故接收PHP页面的JSON字符串不会出现问题。