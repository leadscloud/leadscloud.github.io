---
title: 在Centos5.8中安装yum
tags:
  - centos
  - VPS
  - yum
  - linux
id: 313296
categories:
  - Linux
date: 2012-04-20 07:29:57
---

IX的空间默认是没有安装yum的，我用的是Centos5.8 ，它的最高版本！

```
rpm -Uvh http://mirror.centos.org/centos/5.8/os/x86_64/CentOS/gmp-4.1.4-10.el5.x86_64.rpm
rpm -Uvh http://mirror.centos.org/centos/5.8/os/x86_64/CentOS/readline-5.1-3.el5.x86_64.rpm  
rpm -Uvh http://mirror.centos.org/centos/5.8/os/x86_64/CentOS/python-2.4.3-46.el5.x86_64.rpm
rpm -Uvh http://mirror.centos.org/centos/5.8/os/x86_64/CentOS/libxml2-2.6.26-2.1.12.el5_7.2.x86_64.rpm
rpm -Uvh http://mirror.centos.org/centos/5.8/os/x86_64/CentOS/libxml2-python-2.6.26-2.1.12.el5_7.2.x86_64.rpm
rpm -Uvh http://mirror.centos.org/centos/5.8/os/x86_64/CentOS/expat-1.95.8-8.3.el5_5.3.x86_64.rpm
rpm -Uvh http://mirror.centos.org/centos/5.8/os/x86_64/CentOS/python-elementtree-1.2.6-5.x86_64.rpm
rpm -Uvh http://mirror.centos.org/centos/5.8/os/x86_64/CentOS/sqlite-3.3.6-5.x86_64.rpm
rpm -Uvh http://mirror.centos.org/centos/5.8/os/x86_64/CentOS/python-sqlite-1.1.7-1.2.1.x86_64.rpm
rpm -Uvh http://mirror.centos.org/centos/5.8/os/x86_64/CentOS/elfutils-libelf-0.137-3.el5.x86_64.rpm
rpm --nodeps -Uvh http://mirror.centos.org/centos/5.8/os/x86_64/CentOS/elfutils-0.137-3.el5.x86_64.rpm
rpm --nodeps -Uvh http://mirror.centos.org/centos/5.8/os/x86_64/CentOS/rpm-4.4.2.3-27.el5.x86_64.rpm
rpm --nodeps -Uvh http://mirror.centos.org/centos/5.8/os/x86_64/CentOS/rpm-python-4.4.2.3-27.el5.x86_64.rpm
rpm -Uvh http://mirror.centos.org/centos/5.8/os/x86_64/CentOS/m2crypto-0.16-8.el5.x86_64.rpm
rpm -Uvh http://mirror.centos.org/centos/5.8/os/x86_64/CentOS/python-urlgrabber-3.1.0-6.el5.noarch.rpm
rpm -Uvh http://mirror.centos.org/centos/5.8/os/x86_64/CentOS/yum-metadata-parser-1.1.2-3.el5.centos.x86_64.rpm
rpm -Uvh http://mirror.centos.org/centos/5.8/os/x86_64/CentOS/python-iniparse-0.2.3-4.el5.noarch.rpm
rpm --nodeps -Uvh http://mirror.centos.org/centos/5.8/os/x86_64/CentOS/yum-fastestmirror-1.1.16-21.el5.centos.noarch.rpm
rpm -Uvh http://mirror.centos.org/centos/5.8/os/x86_64/CentOS/yum-3.2.22-39.el5.centos.noarch.rpm
yum -y update
```

在安装lnmpa 或 lnmpa 时，很多依赖包是没有安装的。 执行

```
yum install gcc
yum update
yum upgrade
```