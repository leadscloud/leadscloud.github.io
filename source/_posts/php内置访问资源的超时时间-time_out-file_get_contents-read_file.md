---
title: php内置访问资源的超时时间-time_out-file_get_contents-read_file
id: 313405
categories:
  - 转载
date: 2012-06-16 13:37:47
tags:
---

提问 
我循环用file_get_contents抓取一堆url，但总是会在不到第100个URL的时候停下，提示我：“Warning: file_get_contents(URL) [function.file-get-

contents]: failed to open stream: HTTP request failed! HTTP/1.0 500 Read timed out
in D:\website\extra.php on line 65”

我在程序的开始已经有set_time_limit(0);了啊，那上面的错误会是因为什么呢？

回答
set_time_limit只是设置你的PHP程序的超时时间，而不是file_get_contents函数读取URL的超时时间。
从警告信息来看，是被抓取的网页出现了服务器500错误，可能是他的程序出现超时了。

如果想改变file_get_contents的超时时间，可以用resource $context的timeout参数：
$opts = array(
'http'=>array(
    'method'=>"GET",
    'timeout'=>60,
   )
);

$context = stream_context_create($opts);

$html =file_get_contents('http://www.example.com', false, $context);
fpassthru($fp);

参考资料：http://cn.php.net/manual/en/context.http.php

这样readfile函数的超时时间就设置成了10秒，如果你够细心的话，还会发现数组中还有一些其他的配置，第一维中的http是指定使用的网络协议，二维中的method批的是http的请求方法get,post,head等，timeout就是超时时间了。我想很多人会使用php内置的file_get_contents函数来下载网页，因为这个函数使用起来够简单。很多人也都很简单的使用它，只要传递一个链接它就可以自动的发送get请求，并将网页内容下载下来。如果比较复杂的情况，比如使用POST请求，使用代理下载，定义User-Agent等等，这时很多人就会认为这个函数做不了这样的事情，就会选择其他方式，如curl，来实现。实际上，这些事情file_get_contents也可以做到，

就是通过它的第三个参数，设置http请求的context。

支持的设置和使用方式见官方说明：http://www.php.net/manual/en/context.http.php

附：目前我知道的支持context参数的php内置函数有file_get_contents,file_put_contents,readfile,file,fopen,copy（估计这一类的函数都支持吧，待确认）。

function Post($url, $post = null)
{
$context = array();

if (is_array($post))
{
ksort($post);

$context['http'] = array
(

'timeout'=>60,
'method' => 'POST',
'content' => http_build_query($post, '', '&'),
);
}

return file_get_contents($url, false, stream_context_create($context));
}

$data = array
(
'name' => 'test',
'email' => 'test@gmail.com',
'submit' => 'submit',
);

echo Post('http://www.yifu.info', $data);

OK , 上面函数完美了，既解决了超时控制又解决了Post传值。再配合康盛的改良版RC4加密解密算法，做一个安全性很高的webservice就简单多了。

原文：http://blog.csdn.net/adparking/article/details/7231849