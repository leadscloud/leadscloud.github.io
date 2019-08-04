---
title: "php-fpm错误: WARNING: [pool www] server reached pm.max_children setting (5), consider raising it"
id: 20190428
categories:
  - 技术
date: 2012-11-24 01:02:06
tags: [php]
---


```
pm.max_children = 30   //设置子进程最大数值
```

```
pm.start_servers = 10   //php-fpm启动起始进程数
pm.min_spare_servers = 10   //php-fpm的最小空闲进程数
pm.max_spare_servers = 24   //php-fpm的最大空闲进程数
pm.max_requests = 500   //所有子进程重启时间
```


