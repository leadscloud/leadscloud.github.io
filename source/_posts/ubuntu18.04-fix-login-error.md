---
title: 修复Ubuntu18.04 Cloud-init导致卡在login界面
tags:
  - ubuntu
id: 20200723
categories:
  - Linux
date: 2020-07-24 10:31:00
---


开机后会一直卡在这个界面

```
Cloud-init v. 18.4-0ubuntu1~18.04.1 running 'modules:config' at Fri, 24 Jul 2020 
```

## single模式进入ubuntu

1. 开机时长按<kbd>Shift</kbd>键

2. 出现grub选项，选中ubuntu

3. 长按<kbd>e</kbd>键

4. 找到类似下面的代码
```
linux /boot/vmlinuz-3.2.0-24-generic root=UUID=bc6f8146-1523-46a6-8b\
6a-64b819ccf2b7 ro  quiet splash
initrd /boot/initrd.img-3.2.0-24-generic
```
5. 在 `ro  quiet splash` 这后面，加上 ` single`

6. 按 <kbd>Ctrl</kbd>+<kbd>x</kbd>或<kbd>F0</kbd> 进入系统

参考： https://askubuntu.com/questions/132965/how-do-i-boot-into-single-user-mode-from-grub


## Ubuntu的网卡设置


sudo vim /etc/netplan/50-cloud-init.yam

```
# This file is generated from information provided by
# the datasource.  Changes to it will not persist across an instance.
# To disable cloud-init's network configuration capabilities, write a file
# /etc/cloud/cloud.cfg.d/99-disable-network-config.cfg with the following:
# network: {config: disabled}
network:
    ethernets:
        enp3s0:
            dhcp4: true
    version: 2
```

enp3s0 如果错了，改下，我的是因为硬盘换了另一台电脑，有变化，导致ip获取失败。

`ifconfig -a` 可以显示所有网卡。

### 设置静态ip

```
network:
    ethernets:
        enp3s0:                  # 配置的网卡名称
            dhcp4: no           # 关闭dhcp4
            dhcp6: no           # 关闭dhcp6
            addresses: [192.168.0.120/24]       # 设置本机IP地址及掩码
            gateway4: 192.168.0.1               # 设置网关
            nameservers:
                    addresses: [114.114.114.114, 8.8.8.8]       # 设置DNS
    version: 2
```

配置完成后，保存并退出，执行 `netplan apply` 命令可以让配置直接生效

`ifconfig -a` 可以看下是否成功


### 重新启停以太网卡命令：

ifconfig enp3s0 down

ifconfig enp3s0 up


参考： https://www.cnblogs.com/opsprobe/p/9979234.html