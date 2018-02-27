---
title: sublimepythonide-编码规范提示问题
tags:
  - python
id: 313784
categories:
  - 个人日志
date: 2014-04-02 03:22:35
---

sublime text 3 安装好SublimePythonIDE后，提示代码有很多问题，经查原来是代码不符合pep8规范。

1)
一行列数 : PEP 8 规定为 79 列，这个太苛刻了，如果要拼接url一般都会超。
一个函数 : 不要超过 30 行代码, 即可显示在一个屏幕类，可以不使用垂直游标即可看到整个函数。
一个类 : 不要超过 200 行代码，不要有超过 10 个方法。
一个模块 : 不要超过 500 行。

2)不要在一句import中多个库
不推荐
import os, sys

推荐
import os
import sys

　　在整理自己代码的时候记录的问题。

错误记录：W292 no newline at end of file
处理：打个回车有新的一空行即可（新行不要有空格）。

错误记录：E302 expected 2 blank lines, found 1
处理：上面只有一行空白，但是需要两个空白行

错误记录：E231 missing whitespace after ‘,’
翻译：“，”后要有空格
举例：
错误 print(“%s %s %s %s %s %s” % (A,B,D,E,K,L))
正确 print(“%s %s %s %s %s %s” % (A, B, D, E, K, L))

错误记录：E225 missing whitespace around operator
翻译：
举例：
错误 print(“%s %s %s %s %s %s”%(A, B, D, E, K, L))
正确 rint(“%s %s %s %s %s %s”% (A, B, D, E, K, L))

错误记录：E225 missing whitespace around operator
举例：
错误 f=open(“D:\\test.txt”, “ab”)
正确 f = open(“D:\\test.txt”, “ab”)

参考：

http://www.elias.cn/Python/PythonStyleGuide