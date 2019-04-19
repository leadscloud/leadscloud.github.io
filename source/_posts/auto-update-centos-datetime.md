---
title: 自动调整linux系统时间和时区与Internet时间同步
date: 2019-04-09 19:31:21
tags: centos
id: 20190412
categories: 技术
---


简要分为以下3个方法：

## 一、修改时区

```
cp /etc/localtime /etc/localtime.bak
ln -svf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime
```

### 修改为中国的东八区

```
cat /etc/sysconfig/clock
ZONE="Asia/Shanghai"
UTC=false
ARC=false
```
### 与时间服务器同步

ntpdate 0.centos.pool.ntp.org


## 二、配置新的时间

日期设定：
```
date -s 2013/09/26
```

时间设定：
```
# date -s 11:47:06
# date -s "12:00:00 2013-12-06"
# date -s "12:00:00 20131206"
# date -s "2013-12-06 12:00:00"
# date -s "20131206 12:00:00"
```
> `date` 是显示的系统OS时间
> `clock` 是显示Bios的时间

查看硬件时间（BIOS的）：

```
hwclock [-rw]   
  -r   查看现有BIOS时间，默认为－r参数
  -w   将现在的linux系统时间写入BIOS中
  -s   (systohc)将硬件时间调整为和目前的系统时间一样

# hwclock -s 
# hwclock -w
```

 当我们进行完 Linux 时间的校时后，还需要以 `hwclock -w` 来更新 BIOS 的时间，因为每次开机的时候，系统会重新由 BIOS 将时间读出来，所以，*BIOS 才是重要的时间依据*。


```
# hwclock
2013年09月26日 星期四 11时49分10秒 -1.002805 seconds
修改系统时间（date）后，要同步BIOS时钟，强制把系统时间写入CMOS：
# clock -w 
或者
# hwclock -w
```


## 三、实现Internet时间同步（这里可以忽略上面两步）

### 方法1. 开机的时候自动网络校时(首先有自己的时间服务器)： 

```
# cat /etc/rc.d/rc.local 
/usr/sbin/ntpdate -u 192.168.0.2 192.168.0.3 192.168.0.4;/sbin/hwclock -w
```
后面的ip对应的是局域网内需要时间相同同步的主机。



### 方法2. 设定计划任务

```
# yum -y install ntpdate # 安装时间同步命令
# crontab -l(以下方法任选其一)
*/5 * * * * root ntpdate 210.72.145.44;hwclock -w #每隔半个小时与中国国家授时中心服务器同步一次时间
*/5 * * * * root ntpdate asia.pool.ntp.org;hwclock -w
*/5 * * * * root ntpdate 0.centos.pool.ntp.org;hwclock -w
```


## 手动和时间服务器校准时间：

### 1.首先关闭ntpd服务：

```
# service ntpd stop
```
### 2.然后和时间服务器校准：

```
# ntpdate asia.pool.ntp.org
```
### 3.同步BIOS时间：

```
# hwclock -w
```

### 4.校准后然后开启ntpd服务

```
# service ntpd start
```

