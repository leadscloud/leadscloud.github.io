---
title: centos ssh无密码登入linux设置
id: 313694
categories:
  - Linux
date: 2014-01-13 04:47:39
tags: [linux, centos, ssh]
---

测试的是linode的VPS

1、在本机创建密钥

```
[root@localhost ~]# ssh-keygen -t rsa
Generating public/private rsa key pair.
Enter file in which to save the key (/root/.ssh/id_rsa): 
Enter passphrase (empty for no passphrase): 
Enter same passphrase again: 
Your identification has been saved in /root/.ssh/id_rsa.
Your public key has been saved in /root/.ssh/id_rsa.pub.
The key fingerprint is:
*****
```


2、复制公密到服务器,先使用cd /root/.ssh/进入 .ssh目录

```
[root@localhost .ssh]# scp id_rsa.pub root@50.126.53.22:/root/.ssh/1.192.121.77
root@50.126.53.22's password: 
id_rsa.pub                                    100%  408     0.4KB/s   00:00  
```


3、上一步上传完成后，在服务器的`/root/.ssh/`目录下，会多一个文件1.192.121.77,登陆服务器，`cd /root/.ssh/`然后添加公密到服务器的的信任区域

```
[root@li482-108 .ssh]# cat 1.192.121.77 &gt;&gt; authorized_keys
```


备注： 2，3两步可由命令ssh-copy-id一步到位

```
[root@localhost .ssh]# ssh-copy-id root@50.126.53.22
Password:
Now try logging into the machine, with "ssh 'root@50.126.53.22'", and check in:

  .ssh/authorized_keys

to make sure we haven't added extra keys that you weren't expecting.

```


至此已经完成了所有配置，现在你再使用 ssh root@50.126.53.22 应该就不需要密码了。

如果ssh 50.126.53.22返回 Agent admitted failure to sign using the key
ps -Af|grep agent查看有无ssh-agent有无运行，若没有

```
[root@localhost .ssh]# ssh-agent
```

添加id_rsa到ssh-agent

```
[root@localhost .ssh]# ssh-add id_rsa
```
