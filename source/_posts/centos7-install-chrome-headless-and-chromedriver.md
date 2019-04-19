---
title: CentOS 安装 python3 和 chrome headless 及 chromedriver
date: 2019-04-09 19:31:21
tags: chromedriver
id: 20190409
categories: 技术
---

# CentOS 安装 python3和 chrome 及 chromedriver


## 安装 Python3
```
yum install epel-release
yum install python36
```

### 安装 pip3

```
curl -O https://bootstrap.pypa.io/get-pip.py
python3 get-pip.py
```

## 安装 chrome

https://intoli.com/blog/installing-google-chrome-on-centos/

### RHEL/CentOS 7.X 下安装方法

先查看你的系统版本
`cat /etc/redhat-release`

编辑文件 `/etc/yum.repos.d/google-chrome.repo`

`vi /etc/yum.repos.d/google-chrome.repo`

里面的内容如下：

```
[google-chrome]
name=google-chrome
baseurl=http://dl.google.com/linux/chrome/rpm/stable/$basearch
enabled=1
gpgcheck=1
gpgkey=https://dl-ssl.google.com/linux/linux_signing_key.pub
```

完成安装

```
yum install google-chrome-stable
```

测试

```
google-chrome-stable --no-sandbox --headless --disable-gpu --screenshot https://www.yahoo.com/```


## 安装 chromedriver

根据你的版本来安装

`google-chrome --version` 

```
http://chromedriver.chromium.org/downloads
```

下载相应的版本后，解压，把 chromedriver 复制到`/usr/bin/`

```
cp chromedriver /usr/bin/
```




