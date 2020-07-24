
---
title: Ubuntu下搭建ngrok 服务实现内网穿透
id: 316026
categories:
  - 技术
date: 2018-03-15 21:05:55
tags: [ubuntu, ngrok]
---

今天来郑州公司迁移 Google AdWords API 系统，想在上海访问这边的内网，这边是没有固定 IP的，这边就用到了内网穿透利器ngrok 了，这个东西微信开发也会用到。

ngrok官网的服务因为服务器在国外，所以不是很稳定，我们可以通过开源的代码自己搭建一个ngrok服务器。 下面是主要的操作步骤：


## 准备环境

安装golang及相关依赖

```
sudo apt-get install build-essential golang mercurial git
```

先进入到自己想安装的目录，并从github clone ngrok的项目

```
git clone https://github.com/tutumcloud/ngrok.git ngrok
cd ngrok/
```


通过以下命令生成并替换源码里默认的证书，注意域名xxxx.com修改为你自己的。


```
NGROK_DOMAIN="test.lanthy.com"
openssl genrsa -out base.key 2048
openssl req -new -x509 -nodes -key base.key -days 10000 -subj "/CN=$NGROK_DOMAIN" -out base.pem
openssl genrsa -out server.key 2048
openssl req -new -key server.key -subj "/CN=$NGROK_DOMAIN" -out server.csr
openssl x509 -req -in server.csr -CA base.pem -CAkey base.key -CAcreateserial -days 10000 -out server.crt
cp base.pem assets/client/tls/ngrokroot.crt
```


## 编译服务端

```
sudo make release-server
```

如果一切正常，`ngrok/bin` 目录下应该有 ngrokd 文件

通过以下命令启动服务：

```
cd ngrok/
sudo ./bin/ngrokd -tlsKey=server.key -tlsCrt=server.crt -domain="sub.lanthy.com" -httpAddr=":8081" -httpsAddr=":8082"
```

其中httpAddr、httpsAddr 分别是 ngrok 用来转发 http、https 服务的端口，可以随意指定。同时ngrokd 还会开一个 4443 端口用来跟客户端通讯（可通过 -tunnelAddr=”:xxx” 指定）。

这里如果你的服务器配置了iptables规则，需要对外开放使用到的端口，可以本地telnet相应的端口看是否可用，不可用可以通过以下的命令开启：

```
/sbin/iptables -I INPUT -p tcp --dport 8081 -j ACCEPT
/sbin/iptables -I INPUT -p tcp --dport 8082 -j ACCEPT
/sbin/iptables -I INPUT -p tcp --dport 4443 -j ACCEPT
/etc/rc.d/init.d/iptables save
/etc/rc.d/init.d/iptables restart
/etc/init.d/iptables status
```

接下来就是需要在自己的域名提供商那里做域名映射了，这里最好把域名泛解析到相应的服务器：

*.lanthy.com

然后启动后，通过浏览器访问 test.lanthy.com:8081 如果页面显示

        Tunnel test.lanthy.com:8081 not found

表示启动成功，可以用客户端连接了。



## 编译客户端

### 编译linux客户端

```
make release-client
```

编译后会在`ngrok/bin` 目录下有 ngrok 文件。

### 编译Mac客户端

```
sudo GOOS=darwin GOARCH=amd64 make release-client
```

编译后会在`ngrok/bin/darwin_amd64` 目录下有 ngrok 文件。

### 编译windows客户端

```
sudo GOOS=windows GOARCH=amd64 make release-client
```

编译后会在`ngrok/bin/windows_amd64` 目录下有 ngrok.exe 文件。


## 运行测试客户端

将以上的不同系统版本的客户端下载到相应系统后，同一目录新增配置文件ngrok.cfg：

```
server_addr: test.lanthy.com:4443
trust_host_root_certs: false
```

Mac上执行客户端

映射本地8080端口，自定义子域名test，通过终端执行以下命令：

```
./ngrok -subdomain sub -config=ngrok.cfg 8080
```

Windows上执行客户端：

映射本地8090端口，自定义子域名test，通过DOS界面进入grok客户端的相应目录:

```
ngrok -config=ngrok.cfg -subdomain=sub 8080
```

如果连接成功，会出现大概以下内容：


```
ngrok                                           (Ctrl+C to quit)
                     
Tunnel Status                 online                                            
Version                       1.7/1.7                                           
Forwarding                    http://sub.test.lanthy.com:8081 -> 127.0.0.1:8080      
Forwarding                    https://sub.test.lanthy.com:8082 -> 127.0.0.1:8080     
Web Interface                 127.0.0.1:4040              
            
  # Conn                        0                                                 
Avg Conn Time                 0.00ms
```

这样你就就可以通过http://sub.test.lanthy.com:8081 访问内网 127.0.0.1:8080 

SSH 22端口映射

```
/root/ngrok/bin/ngrok -config=/root/ngrok/.ngrok -subdomain=test --proto=tcp 22
```

        使用tcp协议穿透，就不会分配2级域名，改为监控一个随机端口,如 test.lanthy.com:12389

HTTP 80端口映射

```
/root/ngrok/bin/ngrok -config=/root/ngrok/.ngrok -subdomain="sub" 80
```

后台运行

```
/root/ngrok/bin/ngrok -config=/root/ngrok/.ngrok -subdomain=sub --proto=tcp -log=stdout 22 > /dev/null &
```


## 使用固定端口配置

如果想一次性转发多个端口或者想指定远程的对应端口，需要完善`ngrok.cfg`

```
server_addr: ngrok.lanthy.com:4443
trust_host_root_certs: false
tunnels:
 ssh:
  remote_port: 1122
  proto:
   tcp: 22
 ss:
  emote_port: 8388
  proto:
   tcp: 8388
 ftp:
  remote_port: 20
  proto:
   tcp: 20
 ftp2:
  remote_port: 21
  proto:
   tcp: 21
 http:
  subdomain: www
  proto:
   http: 80
   https: 192.168.1.22:443
```

使用方法：

```
/root/ngrok/bin/ngrok -config=/root/ngrok/.ngrok start http
```

## 参考链接：

https://juejin.im/entry/58adb743b123db006730e691
https://yii.im/posts/pretty-self-hosted-ngrokd/
http://ngrok.cn/docs.html