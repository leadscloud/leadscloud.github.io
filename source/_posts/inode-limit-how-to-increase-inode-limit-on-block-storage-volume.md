---
title: Inode limit, how to increase inode limit on block storage volume?
tags:
  - Linux
  - Inode
id: 20201217
categories:
  - Linux
date: 2020-12-17 13:15:00
---

`df -h` 查看磁盘还有空间，但无法创建任何文件，提示磁盘空间已满(`No space left on device`)。
```
[root@centos-fra ~]# df -h
Filesystem      Size  Used Avail Use% Mounted on
devtmpfs        1.9G     0  1.9G   0% /dev
tmpfs           1.9G     0  1.9G   0% /dev/shm
tmpfs           1.9G   17M  1.9G   1% /run
tmpfs           1.9G     0  1.9G   0% /sys/fs/cgroup
/dev/vda1        80G   73G  7.1G  92% /
tmpfs           379M     0  379M   0% /run/user/0
/dev/sda        100G   26G   69G  28% /mnt/volume_fra1_01
```

最终发现下面的解决办法。

用 `df -i` 查看下索引节点(inode),会发现已经用满(IUsed=100%)。
这会导致无法创建文件和目录，并且提示 `No space left on device`。

```
[root@centos-fra ~]# df -i
Filesystem       Inodes   IUsed    IFree IUse% Mounted on
devtmpfs         479052     312   478740    1% /dev
tmpfs            485037       1   485036    1% /dev/shm
tmpfs            485037     464   484573    1% /run
tmpfs            485037      16   485021    1% /sys/fs/cgroup
/dev/vda1      22168424 6377093 15791331   29% /
tmpfs            485037       1   485036    1% /run/user/0
/dev/sda        3276800 3276800        0  100% /mnt/volume_fra1_01

```

### 原因

cache目录中存在数量非常多的小字节缓存文件，占用的Block不多，但是占用了大量的inode。

linux里每个文件都有些元信息像创建时间，文件大小，文件名啊之类的，这些元信息就存在inode了。这样如果小文件过多的话，可能磁盘没满但inode空间已分配完，这时磁盘就跟满了一样无法写入.

### 解决办法

挂载之前 使用下面命令增大inode数量，如果已经挂载，需要先卸载。
但执行下面的命令后，磁盘相当于重新格式化，之前的数据就消失了。

```
mkfs.ext4 -N 20000000 /dev/path/to/volume
```

还有一个解决办法：

用软连接将空闲分区/home/wwwroot/中的newcache目录连接到/mnt/volume_fra1_01/.cache，使用/home分区的inode来缓解/mnt分区inode不足的问题：


### 参考文章
- https://www.digitalocean.com/community/questions/inode-limit-how-to-increase-inode-limit-on-block-storage-volume