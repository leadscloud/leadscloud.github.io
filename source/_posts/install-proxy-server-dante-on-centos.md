---
title: 代理服务器dante安装到centos
id: 20220927
categories:
  - Linux
date: 2022-09-27 01:07:32
tags: proxy
---

### 安装步骤

```
wget https://www.inet.no/dante/files/dante-1.4.3.tar.gz
tar xf dante-1.4.3.tar.gz
cd dante-1.4.3/
autoreconf --install --force
./configure
make install
```

### 创建并编辑配置文件

`vi /etc/sockd.conf`

```
internal: 0.0.0.0 port=1080
external: eth0

clientmethod: none
socksmethod: username # 使用系统用户名密码方式验证

#user.privileged: root
user.notprivileged: socks  # 创建的用户名

client pass {
    from: 0/0  to: 0/0
    #log: connect disconnect error
}

socks pass {
    from: 0/0  to: 0/0
    #log: connect disconnect error
}
```

127.0.0.1 替换成 x.x.x.x/8 即可。

配置说明： https://www.inet.no/dante/doc/1.4.x/config/server.html

### 添加用户

```
adduser --no-create-home --shell /usr/sbin/nologin socks # 添加一个本地用户，不创建默认目录和登录Shell

passwd socks # 设置一个密码
```

### 运行

直接以daemon模式运行
```
sockd -D
```


### 测试代理

使用内置的-V命令测试sockd.conf文件是否正确，若正确则无任何输出

```
sockd -V
```

测试能否正常使用

```
curl --proxy 'socks5://127.0.0.1:1080' 'https://api.ipify.org/'
```

可以使用 `netstat -lntp` 看启动状态
```
tcp        0      0 0.0.0.0:1080            0.0.0.0:*               LISTEN      16769/sockd
```

### 开机启动

`vi /etc/rc.local`

```
/usr/local/sbin/sockd -f /etc/sockd.conf &
```

### 关闭

`killall sockd`