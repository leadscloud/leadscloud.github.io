---
title: 解决v2rayA在重启后没有启动代理的问题
tags:
  - v2raya
id: 20260828
categories:
  - Linux
date: 2026-08-28 00:33:10
---


systemd 默认采用 KillMode=control-group 模式，在停止或重启服务时会强行杀死该服务控制组内的所有进程。这可能导致 v2rayA 在关机或重启时未能正常保存或清理状态，进而引发宿主机重启后代理无法自动启动。将模式改为 KillMode=process，可以确保 systemd 仅终止主进程，避免子进程被误杀。


操作步骤

### 1. 创建 systemd 配置重写目录

为 v2raya 服务创建独立的配置扩展目录：


```
mkdir -p /etc/systemd/system/v2raya.service.d/
```


### 2. 创建并编辑配置文件

使用 nano 编辑器新建名为 fix-killmode.conf 的配置文件：


```
nano /etc/systemd/system/v2raya.service.d/fix-killmode.conf
```


### 3. 写入配置内容

在打开的文件中粘贴以下文本，重写默认的 KillMode 参数：


```
[Service]
KillMode=process
```

保存并退出（在 nano 中按 Ctrl+O 再按 Enter 保存，最后按 Ctrl+X 退出）。


### 4. 重载配置并重启服务

刷新 systemd 服务配置以使改动生效，并重启 v2rayA：


```
systemctl daemon-reload
systemctl restart v2raya
```


重启后使用命令 `sudo systemctl status v2raya.service` 查看应该如下


```
● v2raya.service - A web GUI client of Project V which supports VMess, VLESS, SS, SSR, Trojan, Tuic and Juicity protocols
     Loaded: loaded (/etc/systemd/system/v2raya.service; enabled; preset: enabled)
    Drop-In: /etc/systemd/system/v2raya.service.d
             └─fix-killmode.conf, override.conf
     Active: active (running) since Fri 2026-08-28 00:25:25 CST; 11min ago
       Docs: https://v2raya.org
   Main PID: 192482 (v2raya)
      Tasks: 35 (limit: 34706)
     Memory: 107.4M (peak: 318.2M)
        CPU: 7.336s
     CGroup: /system.slice/v2raya.service
             ├─192482 /usr/local/bin/v2raya
             └─192522 /usr/local/bin/v2raya_core run --config=/usr/local/etc/v2raya/config.json

8月 28 00:25:25 yt-sh-ubuntu-2025 systemd[1]: Started v2raya.service - A web GUI client of Project V which supports VMess, VLESS, SS, SSR, Trojan, Tuic and Juicity protocols.
8月 28 00:25:25 yt-sh-ubuntu-2025 v2raya[192482]: [DEBUG] main.main started

```

出现这个 `/usr/local/bin/v2raya_core run --config=/usr/local/etc/v2raya/config.json` 就是正常的。

具体原因可以查看github上面这个讨论

- https://github.com/v2rayA/v2rayA/discussions/1922