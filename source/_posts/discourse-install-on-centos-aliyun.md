---
title: discourse安装
id: 20190812
categories:
  - 技术
date: 2019-08-12 11:43:00
tags:
---


## 安装 Docker / Git

    `wget -qO- https://get.docker.io/ | sh`

## 安装 Discourse

创建 /var/discourse 文件夹，克隆官方 Discourse Docker 镜像 239至其中，然后在拷贝一个配置文件，并命名为 app.yml：

```
mkdir /var/discourse
git clone https://github.com/discourse/discourse_docker.git /var/discourse
cd /var/discourse
cp samples/standalone.yml containers/app.yml
```

### 编辑 Discourse 配置文件

配置文件是 YAML 格式，请不要删除配置项“:”前的内容。

在 app.yml 中编辑 Discourse 配置:

```
vi containers/app.yml
```

* 将 params 中的 version 前的注释符号 # 去掉，然后设置其为最稳定的 stable（正式版）。其他还有两个分支可以选择，分别是 beta（测试版） 和 tests-passed（预览版）。beta 更新比 stable 快，如果想帮助反馈问题和试用新特性，可以较为安全的使用。tests-passed 和主线开发版本非常近，但不稳定。

* 在 env 中增加 DISCOURSE_DEFAULT_LOCALE，并设为您想用的语言，比如简体中文 zh_CN。Discourse 初始化时会自动创建一些分类和主题，这样可以初始化成简体中文。如果在此设置了语言，在站点设置中将无法修改站点语言，但是你总是可以在配置文件中更改语言并重建容器。

* 如果是在墙内部署，添加 web.china.template.yml 模板，具体方法见：在大陆地区的云上部署 Discourse。

* 将 DISCOURSE_DEVELOPER_EMAILS 改为您的邮件地址。

* 将 DISCOURSE_HOSTNAME 设置为 discourse.example.com，意思是您想要您的 Discourse 可以通过 http://discourse.example.com/ 访问。您需要更新您的 DNS 的 A 记录，使其指向您服务器的 IP 地址。

* 将您邮件发送的验证信息填在 DISCOURSE_SMTP_ADDRESS、DISCOURSE_SMTP_PORT、DISCOURSE_SMTP_USER_NAME和DISCOURSE_SMTP_PASSWORD。如果需要的话请确定删掉了这几行前面的多余空格和 # 字符。

* 如果您在使用 1 GB 的服务器，将 UNICORN_WORKERS 设为 2，db_shared_buffers设为 128MB，以节省内存。




[root@iZ11bl9iw4xZ discourse]# ./launcher bootstrap app
Your Docker installation is not using a supported storage driver.  If we were to proceed you may have a broken install.
aufs is the recommended storage driver, although zfs and overlay2 may work as well.
Other storage drivers are known to be problematic.
You can tell what filesystem you are using by running "docker info" and looking at the 'Storage Driver' line.

If you wish to continue anyway using your existing unsupported storage driver,
read the source code of launcher and figure out how to bypass this check.


vi /usr/lib/systemd/system/docker.service

ExecStart=/usr/bin/dockerd-current \
	  --storage-driver=aufs \

docker重启后启动失败Failed to start Docker Application Container Engine.
请把rm -rf /var/lib/docker/一并删除


https://www.orgleaf.com/3098.html


### CentOS7配置支持AUFS文件系统

https://www.jianshu.com/p/63fdb0c0659c


[root@iZ11bl9iw4xZ discourse]# ./launcher bootstrap app
ERROR: Docker version 1.13.1 not supported, please upgrade to at least 17.03.1, or recommended 17.06.2

wget -qO- https://get.docker.com/ | sh

ls /lib/systemd/system | grep docker
yum list installed | grep docker

yum -y remove docker-ce.x86_64 docker-ce-cli.x86_64 containerd.io.x86_64

git克隆项目的时候出现标题中的错误

```
fatal: unable to access 'xxx.git/': Peer reports incompatible or unsupported protocol version.
```

安装相关库

```
yum update -y nss curl libcurl
```