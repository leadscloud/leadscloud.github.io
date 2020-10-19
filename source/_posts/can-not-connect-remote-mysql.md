---
title: LNMP下解决Can’t connect to MySQL server问题
tags:
  - MySQL
  - Ubuntu
id: 20200831
categories:
  - 技术
date: 2020-08-31 10:40:00
---



错误详情，lnmp下无法远程连接mysql

`ERROR 2003 (HY000): Can't connect to MySQL server on '192.168.1.49' (60)`

如果设置好mysql的远程连接后，仍然出现上面的问题一般是因为防火墙规则的问题。

### 查看iptables规则 

`sudo iptables -L`

```
Chain INPUT (policy ACCEPT)
target     prot opt source               destination
ACCEPT     all  --  anywhere             anywhere
ACCEPT     all  --  anywhere             anywhere             state RELATED,ESTABLISHED
ACCEPT     tcp  --  anywhere             anywhere             tcp dpt:http
ACCEPT     tcp  --  localhost            anywhere             tcp dpt:mysql
DROP       tcp  --  anywhere             anywhere             tcp dpt:mysql
ACCEPT     tcp  --  anywhere             anywhere             tcp dpt:mysql
ACCEPT     tcp  --  192.168.1.0/24       anywhere             tcp dpt:mysql

Chain FORWARD (policy ACCEPT)
target     prot opt source               destination
DOCKER     all  --  anywhere             anywhere
ACCEPT     all  --  anywhere             anywhere             ctstate RELATED,ESTABLISHED
ACCEPT     all  --  anywhere             anywhere
ACCEPT     all  --  anywhere             anywhere

Chain OUTPUT (policy ACCEPT)
target     prot opt source               destination

Chain DOCKER (1 references)
target     prot opt source               destination

```

注意上面多了一条

`DROP       tcp  --  anywhere             anywhere             tcp dpt:mysql`

mysql的远程连接被禁用了

### 使用下面命令显示规则的序号

`sudo iptables -L -n --line-number`

### 使用下面命令可以删除相应的规则

`sudo optables -D INPUT 6`

之后mysql连接就没问题了

下次重启规则还是会生效的，使用下面命令永久保存规则 

`sudo iptables-save`

上面的保存还是不行，使用下面的命令永久保存。

如果没有安装`iptables-persistent`，先安装它

`sudo apt-get install iptables-persistent`

保存命令：

```
sudo netfilter-persistent save
sudo netfilter-persistent reload
```