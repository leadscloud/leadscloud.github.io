---
title: lnmp 在 debian5.0 下安装总是失败的原因
tags:
  - Debian
  - lnmp
  - lnmpa
  - VPS
id: 313298
categories:
  - Linux
date: 2012-04-20 07:40:38
---

说下我的VPS配置：

IXwebhosting X2 Debian VPS 系统
<pre class="theme:epicgeeks lang:sh decode:true">#uname -a
Linux rockscrusher.com 2.6.18-028stab099.3 #1 SMP Wed Mar 7 15:20:22 MSK 2012 x86_64 GNU/Linux
# head -n 1 /etc/issue
Debian GNU/Linux 6.0 \n \l</pre>
这是升级后的，以前是5.0的。

vpser.net 上的lnmp安装或lnmpa安装，只适合它推荐的几款VPS的上安装。其它的VPS失败率比较高，比如我的这个系统 。

在安装中一般会出现的错误是更新源不对。
其中会一直出现下面的循环。
<pre class="theme:neon lang:sh decode:true">Configuration file `/etc/security/limits.conf'
 ==&gt; Modified (by you or by a script) since installation.
 ==&gt; Package distributor has shipped an updated version.
   What would you like to do about it ?  Your options are:
    Y or I  : install the package maintainer's version
    N or O  : keep your currently-installed version
      D     : show the differences between the versions
      Z     : start a shell to examine the situation
 The default action is to keep your current version.
*** limits.conf (Y/I/N/O/D/Z) [default=N] ? dpkg: error processing libpam-modules (--configure):
 EOF on stdin at conffile prompt
Errors were encountered while processing:
 libpam-modules
E: Sub-process /usr/bin/dpkg returned an error code (1)
Reading package lists...
Building dependency tree...
Reading state information...
0 upgraded, 0 newly installed, 0 to remove and 264 not upgraded.
1 not fully installed or removed.
After this operation, 0B of additional disk space will be used.
Setting up libpam-modules (1.1.1-6.1+squeeze1) ...</pre>

## 解决方法：

### 把/etc/apt/sources.list 更换为以下

<pre class="theme:phiphou lang:sh decode:true">deb http://archive.debian.org/debian lenny main contrib non-free
deb http://archive.debian.org/debian-security/ lenny/updates main contrib non-free
deb http://archive.debian.org/debian-volatile/ lenny/volatile main contrib non-free</pre>

### 然后更新系统：

<pre class="theme:twilight lang:default decode:true">apt-get update
apt-get upgrade</pre>

另外：

为什么要更新源呢，一般情况下安装lnmpa前更新下系统会比较顺利，因为lnmpa在安装过程中也会更新一些它需要的依赖包。所以这两个命令很重要。

<pre class="lang:sh decode:true " >apt-get update
apt-get upgrade</pre> 