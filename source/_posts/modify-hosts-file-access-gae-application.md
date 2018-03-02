---
title: 修改hosts文件访问GAE应用appspot.com
tags:
  - GAE
id: 313111
categories:
  - 前端设计
date: 2011-03-02 10:52:35
---

![](http://love4026.files.wordpress.com/2011/03/modify-hosts-file.jpg)

GAE完全无法访问(appspot.com被屏蔽),如果是在本地可以用修改hosts文件的方法访问此应用。不过在win7下修改hosts文件很难修改成功，可以用上图方式运行记事本，修改hosts文件。 hots文件在C:\Windows\System32\drivers\etc\hosts 在上面加上
  > 203.208.39.104&#160;&#160;&#160;&#160; seoskys.appspot.com  

等待一段时间打开[http://seoskys.appspot.com](http://seoskys.appspot.com) 就OK了！