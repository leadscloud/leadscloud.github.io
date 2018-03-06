---
title: LNMP修复Memcache UDP反射放大攻击
date: 2018-03-06 13:13:34
tags: [lnmp,memcache]
id: 316014
categories: 技术
---


## 关于Memcached系统

Memcached是一个自由开源的，高性能，分布式内存对象缓存系统。Memcached是以LiveJournal旗下Danga Interactive公司的Brad Fitzpatric为首开发的一款软件。现在已成为mixi、hatena、Facebook、Vox、LiveJournal等众多服务中提高Web应用扩展性的重要因素。Memcached是一种基于内存的key-value存储，用来存储小块的任意数据（字符串、对象）。这些数据可以是数据库调用、API调用或者是页面渲染的结果。Memcached简洁而强大。它的简洁设计便于快速开发，减轻开发难度，解决了大数据量缓存的很多问题。它的API兼容大部分流行的开发语言。本质上，它是一个简洁的key-value存储系统。一般的使用目的是，通过缓存数据库查询结果，减少数据库访问次数，以提高动态Web应用的速度、提高可扩展性。

## 关于分布式DDoS原理

分布式拒绝服务(DDoS:Distributed Denial of Service)攻击指借助于客户/服务器技术，将多个计算机联合起来作为攻击平台，对一个或多个目标发动DDoS攻击，从而成倍地提高拒绝服务攻击的威力。通常，攻击者使用一个偷窃帐号将DDoS主控程序安装在一个计算机上，在一个设定的时间主控程序将与大量代理程序通讯，代理程序已经被安装在网络上的许多计算机上。代理程序收到指令时就发动攻击。利用客户/服务器技术，主控程序能在几秒钟内激活成百上千次代理程序的运行。

## 关于反射式DRDoS原理

DRDoS是英文“Distributed Reflection Denial of Service ”的缩写，中文意思是“分布式反射拒绝服务”。与DoS、DDoS不同，该方式靠的是发送大量带有被害者IP地址的数据包给攻击主机，然后攻击主机对IP地址源做出大量回应，形成拒绝服务攻击。


## LNMP修复办法

以下是lnmp一键安装脚本的修复方法

根据阿里的建议：

> 如果您的Memcached版本低于1.5.6，且不需要监听UDP。您可以重新启动Memcached 加入 `-U 0`启动参数，例如：`Memcached -U 0`，禁止监听在udp协议上

`vi /etc/init.d/memcached`

```
start () {
    echo -n $"Starting $prog: "
    memcached -d -p $PORT -u $USER -m $CACHESIZE -c $MAXCONN -P /var/run/memcached.pid $OPTIONS
    RETVAL=$?
    echo
    [ $RETVAL -eq 0 ] && touch /var/lock/subsys/memcached
}

```

改为(启动项添加 `-U 0`)

```
start () {
    echo -n $"Starting $prog: "
    memcached -d -p $PORT -u $USER -m $CACHESIZE -c $MAXCONN -U 0 -P /var/run/memcached.pid $OPTIONS
    RETVAL=$?
    echo
    [ $RETVAL -eq 0 ] && touch /var/lock/subsys/memcached
}
```

## 参考资料

[基于Memcached分布式系统DRDoS拒绝服务攻击技术研究](http://blog.csdn.net/microzone/article/details/79262549)
https://paper.seebug.org/535/