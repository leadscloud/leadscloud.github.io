---
title: shadowsocks锐速加速优化
tags:
  - shadowsocks
id: 313960
categories:
  - 技术
date: 2015-08-23 12:28:25
---

### 内核参数优化

第一步，增加系统文件描述符的最大限数

编辑文件 limits.conf
```
vi /etc/security/limits.conf
```
增加以下两行

```
* soft nofile 51200
* hard nofile 51200
```

启动shadowsocks服务器之前，设置以下参数

`ulimit -n 51200`

第二步，调整内核参数

修改配置文件 /etc/sysctl.conf

```
fs.file-max=65535

net.core.rmem_max = 67108864
net.core.wmem_max = 67108864
net.core.netdev_max_backlog = 250000
net.core.somaxconn = 4096

net.ipv4.tcp_syncookies = 1
net.ipv4.tcp_tw_reuse = 1
net.ipv4.tcp_tw_recycle = 0
net.ipv4.tcp_fin_timeout = 30
net.ipv4.tcp_keepalive_time = 1200
net.ipv4.ip_local_port_range = 10000 65000
net.ipv4.tcp_max_syn_backlog = 8192
net.ipv4.tcp_max_tw_buckets = 5000
net.ipv4.tcp_fastopen = 3
net.ipv4.tcp_rmem = 4096 87380 67108864
net.ipv4.tcp_wmem = 4096 65536 67108864
net.ipv4.tcp_mtu_probing = 1
#net.ipv4.tcp_congestion_control = hybla
```
修改后执行 `sysctl -p` 使配置生效

### 锐速

锐速是一款非常不错的TCP底层加速软件，可以非常方便快速地完成服务器网络的优化，配合 ShadowSocks 效果奇佳。目前锐速官方也出了永久免费版本，适用带宽20M、3000加速连接，个人使用是足够了。如果需要，先要在锐速官网注册个账户。

然后确定自己的内核是否在锐速的支持列表里，如果不在，请先更换内核，如果不确定，请使用 手动安装。

确定自己的内核版本在支持列表里，就可以使用以下命令快速安装了。

```
wget http://my.serverspeeder.com/d/ls/serverSpeederInstaller.tar.gz
tar xzvf serverSpeederInstaller.tar.gz
bash serverSpeederInstaller.sh
```

输入在官网注册的账号密码进行安装，参数设置直接回车默认即可，
最后两项输入 y 开机自动启动锐速，y 立刻启动锐速。之后可以通过lsmod查看是否有appex模块在运行。

到这里还没结束，我们还要修改锐速的3个参数，`vi /serverspeeder/etc/config`

```
rsc="1" #RSC网卡驱动模式
advinacc="1" #流量方向加速
maxmode="1" #最大传输模式
```

digitalocean vps的网卡支持rsc和gso高级算法，所以可以开启rsc="1"，gso="1"。

重新启动锐速

```
service serverSpeeder restart
```