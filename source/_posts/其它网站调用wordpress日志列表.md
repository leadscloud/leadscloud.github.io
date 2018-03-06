---
title: 其它网站调用wordpress日志列表
id: 29001
categories:
  - 个人日志
date: 2010-09-07 11:14:16
tags: wordpress
---

最近工作遇到调用blog里的内容，一般博客都是用wordpress建的，调用的时候会有两种情况，一种博客在同一个站点，一种不在同一个站点，比如二级域名。

同一个站点的话比较简单：

```
<?php
define('WP_USE_THEMES', false);
require('blog/wp-blog-header.php'); //修改博客的路径

query_posts('showposts=20'); //显示文章条数
?>
<?php while (have_posts()): the_post(); ?>
<li><a href="<?php the_permalink(); ?>" target="_blank">
<?php echo mb_strimwidth(strip_tags(apply_filters('the_title', $post->post_title)), 0, 50," "); ?>
</a></li>
<?php endwhile; ?>
```

不在一个站点

不在同一站点的情况下，网上流传的方法是用了一款名为Ecall的插件，这个插件是JS调用的，不利于SEO。
一种方法是使用同一站点的方法，在博客根目录中新建blog_call.php文件，内容同站点中给出的代码，然后在需要调用的站点使用file读取

```
<?php
//$str = file("http://www.blog.com/blog_call.php");
//补充 file测试中有读取不全的现象更正为：
f$str = ile_get_contents("http://www.blog.com/blog_call.php");
echo $str[0];
?>
```

另一种方法是读取博客RSS的方式，下面这段PHP读取RSS的代码在网上流传已久，但是很多朋友不知道，其实它是可以用在WP外部调用上的··

```
<?php
//RSS源地址列表数组
$rssfeed = array("http://feeds2.feedburner.com/redlogpress",
"http://rss.sina.com.cn/news/allnews/sports.xml",
"http://ent.163.com/special/00031K7Q/rss_toutiao.xml");

//设置编码为UTF-8
header('Content-Type:text/html;charset= UTF-8');
for($i=0;$i<sizeof($rssfeed);$i++){//分解开始

$buff = "";
$rss_str="";
//打开rss地址，并读取，读取失败则中止
$fp = fopen($rssfeed[$i],"r") or die("can not open $rssfeed");

while ( !feof($fp) ) {
$buff .= fgets($fp,4096);

}
//关闭文件打开
fclose($fp);
//建立一个 XML 解析器
$parser = xml_parser_create();
//xml_parser_set_option -- 为指定 XML 解析进行选项设置

xml_parser_set_option($parser,XML_OPTION_SKIP_WHITE,1);
//xml_parse_into_struct -- 将 XML 数据解析到数组$values中
xml_parse_into_struct($parser,$buff,$values,$idx);

//xml_parser_free -- 释放指定的 XML 解析器
xml_parser_free($parser);
foreach ($values as $val) {
$tag = $val["tag"];

$type = $val["type"];
$value = $val["value"];
//标签统一转为小写

$tag = strtolower($tag);
if ($tag == "item" &amp;&amp; $type == "open"){

$is_item = 1;
}else if ($tag == "item" &amp;&amp; $type == "close") {

//构造输出字符串
$rss_str .= "<a href='".$link."' target=_blank>".$title."</a><br />";

$is_item = 0;
}
//仅读取item标签中的内容
if($is_item==1){
if ($tag == "title") {$title = $value;}

if ($tag == "link") {$link = $value;}
}
}

//输出结果
echo $rss_str."<br />";
}
?>
```

这两种方法都是要求使用调用的站点支持PHP，如果不支持PHP而支持ASP的话可以用方法一，把读取blog_call.php的PHP代码用ASP重写一遍，但是如果是静态空间就只能装插件来实现了。

同域名下不同Wordpress间文章调用

```
<?php
$loca="/blog";//这里定义你的WP目录
require_once( dirname(__FILE__) . $loca.'/wp-load.php' );//注意这里是wp目录下的wp-load.php
wp();//这样wp的加载就完成了，我们不需要加载模板。
?>
<?php
query_posts('showposts=3'); //就是这里加了一句query_posts，这样也可以实现调用条数的指定。
while (have_posts()) : the_post();
?><div>
<?php the_excerpt();?>
</div>
<?php endwhile; ?>
<!--导航开始-->
<p align="center">
<?php
global $paged, $wp_query;
if($paged>1)
echo '<a href='.str_replace($loca,'',get_previous_posts_page_link()).'>&amp;laquo; Previous Entry</a> ';
if($paged<$wp_query->max_num_pages)
echo ' <a href='.str_replace($loca,'',get_next_posts_page_link()).'>Next Entry &amp;raquo;</a>';
?>
</p>
<!--导航结束-->
```

PS：JS调用可以采用Feed to JS来实现。
