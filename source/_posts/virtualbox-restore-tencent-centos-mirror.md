---
title: VirtualBox中恢复腾讯云服务器镜像
date: 2024-10-27 01:38:01
tags: 
  - 腾讯云
  - 镜像恢复
id: 20241027
categories: 技术
---

记录一次腾讯云镜像在本地恢复的过程

由于遇到一些限制原因导致出现了诸多错误，无法顺利恢复，不过最终经过多次尝试，终于恢复成功，特记录一下。

### 腾讯云被封，无法远程ssh连接

虽然无法访问服务器，但通过网页仍可以访问，但由于所有网络都断了，不可能下载大量数据了，想到了创建镜像然后导出到本地的操作

腾讯云创建镜像导出本地，需要先创建一个存储桶（第一次开通免费，个人50G,企业1T），并且流量是收费的，为了下载这个镜像不得不付钱搞定，整个流程到这还比较快。


### 无法正常恢复

镜像下载的为`.vmdk`镜像，下载到本地后，导入virtualbox，开机启动，出现错误 `warning: /dev/vda1 does not exist`

虚拟机创建时，选择不添加虚拟硬盘，创建完成后在设置中（选择存储，在控制器那里添加硬盘）附加镜像即可

在vnc里用`ls /dev`查看设备信息显示的结果中并不存在`/dev/vda1`，存在`/vda/sda1`

如果`/vda/sda1`也不存在，看看你的虚拟机是不是硬盘设置中位置没有放到 SATA端口0 的位置。

通过以下办法可以启动

进入VPS服务商提供的VNC后台界面,执行下面语句

```
# mount /dev/sda1 /tmp
# sed -i ‘s/vda/sda/g’ /tmp/etc/fstab
# sed -i ‘s/vda/sda/g’ /tmp/boot/grub2/grub.cfg
# reboot
```

当然，如果你更改虚拟机有时默认是正常的，那就最好不过了。原因就是虚拟机中的硬盘是sda1 但镜像中保存的是原始数据 vda1，启动时无法找到相应硬盘。


### centos7 root密码恢复

- 开机按下`Ecs`键，进入启动界面
- 根据需要选择系统内核版本并按`e`键
- 光标移动到 `linux 16` 开头的行，找到 `ro` 改为 `rw init=sysroot/bin/sh `
- 按 `Ctrl+x` 执行
- 进入如下界面后输入`chroot /sysroot`
- 输入`passwd`根据提示输入两次新密码 
- 完成后输入 `touch /.autorelabel` 更新系统信息
- 键入 `exit` 退出 
- 然后使用`reboot`命令重启


### postgresql的恢复

我主要为了恢复这个数据库，但在本地启动后无法成功启动应用，只能新建一个同样版本的Centos7，然后把数据库data目录复制过去，启动成功。

流程如下：

- 下载镜像 https://mirrors.aliyun.com/centos/7.9.2009/isos/x86_64/CentOS-7-x86_64-DVD-2009.iso
- 新建虚拟机 配置相关参数，启动安装
- 安装过程中都保持默认即可，但网络这块点击选择下启用，第一次安装后，无法连网导致我重新安装一次
- 安装中设置用户名和密码
- 进入系统后操作

- 修改更新源 `vi /etc/yum.repos.d/CentOS-Base.repo`

```
[extras]
gpgcheck=1
gpgkey=http://mirrors.tencentyun.com/centos/RPM-GPG-KEY-CentOS-7
enabled=1
baseurl=http://mirrors.tencentyun.com/centos/$releasever/extras/$basearch/
name=Qcloud centos extras - $basearch
[os]
gpgcheck=1
gpgkey=http://mirrors.tencentyun.com/centos/RPM-GPG-KEY-CentOS-7
enabled=1
baseurl=http://mirrors.tencentyun.com/centos/$releasever/os/$basearch/
name=Qcloud centos os - $basearch
[updates]
gpgcheck=1
gpgkey=http://mirrors.tencentyun.com/centos/RPM-GPG-KEY-CentOS-7
enabled=1
baseurl=http://mirrors.tencentyun.com/centos/$releasever/updates/$basearch/

```

```
yum update
yum install net-tools wget -y

yum install yum-fastestmirror
yum clean all

yum install -y https://download.postgresql.org/pub/repos/yum/reporpms/EL-7-x86_64/pgdg-redhat-repo-latest.noarch.rpm
yum update

yum install -y postgresql15-server

# 如果提示 `libzstd版本不对问题`
yum install libzstd*
yum install epel-release.noarch -y
yum install libzstd.x86_64 -y

/usr/pgsql-15/bin/postgresql-15-setup initdb
systemctl start postgresql-15
systemctl status postgresql-15


远程数据同步到本地 

`rsync -a -e "ssh -p xxxx" root@192.168.56.1:/root/data/ /var/lib/pgsql/15/data/`

cp -p data-origin/postgresql.conf data/

systemctl start postgresql-15

```

