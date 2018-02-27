---
title: ubuntu-16-04-lts-vpn-pptp-自动重连
id: 314020
categories:
  - Linux
date: 2016-07-17 14:19:55
tags:
---

 
<pre class="lang:sh decode:true " >#!/bin/bash
user=raymond
vpnuuid=54404c70-120b-414e-88e7-b33bd3239cc7
while true
do
    if  [[ "$(nmcli con show --active|grep $vpnuuid)" == "" ]]; then
        echo "Disconnected, trying to reconnect..."
        sleep 1s 
        su $user -c "nmcli con up uuid $vpnuuid"
    else
        echo "Already connected !"
    fi
    sleep 10
done
</pre> 

网上的其它版本， nmcli con show --active 这一句是不一样的。 nmcli con status这个命令在这个版本下是无法显示的。