---
title: linux-centos-6-4-网络问题-device-eth0-does-not-seem-to-be-present
id: 313636
categories:
  - 个人日志
date: 2013-09-05 06:09:39
tags:
---

Hyper-V复制的centos虚拟机 使用 ifconfig 命令看不到eth0，重启网卡 service network restart 会报错：Bringing up interface eth0:  Device eth0 does not seem to be present,delaying initialization. [FAILED]

### 解决办法：

首先，打开/etc/udev/rules.d/70-persistent-net.rules内容如下面例子所示：

记录下，eth1网卡的mac地址00:0c:29:50:bd:17

接下来，打开/etc/sysconfig/network-scripts/ifcfg-eth0

# vi /etc/sysconfig/network-scripts/ifcfg-eth0

将 DEVICE="eth0"  改成  DEVICE="eth1"  ,
将 HWADDR="00:0c:29:8f:89:97" 改成上面的mac地址  HWADDR="00:0c:29:50:bd:17"

最后，重启网络

# service network restart
或者

# /etc/init.d/network restart

正常了。

接下来，打开/etc/sysconfig/network-scripts/ifcfg-eth0

# vi /etc/sysconfig/network-scripts/ifcfg-eth0

将 DEVICE="eth0"  改成  DEVICE="eth1"  ,
将 HWADDR="00:0c:29:8f:89:97" 改成上面的mac地址  HWADDR="00:0c:29:50:bd:17"

最后，重启网络

# service network restart
或者

# /etc/init.d/network restart

正常了。