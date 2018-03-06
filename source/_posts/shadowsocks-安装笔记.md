---
title: shadowsocks 安装笔记
id: 313675
categories:
  - 个人日志
date: 2013-11-30 13:19:33
tags:
---

一些记录，不是很详细

安装git

```
yum -y install git
```

查看git安装成功没

```
git --version
```

```
git clone https://github.com/clowwindy/shadowsocks.git

cd shadowsocks
vi config.json
```

```
{
    "server":"<your_ip>",
    "server_port":8388,
    "local_port":1080,
    "password":"password",
    "timeout":600,
    "method":"table"
}
```


`python setup.py install`

进入 shadowsocks下的shadowsocks文件夹

`nohup python server.py > log & `

或者进入到config.json文件所在目录 

`nohup ssserver > log &`

Centos 开机启动设置

`echo "nohup ssserver -c /root/shadowsocks/config.json > log &" >> /etc/rc.d/rc.local`

`lsof -i :8388`  可以查看此端口的连接