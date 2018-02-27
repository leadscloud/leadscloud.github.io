---
title: purevpn-ubuntu下的配置
tags:
  - PureVPN
id: 314008
categories:
  - Linux
date: 2016-07-08 21:39:32
---

今天配置了purevpn，花了我比较久的时间，今天在这记录下，也许别人也会遇到同样的问题。

1、PureVPN的openvpn服务器全部被封锁在中国，所以你连不上是正常的，在Ubuntu下，无法使用openvpn. 我在这上面花了太多时间，后来改为PPTP才行。
https://support.purevpn.com/pptp-configuration-guide-for-ubuntu

2、Ubuntu上面配置 PPTP，默认每次是询问密码的不会保存，可以在这儿修改。

/etc/NetworkManager/system-connections/[vpnname]

文件中的password-flags修改下：

password-flags=0 代表将密码保存到该配置文件中（keyfile）
password-flags=1 代表将密码保存到系统keyring文件中 （Passwords and Encrypt keys）
password-flags=2 代表永不保存密码

还需要添加
[vpn-secrets]
password=yourpassword

这一项操作可以在可视化界面下操作，选择保存密码。

3、通过 tail -f /var/log/syslog 可以查看你的VPN连接情况