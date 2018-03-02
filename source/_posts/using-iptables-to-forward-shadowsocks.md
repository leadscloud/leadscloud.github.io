---
title: 利用iptables实现shadowsocks中继/转发
date: 2018-01-23 14:07:07
tags: [shadowsocks, iptables]
id: 315070
categories: 技术
---

中继的原因是因为一些ip在我们本地的电脑上是无法连通的，但在阿里云等其它VPS上面就可以访问，这样我们可能通过中继来继续使用我们的shadowsocks.

## 开启系统的转发功能

 `vi /etc/sysctl.conf`

将 `net.ipv4.ip_forward=0` ，修改成 `net.ipv4.ip_forward=1` 。

编辑后使用以下命令让配置马上生效

`sysctl -p`

## iptables的命令

    ```
    iptables -t nat -A PREROUTING -p tcp --dport [端口号] -j DNAT --to-destination [目标IP]
    iptables -t nat -A PREROUTING -p udp --dport [端口号] -j DNAT --to-destination [目标IP]
    iptables -t nat -A POSTROUTING -p tcp -d [目标IP] --dport [端口号] -j SNAT --to-source [本地服务器公网IP]
    iptables -t nat -A POSTROUTING -p udp -d [目标IP] --dport [端口号] -j SNAT --to-source [本地服务器公网IP]
    ```

## 重启iptables使配置生效

```
service iptables save
service iptables restart
```

## 直接修改iptables文件

上面添加过后，未来再修改ip的话，可以直接修改文件`/etc/sysconfig/iptables`

```
vi /etc/sysconfig/iptables
```

`:%s/1.1.1.1/2.2.2.2` 可以替换ip地址

 然后 

 ```
 service iptables restart
 ```
