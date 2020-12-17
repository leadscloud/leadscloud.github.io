---
title: DigitalOcean的浮动IP使用
tags:
  - DigitalOcean
  - Ubuntu
id: 20201120
categories:
  - 技术
date: 2020-11-20 17:59:00
---


DigitalOcean浮动IP是可以分配给您的某个Droplet的可公开访问的静态IP地址.

由于工作需要，需要给VPS绑定一个新的IP，并且要求请求特定IP时，使用新IP的接口。

### 使用方法：

```
# 查看下你的浮云IP是设置成功
curl http://169.254.169.254/metadata/v1/floating_ip/ipv4/active

# 查看浮云IP对应的网关
curl http://169.254.169.254/metadata/v1/interfaces/public/0/anchor_ipv4/gateway
```

得到网关地址为 `10.13.0.1`

在路由中添加新路由

```
ip route add 10.0.1.3 via 10.13.0.1 dev eth0
```

这样访问10.0.1.3时，就会使用新ip的网关口请求了。


### 参考文章：

- https://www.digitalocean.com/community/questions/send-outbound-traffic-over-floating-ip
- https://www.digitalocean.com/docs/networking/floating-ips/