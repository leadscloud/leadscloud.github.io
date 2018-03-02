---
title: javascript 获取网址的顶级域名
tags:
  - JavaScript
id: 313821
categories:
  - 前端设计
date: 2014-06-04 03:23:21
---

 
```
function getHostname(url){
	var a = document.createElement('a');
	a.href = url;
	return a.hostname;
}

function GetTopDomain(host){
  if(host.indexOf("http") &gt; -1)
  	host = getHostname(host);
  var index = host.lastIndexOf('.'), last = 4;
  while (index &gt; 0 &amp;&amp; index &gt;= last - 4){
    last = index;
    index = host.lastIndexOf('.', last - 1);
  }
  var domain = host.substring(index + 1);    
  return domain.length &gt; 6 ? domain : host;
}
```

引方法只能针对部分域名，对于 xxxx.com.cn  xxxx.co.in xxxxx.com xxx.in 都是可以识别的，但如果域名长度小于tld， 比如 xxx.com.cn 这样的就无法判断出来。