---
title: LNMP网站启用Cloudflare CDN之后如何记录用户真实IP
tags:
  - CentOS
  - lnmp
  - lnmpa
  - VPS
id: 20220501
categories:
  - Linux
date: 2022-05-01 00:03:02
---

## 安装 NGINX http_realip_module 模块

在 LNMP 安装目录下找到 lnmp.conf 这个文件，编辑这个文件，在 Nginx_Modules_Options 里加上 `--with-http_realip_module`，修改的命令如下：

```
Nginx_Modules_Options='--with-http_realip_module'
```

保存后执行 ./upgrade.sh nginx 来升级下 NGINX 就可以了。升级需要输入新的 NGINX 版本号，如果不想改动版本，直接输入原来的版本号即可。


## 修改 LNMP 配置启用模块

修改配置文件 `/usr/local/nginx/conf/nginx.conf` 


创建文件 `touch /usr/local/nginx/conf/cloudflare_ip.conf`

然后，在 `server {}` 里面加上下面这一行：

```
include cloudflare_ip.conf;
```

在 /root 目录下创建下面文件：

```
update_cloudflare_ip.sh
```

```
#!/bin/bash
echo "#Cloudflare" > /usr/local/nginx/conf/cloudflare_ip.conf;
for i in `curl https://www.cloudflare.com/ips-v4`; do
        echo "set_real_ip_from $i;" >> /usr/local/nginx/conf/cloudflare_ip.conf;
done
for i in `curl https://www.cloudflare.com/ips-v6`; do
        echo "set_real_ip_from $i;" >> /usr/local/nginx/conf/cloudflare_ip.conf;
done

echo "" >> /usr/local/nginx/conf/cloudflare_ip.conf;
echo "# use any of the following two" >> /usr/local/nginx/conf/cloudflare_ip.conf;
echo "real_ip_header CF-Connecting-IP;" >> /usr/local/nginx/conf/cloudflare_ip.conf;
echo "#real_ip_header X-Forwarded-For;" >> /usr/local/nginx/conf/cloudflare_ip.conf;
```

执行一次脚本：`/bin/bash /root/update_cloudflare_ip.sh`


保存之后，配置 crontab 每周更新一次 Cloudflare 的 IP 地址（crontab -e）：

```
0 5 * * 1 /bin/bash /root/update_cloudflare_ip.sh
```


## 修改日志记录配置

还是修改 `/usr/local/nginx/conf/nginx.conf` 这个文件，在 `http {}` 中间加入下面几行：

```
map $HTTP_CF_CONNECTING_IP  $clientRealIp {
    ""    $remote_addr;
    ~^(?P<firstAddr>[0-9.]+),?.*$    $firstAddr;
}
log_format  main  '$clientRealIp [$time_local] "$request" '
                  '$status $body_bytes_sent "$http_referer" '
                  '$http_user_agent $remote_addr $request_time';
```

*注意*： 如果`include cloudflare_ip.conf;` 放在 `http {}`中，$remote_addr会替换为真实的ip地址，不需要上面的修改了。

然后在网站记录的日志定义使用main这个日志格式

```
access_log /home/wwwlogs/abc.com.log main;
```

最后重载下nginx

```
/etc/init.d/nginx reload
```

这时就全部搞定了。

## 防火墙如何封禁真实的用户ip

开了 CDN 之后使用 iptables 是没法封禁真实 IP 地址的。