---
title: macOS 下使用命令修改IP 子网掩码 网关 DNS
date: 2017-06-21 13:48:29
id: 315003
tags: macOS
---


## 使用 networksetup 修改

### 修改ip地址、子网掩码、网关

```
sudo networksetup -setmanual "Ethernet" 116.193.49.157 255.255.255.224 116.193.49.129 
```

### 设置 DNS 服务器

```
sudo networksetup -setdnsservers "Ethernet" 202.96.209.5 202.96.209.133
```

### 设置mac地址

```
sudo ifconfig en0 ether 10********C8 
```

上面是一个一次性的改法, 重启后会自动变为本机原本的mac地址。

## 使用 ifconfig 修改

### 设置 IP 和 子网掩码

```
ifconfig eth0 192.168.1.6 netmask 255.255.255.0 
```

### 设置网关

```
route add default gw 192.168.1.1
```

### 设置 DNS

```
vi /etc/resolv.conf

nameserver 114.114.114.114
nameserver 114.114.115.115
```

