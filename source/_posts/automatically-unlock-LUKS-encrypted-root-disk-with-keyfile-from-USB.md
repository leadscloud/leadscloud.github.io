---
title: CentOS7从U盘自动解锁加密的根目录磁盘
id: 20210930
categories:
  - Linux
date: 2021-09-30 14:06:00
tags: 
  - centos
  - linux
---

安装centos7时，有一个提示，是否加密磁盘，选择此选项后，每次启动系统都会要求你输入密码，这样可以保证磁盘如果没有密码，放到其它电脑上也无法使用。对数据会更加安全。

但每次手动输入密码还是比较麻烦，最好是把密钥放到U盘里，插上后就可以自动解锁，不需要输入人工输入密码。

我搜索了下，网上关于此的教程都无法完美解决，没有非常完善的文档，下面两个教程是最靠谱的，我也是根据这些教程，在虚拟机上测试成功后才找到具体的原因。

https://forums.centos.org/viewtopic.php?t=53452
https://community.spiceworks.com/how_to/168683-cenos-7-encrypt-my-data-and-use-usb-key-for-unlock


以下为完整的操作步骤：

### 创建一个带有keyfile的usb盘

使用fat格式即可，这样在windows电脑上也能使用

先通过lsblk blkid命令，查看系统上的硬盘情况。

```
[root@localhost ~]# lsblk
NAME                                          MAJ:MIN RM  SIZE RO TYPE  MOUNTPOINT
sda                                             8:0    0 11.9G  0 disk
├─sda1                                          8:1    0  200M  0 part  /boot/efi
├─sda2                                          8:2    0    1G  0 part  /boot
└─sda3                                          8:3    0 10.7G  0 part
  └─luks-535d89c0-9b67-4138-a0f3-0879ef2a6cc6 253:0    0 10.7G  0 crypt
    ├─centos-root                             253:1    0  9.5G  0 lvm   /
    └─centos-swap                             253:2    0  1.2G  0 lvm   [SWAP]
sdb                                             8:16   1  954M  0 disk
└─sdb1                                          8:17   1  954M  0 part  /media
sr0                                            11:0    1 1024M  0 rom
```

```
[root@localhost ~]# blkid
/dev/sda1: SEC_TYPE="msdos" UUID="FC4C-1E93" TYPE="vfat" PARTLABEL="EFI System Partition" PARTUUID="dbf79d09-cbbf-4a09-8ac5-b997ae1c6dfd"
/dev/sda2: UUID="d4857a61-09d5-4768-b564-e3a12c2ca7d0" TYPE="xfs" PARTUUID="aa583022-7407-40dc-8f9e-1cb147dccd8b"
/dev/sda3: UUID="535d89c0-9b67-4138-a0f3-0879ef2a6cc6" TYPE="crypto_LUKS" PARTUUID="1e55ca3d-3636-4c37-8e27-d9bda13099a7"
/dev/sdb1: SEC_TYPE="msdos" LABEL="NEW" UUID="A06A-C2D3" TYPE="vfat"
/dev/mapper/luks-535d89c0-9b67-4138-a0f3-0879ef2a6cc6: UUID="nkQRNs-YN39-SR5g-Ge4r-jHNB-yfi4-PszeGt" TYPE="LVM2_member"
/dev/mapper/centos-root: UUID="e5859343-e19d-4cf3-9ef9-c86664a8cae3" TYPE="xfs"
/dev/mapper/centos-swap: UUID="045010bd-a926-4202-9467-6e54d110688d" TYPE="swap"
```

上面`/dev/sda3`为加密的磁盘，`/dev/sdb1`为U盘（FAT文件系统）。记下他们的uuid，分别为
`535d89c0-9b67-4138-a0f3-0879ef2a6cc6` 和 `A06A-C2D3`

先挂载U盘，并创建相应的文件

```
mount /dev/sdb1 /media 
mkdir /media/cryptboot 
cd /media/cryptboot

#创建一个keyfile到u盘中
dd if=/dev/urandom bs=4096 count=1 of=/media/cryptboot/boot.key

#把boot.key添加为解锁的密钥，会弹出 Enter any existing passphrase: 让你输入密码
cryptsetup luksAddKey /dev/sda3 /media/cryptboot/boot.key
```

测试下添加的密钥文件有没有成功：

```
[root@localhost ~]# cryptsetup luksOpen -v --key-file /media/cryptboot/boot.key --test-passphrase /dev/sda3
Key slot 1 unlocked.
Command successful.
```

出现上面命令就是成功了。


### 修改启动方式

```
cp /etc/default/grub /etc/default/grub.original
sed -i 's|rd.lvm.lv=centos/swap|rd.luks.key=cryptboot/boot.key:UUID=A06A-C2D3 rd.lvm.lv=centos/swap|g' /etc/default/grub
```

即是在 `/etc/default/grub` 中GRUB_CMDLINE_LINUX这一行添加 `rd.luks.key=cryptboot/boot.key:UUID=A06A-C2D3`

下面是修改后的

```
GRUB_CMDLINE_LINUX="crashkernel=auto rd.lvm.lv=centos/root rd.luks.uuid=luks-535d89c0-9b67-4138-a0f3-0879ef2a6cc6 rd.luks.key=cryptboot/boot.key:UUID=A06A-C2D3 rd.lvm.lv=centos/swap rhgb quiet"
```

###　修改下文件`/etc/dracut.conf`

```
echo 'add_drivers+="vfat nls_cp437 nls_iso8859-1 ext4"' >> /etc/dracut.conf
echo 'omit_dracutmodules+="systemd"' >> /etc/dracut.conf
```

### 重新生成grub 和 initramfs

```
grub2-mkconfig -o /boot/grub2/grub.cfg
或
grub2-mkconfig -o /boot/efi/EFI/centos/grub.cfg

dracut --force -v
```

之前一直不成功的原因是，我的电脑 是uefi启动方式+GPT磁盘，所以应该使用 `grub2-mkconfig -o /boot/efi/EFI/centos/grub.cfg`。这点很重要。

之后重启电脑就可以了。