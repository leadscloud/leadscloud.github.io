---
title: Ubuntu Linux下使用chnroutes让vpn自动翻墙
id: 314014
categories:
  - 技术
date: 2016-07-09 11:35:26
tags: ubuntu
---

> **更新：**
> 下面的操作已经不行了，这个项目被废弃了，使用其它翻墙吧。

项目地址：https://github.com/jimmyxu/chnroutes

利用来自APNIC的数据生成路由命令脚本，让VPN客户端在连接时自动执行。通过这些路由脚本，可以让用户在使用VPN作为默认网关时，不使用VPN访问中国国内IP，从而减轻VPN负担，并提高访问国内网站的速度。

这个和自动翻墙还是有区别的，只能根据IP提高国内网站访问速度，我设置成功后，发现好多国内网站访问仍然慢。

PPTP

Linux

执行`python chnroutes.py -p linux`，这将生成ip-pre-up和ip-down两个文件；
将ip-pre-up移入/etc/ppp/，ip-down移入`/etc/ppp/ip-down.d/`；
重新连接VPN，观察测试。

如果发现没有改变，那很可能是权限的问题了，我也遇到了，添加一下权限

```
chmod  -R 777 /etc/ppp/ip-pre-up
chmod  -R 777 /etc/ppp/ip-down.d/ip-down
```

## 测试

可以使用tracerout qq.com 查看路由情况 。

```
ip route get 4.2.2.1
```

## 单独添加路由

```
ip route add 209.99.17.0/24 via 192.168.1.1 metric 5
```
