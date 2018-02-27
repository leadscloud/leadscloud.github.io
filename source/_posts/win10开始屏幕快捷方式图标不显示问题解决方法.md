---
title: win10开始屏幕快捷方式图标不显示问题解决方法
id: 313992
categories:
  - 个人日志
date: 2016-01-17 20:07:33
tags:
---

win10的开始屏幕快捷方式图标不显示，或者显示为一个白框，是因为安装了一个软件IconPackager，卸载后产生的问题，以下是解决办法：

1、打开开始菜单，输入**Regedit**， 或者直接windows键+R弹出运行命令，输入**Regedit**

2、在注册表编辑器中找到**HKEY_CLASSES_ROOT\exefile\shellex **删除它下面的名为**IconHandler**的二级目录或者文件

以上解决办法来自这个网页：

[http://forums.stardock.com/390822/page/1](http://forums.stardock.com/390822/page/1 "http://forums.stardock.com/390822/page/1")