---
title: Linux下根据日期删除旧的文件
tags:
  - linux
id: 20201027
categories:
  - 技术
date: 2020-10-27 13:09:12
---

## 删除30天前的文件

你可以使用find命令搜索X天前的文件，前根据需要删除它

先列出 `/home/wwwroot/db` 下面30天前的文件

```
find /home/wwwroot/db -type f -mtime +30
```

检查列出的文件列表，如果没有问题，使用下面的命令删除它

```
find /opt/backup -type f -mtime +30 -exec rm -f {} \; 
```

## 根据文件后缀删除文件

你也可以增加过滤条件，只删除某一类型的文件。

比如删除`.log`后缀的30天前的日志文件

```
find /var/log -name "*.log" -type f -mtime +30 
```

同样，检查下列出的日志是否正确，然后再使用下面命令删除它

```
find /var/log -name "*.log" -type f -mtime +30 -exec rm -f {} \; 
```