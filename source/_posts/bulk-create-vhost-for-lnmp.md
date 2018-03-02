---
title: lnmp shell脚本快速创建vhost,并自动添加ftp mysql wordpress
date: 2015-11-02 18:22:04
tags: shell
id: 313990
categories: 技术
---

写了一个shell脚本，可以快速的添加域名并同时创建好ftp账号和mysql账号，如果需要安装 wordpress在参数中选择即可。

脚本地址： https://github.com/sbmzhcn/sbmzhcn.github.io/blob/master/soft/bulk_vhost.sh

## **安装方式**

```
wget -O bulk_vhost.sh http://sbmzhcn.github.io/soft/bulk_vhost.sh && chmod u+x bulk_vhost.sh
```


## 示例说明

`/root/bulk_vhost.sh -h` 会显示详细说明

```
  /root/bulk_vhost.sh -d "love4026.org sbmzhcn.com" -fm # 快速添加域名 ftp mysql
  /root/bulk_vhost.sh -d love4026.org -fm -a wordpress  # 快速添加域名 ftp mysql 并安装wordpress
  /root/bulk_vhost.sh -d love4026.org -fm -a wordpress -r wordpress     
  /root/bulk_vhost.sh -d love4026.org -fml            
```
