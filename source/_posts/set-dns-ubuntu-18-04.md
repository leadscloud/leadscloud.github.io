---
title: Ubuntu 18.04下修改DNS
date: 2020-09-04 11:42:15
tags: 
  - Linux
  - Ubuntu
id: 20200904
categories: 技术
---

通过修改文件 `/etc/resolv.conf` 就可以修改dns

```
# Use Google's public DNS servers.
nameserver 8.8.4.4
nameserver 8.8.8.8
```

但是以上方法只是临时有效，服务器重启后就恢复原样了，还是变成下面这样

```
nameserver 127.0.0.53
search Home
```

怎么样才可以永久修改呢？

1. 安装 resolvconf .

`sudo apt install resolvconf`

2. 编辑 `/etc/resolvconf/resolv.conf.d/head` 添加以下内容:

```
# Make edits to /etc/resolvconf/resolv.conf.d/head.
nameserver 8.8.4.4
nameserver 8.8.8.8
Restart the resolvconf service.
```

3. 重启服务

`sudo service resolvconf restart`



## Ubuntu 18.04 下面 修改ip及dns使用netplan

### 显示ip信息

`ip addr show`

### 显示路由信息

`ip route show`

### 编辑网络信息

`vi /etc/netplan/*.yaml`

```
network:
  ethernets:
      eno1:
          addresses: [192.168.1.13/24]
          gateway4: 192.168.1.1
          dhcp4: true
          optional: true
          nameservers:
              addresses: [8.8.8.8,8.8.4.4]
  version: 2
```

### 应用配置:

`netplan apply`