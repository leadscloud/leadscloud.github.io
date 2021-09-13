---
title: move lnmp mysql datadir to new disk on centos
date: 2021-09-05 10:59:38
tags: 
  - mysql
  - lnmp
  - centos
id: 20210905
categories: 技术
---


lnmp centos下mysql迁移数据目录到新硬盘


## centos 硬盘分区

电脑中已经挂载了一个1T的新硬盘，最初安装centos系统时原先的nfts硬盘 `sdb`。

`lsblk`

```
NAME                                          MAJ:MIN RM   SIZE RO TYPE  MOUNTPOINT
sda                                             8:0    0 223.6G  0 disk  
├─sda1                                          8:1    0   200M  0 part  /boot/efi
├─sda2                                          8:2    0     1G  0 part  /boot
└─sda3                                          8:3    0 222.4G  0 part  
  └─luks-61af80c4-4d0a-4312-aae1-b66abd729eb5 253:0    0 222.4G  0 crypt 
    ├─centos-root                             253:1    0   185G  0 lvm   /
    ├─centos-swap                             253:2    0   7.8G  0 lvm   [SWAP]
    └─centos-home                             253:3    0  29.6G  0 lvm   /home
sdb                                             8:16   0 931.5G  0 disk  
├─sdb1                                          8:17   0   529M  0 part  
├─sdb2                                          8:18   0   100M  0 part  
├─sdb3                                          8:19   0    16M  0 part  
├─sdb4                                          8:20   0 130.1G  0 part  
├─sdb5                                          8:21   0 214.9G  0 part  
├─sdb6                                          8:22   0   293G  0 part  
└─sdb7                                          8:23   0   293G  0 part  
sdc                                             8:32   1  14.6G  0 disk  
└─sdc1                                          8:33   1  14.6G  0 part 
```

`fdisk -l`

```
Disk /dev/sdb: 1000.2 GB, 1000204886016 bytes, 1953525168 sectors
Units = sectors of 1 * 512 = 512 bytes
Sector size (logical/physical): 512 bytes / 4096 bytes
I/O size (minimum/optimal): 4096 bytes / 4096 bytes
Disk label type: dos
Disk identifier: 0x56c6d4e4

   Device Boot      Start         End      Blocks   Id  System
/dev/sdb1               1  4294967295  2147483647+  ee  GPT
Partition 1 does not start on physical sector boundary.
```

### 创建分区

需要重新创建分区，把原先的分区重新分配

```
# parted /dev/sdb
(parted) mktable gpt
(parted) mkpart data 1024KiB -1
(parted print)
```

parted之后的参数是设备名。mkpart命令的三个参数分别是分区名（随便起），开始地址，结束地址-1表示至结尾，前面留出的空间可能是用于存放分区信息，不留的时候会有警告。print查看分区结果


### 格式化分区

mkfs.ext4 /dev/sdb1

或

mkfs.xfs /dev/sdb1


### 设置开机挂载

mkdir /data
mount /dev/sdb1 /data

修改/etc/fstab文件，在末尾加上一行：

/dev/sdb1               /data                   xfs    defaults        0 0


## 迁移mysql数据库

先关闭mysql

`/etc/init.d/mariadb stop`

创建文件夹

`mkdir /data/mysql/`

复制`datadir`到新文件夹中

cp -a /usr/local/mariadb/var /data/mysql/

备份原数据目录 

`mv var var.bak`

添加软链接

`ln -s /data/mysql/var/ /usr/local/mariadb/`

重启mysql即可

`/etc/init.d/mariadb start`