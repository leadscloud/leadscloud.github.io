---
title: bat 命令批量重命名文件
id: 313469
categories:
  - 个人日志
date: 2012-07-14 06:12:09
tags:
---

 
```
@echo off
echo 复制当前html到txt文件夹下，并且重命名为txt格式
ren *.html *.txt
md txt
copy *.html txt*.txt
```

把它保存为bat扩展的文件，放到当前目录下，运行即可。 把当前文件批量重命名为.txt