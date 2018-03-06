---
title: 在CentOS6.4上安装Git
id: 313642
categories:
  - 转载
date: 2013-10-12 05:32:03
tags: [centos,git]
---

确保已安装了依赖的包

```
yum install curl
yum install curl-devel
yum install zlib-devel
yum install openssl-devel
yum install perl
yum install cpio
yum install expat-devel
yum install gettext-devel
```

下载最新的git包

```
wget http://www.codemonkey.org.uk/projects/git-snapshots/git/git-latest.tar.gz
tar xzvf git-latest.tar.gz
cd git-2011-11-30 ＃你的目录可能不是这个
autoconf
./configure
make
sudo make install
```

检查下安装的版本，大功告成

```
git --version
```

git依赖`zlib-devel，openssl-devel，perl，cpio，expat-devel，gettext-devel`这些包，如果出错基本上也是这些包造成的。我在安装时出现了如下错误。

出现错误一：

```
usr/bin/perl Makefile.PL PREFIX='/usr/local/git' INSTALL_BASE='' --localedir='/usr/local/git/share/locale'

Can't locate ExtUtils/MakeMaker.pm in @INC (@INC contains: /usr/local/lib64/perl5 /usr/local/share/perl5 /usr/lib64/perl5/vendor_perl /usr/share/perl5/vendor_perl /usr/lib64/perl5 /usr/share/perl5 .) at Makefile.PL line 3.

BEGIN failed--compilation aborted at Makefile.PL line 3.

make[1]: *** [perl.mak] Error 2

make: *** [perl/perl.mak] Error 2
```

执行：

`yum install perl-ExtUtils-MakeMaker package.`

行进安装

出现错误二：

` /bin/sh: msgfmt: command not found`

使用

`yum install gettext-devel`

可解决！