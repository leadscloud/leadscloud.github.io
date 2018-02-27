---
title: firefox扩展的自动更新功能
tags:
  - firefox扩展
id: 313824
categories:
  - 前端设计
date: 2014-06-07 02:01:36
---

在本地开发的插件如果没有上传到firefox的在线扩展里面，你需要设置一个自动更新，如果有更新，安装你插件的用户便可以自动更新。
http://www.borngeek.com/firefox/automatic-firefox-extension-updates/ 这篇文章，详细介绍了如何设置自动更新。

**关于调试：**

在about:config里，将extensions.logging值设为true，并关闭firefox
在命令行下运行firefox -console，这样启动时，控制台会有extension的log输出。
从命令行界面可以看到一些提示信息，根据这些信息，你可以更好的知道自己的插件为什么不能更新。