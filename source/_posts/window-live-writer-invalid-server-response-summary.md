---
title: Window Live Writer 服务器响应无效原因汇总
tags:
  - Window Live Writer
id: 313080
categories:
  - Wordpress学习
date: 2011-02-19 02:44:26
---

[Window Live Writer](http://explore.live.com/windows-live-writer?os=other "Window Live Writer官方下载地址")（简称 WLW）是微软发布的一款免费客户端博文写作、发布软件。 对于wordpress那是非常好的离线发布软件，只需要在wordpress后台的 设置 - 撰写 - 远程发布 XML-RPC 选上。

但有时发布时会出现一些问题，WLW不能正常工作的原因有很多，在网上看到别人写的教程解决了我的问题，今天在这儿重新整理下，以供参考：
  > WLW发布日志错误提示：      
> 尝试连接到您的日志时出错：服务器响应无效 - 从日志服务器接收的对 blogger.getUsersBlogs 方法的响应无效: Invalid response document returned from XmlRpc server 必须先纠正此错误才能继续操作。  

### 1.wordpress编码原因UTF-8

wp-includes文件夹下, xml-rpc返回的格式不正确，缺三个字节，修正这个问题：    
用一个文本编辑工具打开class.ixr.php，查找：     
$length = strlen($xml);     
替换为：     
$length = strlen($xml)+3; 

### 2.插件原因

与某个已经安装启用的 WordPress 插件冲突，停用新启用的插件尝试能否解决；

### 3.PHP版本原因

解决办法：打开 xmlrpc.php 文件(在wordpress的主目录下)，添加如下代码到文件的顶部，&lt;?php 之后：
  > $HTTP_RAW_POST_DATA = file_get_contents(“php://input”);  

###    
4.&#160; .htaccess 规则错误

解决办法：将如下代码复制到 .htaccess 文件： （如若无此文件，请联系空间商是否禁止了xmlrpc.php的访问或自行建立此文件试试）
  > &lt;Files xmlrpc.php&gt;    
> &#160;&#160;&#160; SecFilterInheritance Off     
> &lt;/Files&gt;  

###    
5.wordpress上传路径错误

这种情况一般出现在为wordpress更换了主机后出现，请登录wordpress后台，选项，杂项，填写正确的wordpress上传路径。默认情况下，WordPress 的上传目录是 wordpress/wp-content/uploads/

### 6.空间服务商启用服务导致

启用过滤系统或权限设置，请联系空间商！    
wordpress除了以上几种原因会导致使用WLW服务器响应无效外，在WP后台，你可能还有机会遇到以下这种错误：
  > An Unexpected HTTP Error occurred during the API request  

如果是这种情况，请在wp-includes目录下，找到http.php文件，大概210行的位置：
  > function request( $url, $args = array() ) {    
> &#160;&#160;&#160;&#160;&#160;&#160;&#160; global $wp_version;     
> &#160;&#160;&#160;&#160;&#160;&#160;&#160; $defaults = array(     
> &#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160; 'method' =&gt; 'GET',     
> &#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160; 'timeout' =&gt; apply_filters( 'http_request_timeout', 5),     
> &#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160; 'redirection' =&gt; apply_filters( 'http_request_redirection_count', 5),     
> &#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160; 'httpversion' =&gt; apply_filters( 'http_request_version', '1.0'),     
> &#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160; 'user-agent' =&gt; apply_filters( 'http_headers_useragent', 'WordPress/' . $wp_version ),     
> &#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160; 'blocking' =&gt; true,     
> &#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160; 'headers' =&gt; array(), 'body' =&gt; null     
> &#160;&#160;&#160;&#160;&#160;&#160;&#160; );  

将其中的：
  > 'timeout' =&gt; apply_filters( 'http_request_timeout', 5),  

更改为：
  > 'timeout' =&gt; apply_filters( 'http_request_timeout', 30),  

请注意：在wordpress 3.0版本后，相应的http.php文件已更改为：class-http.php