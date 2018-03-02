---
title: ServerStatus支持多台服务器监控的探针
date: 2015-10-12 16:08:33
tags: 
id: 313989
categories: 技术
---

ServerStatus是一款python探针，[英文原版项目](https://github.com/BotoX/ServerStatus) | [中文版项目](https://github.com/cppla/ServerStatus)


ServerStatus是一个用Python开发的探针的多主机探针，可以简单实现负载、网络、流量、CPU、内存和磁盘等参数的监控

## 下载ServerStatus

```
git clone https://github.com/cppla/ServerStatus
```

        其中Server为服务器端主程序，Client为客户端探针，而Web文件夹中则是探针的页面部分


## 安装

```
cd ServerStatus/server
make
```

运行

```
./sergate

[server]: Bound to :35601   这是正常状态的显示
[server]: Couldn't open socket. Port (35601) might already be in use.   这种状态是35601端口被占用
```

## 服务器端配置

然后需要修改config.json文件，注意username, password的值要与客户端保持一致

修改完成之后，可以把编译完成的程序和配置文件放到/usr/local/bin和/etc下

```
cp -r ./sergate /usr/local/bin/
cp -r ./config.json /etc/sergate.json
```

下面到探针页面派上用场的时候了，回到根目录下，复制ServerStatus/web到你的网站路径

```
cp -r ServerStatus/web/* /home/wwwroot/yourwebsite/status
```


一切配置完成之后，可以启动服务端了

```
sergate --config=/etc/sergate.json --web-dir=/home/wwwroot/yourwebsite/status
```

## 客户端配置

客户端有两个版本，client-linux为普通的linux版本，client-psutil为跨平台版本

如果普通版配置不成功，可以换成跨平台的版本试试，首先进入客户端的目录

```
cd ServerStatus/client
```

客户端的配置很简单，只需要修改相应的参数，首先vim client-linux.py修改SERVER地址，username帐号， password密码，然后python client-linux.py运行无错误就可以了。

跨平台版本也一样，但是要先安装psutil跨平台依赖库，然后和普通版一样vim client-psutil.py修改SERVER地址，username帐号， password密码，最后python client-psutil.py运行无错误就大功告成。

为了方便管理，可以把client-linux.py或client-psutil.py也复制到/usr/local/bin或者/opt下


## 设置Systemd服务

服务端脚本示例 /etc/systemd/system/serverstatus-server.service

```
[Unit]
Description=ServerStatus Server Daemon
Wants=network.target

[Service]
Type=simple
ExecStart=/usr/local/bin/sergate --config=/etc/sergate.json --web-dir=/data/wwwroot/status

[Install]
WantedBy=multi-user.target

```

执行以下命令安装并启动

```
systemctl daemon-reload
systemctl enable serverstatus-server.service
systemctl start serverstatus-server.service
```


客户端脚本示例 /etc/systemd/system/serverstatus-client.service

```
[Unit]
Description=ServerStatus Client Prober
Wants=network.target

[Service]
Type=simple
ExecStart=/usr/bin/python3 /opt/client-linux.py

[Install]
WantedBy=multi-user.target
```

执行以下脚本安装并启动

```
systemctl daemon-reload
systemctl enable serverstatus-client.service
systemctl start serverstatus-client.service
```

