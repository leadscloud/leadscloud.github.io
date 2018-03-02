---
title: CentOS7下安装shadowsocksR
date: 2018-01-21 14:23:46
tags: [shadwosocks, shadowsocksr]
id: 315060
categories: 技术
---

Linode CentOS7下面的安装流程


## 安装前准备

```
yum install git -y
yum install epel-release -y
yum install libsodium -y  # 使用salsa20 或 chacha20 或 chacha20-ietf 算法必须的
```

## 下载shadowsocksr

```
git clone -b manyuser https://github.com/shadowsocksr-backup/shadowsocksr.git && cd shadowsocksr/
```

## 配置shadowoskcr

`vi user-config.json`

```
{
    "server": "0.0.0.0",
    "server_ipv6": "::",
    "server_port": 3008,
    "local_address": "127.0.0.1",
    "local_port": 1080,

    "password": "password-lanthy.com",
    "method": "chacha20",
    "protocol": "auth_aes128_md5",
    "protocol_param": "",
    "obfs": "tls1.2_ticket_auth_compatible",
    "obfs_param": "",
    "speed_limit_per_con": 0,
    "speed_limit_per_user": 0,

    "additional_ports" : {}, // only works under multi-user mode
    "additional_ports_only" : false, // only works under multi-user mode
    "timeout": 120,
    "udp_timeout": 60,
    "dns_ipv6": false,
    "connect_verbose_info": 0,
    "redirect": "",
    "fast_open": true
}
```

## 后台运行ssr

`cd shadowsocks`

后台运行

`python server.py -d start`

如果要停止/重启：

`python server.py -d stop/restart`

查看日志：

`tail -f /var/log/shadowsocksr.log`

## SSR启动脚本

以下启动脚本均假定shadowsocks-rss安装于/root/shadowsocksr目录，配置文件为/root/shadowsocksr/user-config.json，请按照实际情况自行修改

SysVinit启动脚本，适合CentOS/RHEL6系以及Ubuntu 14.x，Debian7.x

```
#!/bin/sh
# chkconfig: 2345 90 10
# description: Start or stop the Shadowsocks R server
#
### BEGIN INIT INFO
# Provides: Shadowsocks-R
# Required-Start: $network $syslog
# Required-Stop: $network
# Default-Start: 2 3 4 5
# Default-Stop: 0 1 6
# Description: Start or stop the Shadowsocks R server
### END INIT INFO

# Author: Yvonne Lu(Min) <min@utbhost.com>

name=shadowsocks
PY=/usr/bin/python
SS=/root/shadowsocksr/shadowsocks/server.py
SSPY=server.py
conf=/root/shadowsocksr/user-config.json

start(){
    $PY $SS -c $conf -d start
    RETVAL=$?
    if [ "$RETVAL" = "0" ]; then
        echo "$name start success"
    else
        echo "$name start failed"
    fi
}

stop(){
    pid=`ps -ef | grep -v grep | grep -v ps | grep -i "${SSPY}" | awk '{print $2}'`
    if [ ! -z "$pid" ]; then
        $PY $SS -c $conf -d stop
        RETVAL=$?
        if [ "$RETVAL" = "0" ]; then
            echo "$name stop success"
        else
            echo "$name stop failed"
        fi
    else
        echo "$name is not running"
        RETVAL=1
    fi
}

status(){
    pid=`ps -ef | grep -v grep | grep -v ps | grep -i "${SSPY}" | awk '{print $2}'`
    if [ -z "$pid" ]; then
        echo "$name is not running"
        RETVAL=1
    else
        echo "$name is running with PID $pid"
        RETVAL=0
    fi
}

case "$1" in
'start')
    start
    ;;
'stop')
    stop
    ;;
'status')
    status
    ;;
'restart')
    stop
    start
    RETVAL=$?
    ;;
*)
    echo "Usage: $0 { start | stop | restart | status }"
    RETVAL=1
    ;;
esac
exit $RETVAL
```

> 请将上述脚本保存为 `/etc/init.d/shadowsocks`  

### CentOS/RHEL6 执行:

```sh
chmod 755 /etc/init.d/shadowsocks && chkconfig --add shadowsocks && service shadowsocks start
```

### Ubuntu 14.x，Debian7.x 执行:

```sh
chmod 755 /etc/init.d/shadowsocks ; update-rc.d shadowsocks defaults ; service shadowsocks start
```

## systemd脚本

systemd脚本，适用于CentOS/RHEL7以上，Ubuntu 15以上，Debian8以上

### 单用户版

```text
[Unit]
Description=ShadowsocksR server
After=network.target
Wants=network.target

[Service]
Type=forking
PIDFile=/var/run/shadowsocksr.pid
ExecStart=/usr/bin/python /usr/local/shadowsocksr/shadowsocks/server.py --pid-file /var/run/shadowsocksr.pid -c /usr/local/shadowsocksr/user-config.json -d start
ExecStop=/usr/bin/python /usr/local/shadowsocksr/shadowsocks/server.py --pid-file /var/run/shadowsocksr.pid -c /usr/local/shadowsocksr/user-config.json -d stop
ExecReload=/bin/kill -HUP $MAINPID
KillMode=process
Restart=always

[Install]
WantedBy=multi-user.target
```

### 多用户版

```text
[Unit]
Description=ShadowsocksR server
After=syslog.target
After=network.target

[Service]
LimitCORE=infinity
LimitNOFILE=512000
LimitNPROC=512000
Type=simple
WorkingDirectory=/usr/local/shadowsocksr
ExecStart=/usr/bin/python /usr/local/shadowsocksr/server.py
ExecReload=/bin/kill -s HUP $MAINPID
ExecStop=/bin/kill -s TERM $MAINPID
Restart=always

[Install]
WantedBy=multi-user.target
```

> 请将上述脚本保存为 `/etc/systemd/system/shadowsocksr.service`
> 并执行`systemctl enable shadowsocksr.service && systemctl start shadowsocksr.service`

### 参考资料

- https://github.com/shadowsocksr-backup/shadowsocks-rss/wiki/System-startup-script

## SSR 优化

- https://github.com/iMeiji/shadowsocks_install/wiki/shadowsocks-optimize
- [开启TCP BBR拥塞控制算法](https://github.com/iMeiji/shadowsocks_install/wiki/%E5%BC%80%E5%90%AFTCP-BBR%E6%8B%A5%E5%A1%9E%E6%8E%A7%E5%88%B6%E7%AE%97%E6%B3%95)

## shadowsocks SSR客户端下载

- https://github.com/shadowsocksr-backup/shadowsocksr-csharp/releases

## 参考资料

- https://github.com/shadowsocksr-backup/shadowsocks-rss
- https://github.com/shadowsocksr-backup/shadowsocks-rss/wiki/Server-Setup
- https://github.com/shadowsocksr-backup/shadowsocks-rss/wiki/libsodium