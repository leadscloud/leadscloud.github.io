---
title: Centos升级python2.7到python3.4.2
id: 313932
categories:
  - 技术
date: 2015-01-14 20:56:18
tags: [python, centos]
---

首先在命令行下输入 python 以查看你的python版本，默认应该是2.6以上的，比如我的是2.7
安装python3.4之前建议先安装以下软件包：
```
yum install zlib-devel bzip2-devel openssl-devel ncurses-devel sqlite-devel readline-devel tk-devel gcc make
```

其中sqlite-devel如果不安装，python3.4安装后sqlalchemy会有些问题，比如import sqlite3会有问题。

## 下载python3.4的源码包： 

```
wget https://www.python.org/ftp/python/3.4.2/Python-3.4.2.tgz
tar zxvf Python-3.4.2.tgz
cd Python-3.4.2
./configure --prefix=/usr/local/python3.4
make && make install
```

安装完之后可以在`/usr/local/src/python3.4/bin` 目录下看到python3.4

## 安装完成后还需要配置python

```
mv /usr/bin/python /usr/bin/python.bak
ln -s /usr/local/python3.3/bin/python3.3 /usr/bin/python
```

然后在命令行下输入 python 查看下版本，如果是3.4.2就正常了

## 其它的一些问题

安装好python3后，yum无法使用了，解决办法
按照提示编辑/usr/bin/yum文件，把开头的/usr/bin/python 改为 /usr/bin/python2
这主要是因为yum使用的还是python2的代码，所以需要注明使用哪个python版本

## 添加 python3.4 到环境变量

编辑 `~/.bash_profile`，将：

```
PATH=$PATH:$HOME/bin
```

改为：

```
PATH=$PATH:$HOME/bin:/usr/local/python34/bin
```

使 python3.4 环境变量生效：

```
 . ~/.bash_profile
```

## yum不可用的其它问题

```
[root@leadscloud]# yum install tmux
Loaded plugins: fastestmirror
Loading mirror speeds from cached hostfile
 * base: mirror.atlanticmetro.net
 * centos-sclo-rh: centos.mirror.constant.com
 * centos-sclo-sclo: mirror.datto.com
 * extras: mirror.wdc1.us.leaseweb.net
 * updates: mirror.cogentco.com
http://people.centos.org/tru/devtools-2/7/x86_64/RPMS/repodata/repomd.xml: [Errno 14] HTTPS Error 404 - Not Found
Trying other mirror.
To address this issue please refer to the below wiki article 

https://wiki.centos.org/yum-errors

If above article doesn't help to resolve this issue please use https://bugs.centos.org/.

  File "/usr/libexec/urlgrabber-ext-down", line 28
    except OSError, e:
                  ^
SyntaxError: invalid syntax
  File "/usr/libexec/urlgrabber-ext-down", line 28
    except OSError, e:
                  ^
SyntaxError: invalid syntax
  File "/usr/libexec/urlgrabber-ext-down", line 28
    except OSError, e:
                  ^
SyntaxError: invalid syntax
  File "/usr/libexec/urlgrabber-ext-down", line 28
    except OSError, e:
                  ^
SyntaxError: invalid syntax


Exiting on user cancel
```

修改 `/usr/libexec/urlgrabber-ext-down`, 同样把 `/usr/bin/python` 和前面一样改为python2 `/usr/bin/python2`

升级后 还有一个问题，gnome-tweak-tool 也就是优化工具打不开

```
[root@leadscloud]# whereis yum-config-manager
yum-config-manager: /usr/bin/yum-config-manager /usr/share/man/man1/yum-config-manager.1.gz
```

`vim /usr/bin/yum-config-manager` , 解决方法同上，修改为python2即可。