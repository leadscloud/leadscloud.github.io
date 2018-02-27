---
title: 修改代码让-google-analytics-新版提供页面速度报告
tags:
  - Google Analytics
id: 313145
categories:
  - Google SEO
date: 2011-05-06 13:46:16
---

![GA](http://www.guao.hk/wp-content/uploads/2011/05/galt_blog-550x338.png)

Google Analytics v5 新版首次增加了新功能：页面速度报告。了解了不同人群访问网页的载入速度才能有针对性的进行优化，进入新版后，在左侧的Content里的Site Speed即可看到统计，包括：

&nbsp;

*   哪个页面读取的最慢
*   不同地区的人们访问速度有何区别
*   在不同浏览器里的读取速度如何
*   哪个来源的读取速度最快

要得到数据报告需要修改你的GA分析代码。 [具体修改方法见这里](http://www.google.com/support/analyticshelp/bin/answer.py?hl=en&amp;answer=1205784&amp;topic=1120718&amp;utm_source=gablog&amp;utm_medium=blog&amp;utm_campaign=newga-blog&amp;utm_content=sitespeed)，目前只有英文的介绍。修改之后类似这样：

<pre style="font-size: medium;">&lt;script type="text/javascript"&gt;
 var _gaq = _gaq || [];
 _gaq.push(['_setAccount', 'UA-XXXXX-X']);
 _gaq.push(['_trackPageview']);
 **_gaq.push(['_trackPageLoadTime']);**

 (function() {
   var ga = document.createElement('script'); ga.type = 'text/javascript'; ga.async = true;
   ga.src = ('https:' == document.location.protocol ? 'https://ssl' : 'http://www') + '.google-analytics.com/ga.js';
   var s = document.getElementsByTagName('script')[0]; s.parentNode.insertBefore(ga, s);
 })();
&lt;/script&gt;

修改之前的代码可能是这样的：</pre>
<pre style="font-size: medium;">&lt;script type="text/javascript"&gt;
var gaJsHost = (("https:" == document.location.protocol) ? "https://ssl." : "http://www.");
document.write(unescape("%3Cscript src='" + gaJsHost + "google-analytics.com/ga.js' type='text/javascript'%3E%3C/script%3E"));
&lt;/script&gt;

&lt;script type="text/javascript"&gt;
try{
 var pageTracker = _gat._getTracker("UA-xxxxxx-x");
 pageTracker._trackPageview();
 **pageTracker._trackPageLoadTime();**
} catch(err) {}
&lt;/script&gt;</pre>