---
title: 如何改变Chrome的User Agent
tags:
  - Chrome
  - Google
  - Google 浏览器
  - User-Agent
id: 313082
categories:
  - 前端设计
date: 2011-02-19 12:15:15
---

很多网站都通过User-Agent来判断浏览器类型，如果是3G手机，显示手机页面内容，如果是普通浏览器，显示普通网页内容,我的博客就是这样。 

![](http://love4026.files.wordpress.com/2011/02/google-used-as-mobile-phone.png)    
谷歌Chrome浏览器，可以很方便地用来当3G手机模拟器。在Windows的【开始】-->【运行】中输入以下命令，启动谷歌浏览器，即可模拟相应手机的浏览器去访问3G手机网页，注意要先把之前打开的chrome关闭：     
谷歌Android：
  

    chrome.exe --user-agent="Mozilla/5.0 (Linux; U; Android 2.2; en-us; Nexus One Build/FRF91) AppleWebKit/533.1 (KHTML, like Gecko) Version/4.0 Mobile Safari/533.1"

  

苹果iPhone：


    chrome.exe --user-agent="Mozilla/5.0 (iPad; U; CPU OS 3_2_2 like Mac OS X; en-us) AppleWebKit/531.21.10 (KHTML, like Gecko) Version/4.0.4 Mobile/7B500 Safari/531.21.10"


诺基亚N97：

<pre>chrome.exe --user-agent="Mozilla/5.0 (SymbianOS/9.4; Series60/5.0 NokiaN97-1/20.0.019; Profile/MIDP-2.1 Configuration/CLDC-1.1) AppleWebKit/525 (KHTML, like Gecko) BrowserNG/7.1.18124"</pre>

试一试，分别用Android、iPhone、诺基亚访问[http://www.google.com.hk/](http://www.google.com.hk/)、[http://3g.qq.com](http://3g.qq.com)、[http://t.sina.cn](http://t.sina.cn)这些3G手机网页，看看有什么不同。 

更多款手机的User-Agent：[http://www.zytrax.com/tech/web/mobile_ids.html](http://www.zytrax.com/tech/web/mobile_ids.html) 

如果想切换回普通浏览器模式，关掉所有Chrome浏览器，重开即可。