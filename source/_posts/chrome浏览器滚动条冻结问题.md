---
title: chrome浏览器滚动条冻结问题
id: 314048
categories:
  - 个人日志
date: 2017-04-27 17:09:09
tags: chrome
---

chrome浏览器更新后，发现有些页面，滚动条不动了，鼠标中键滑轮不管用了，后来查询资料发现其他人也遇到这情况，应该是chrome的一个bug。

主要是因为chrome默认开启了平滑滚动功能， 如果内容是异步产生的，比如ajax就会有这个问题。

在浏览器中 打开 `chrome://flags/#smooth-scrolling` 即可关闭该功能，重启浏览器后这个问题就可以解决。