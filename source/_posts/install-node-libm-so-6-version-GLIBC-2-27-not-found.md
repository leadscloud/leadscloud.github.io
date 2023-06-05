---
title: 'node: /lib64/libm.so.6: version `GLIBC_2.27' not found'
date: 2023-04-21 13:51:21
tags: node
id: 20230421
categories: [技术]
---

centos7服务器升级node 20后 `n latest`，出现以下问题

```
node: /lib64/libm.so.6: version `GLIBC_2.27' not found (required by node)
node: /lib64/libc.so.6: version `GLIBC_2.25' not found (required by node)
node: /lib64/libc.so.6: version `GLIBC_2.28' not found (required by node)
node: /lib64/libstdc++.so.6: version `CXXABI_1.3.9' not found (required by node)
node: /lib64/libstdc++.so.6: version `GLIBCXX_3.4.20' not found (required by node)
node: /lib64/libstdc++.so.6: version `GLIBCXX_3.4.21' not found (required by node)
```

明显是GLIBC_2.27支持问题


### 更新glibc

```
wget http://ftp.gnu.org/gnu/glibc/glibc-2.28.tar.gz
tar xf glibc-2.28.tar.gz 
cd glibc-2.28/ && mkdir build  && cd build
../configure --prefix=/usr --disable-profile --enable-add-ons --with-headers=/usr/include --with-binutils=/usr/bin
```

**在这之前一般都要升级gcc和make,否则在configure时会出现下面错误**

```
configure: error: 
*** These critical programs are missing or too old: make bison compiler
*** Check the INSTALL file for required versions.
```

### 升级GCC和make

```
# 升级GCC(默认为4 升级为8)
yum install -y centos-release-scl
yum install -y devtoolset-8-gcc*
mv /usr/bin/gcc /usr/bin/gcc-4.8.5
ln -s /opt/rh/devtoolset-8/root/bin/gcc /usr/bin/gcc
mv /usr/bin/g++ /usr/bin/g++-4.8.5
ln -s /opt/rh/devtoolset-8/root/bin/g++ /usr/bin/g++

# 升级 make(默认为3 升级为4)
wget http://ftp.gnu.org/gnu/make/make-4.3.tar.gz
tar -xzvf make-4.3.tar.gz && cd make-4.3/
./configure  --prefix=/usr/local/make
make && make install
cd /usr/bin/ && mv make make.bak
ln -sv /usr/local/make/bin/make /usr/bin/make
```

如果提示 ` These critical programs are missing or too old: bison` 升级或安装下bison

```
yum install -y bison
```

### 继续安装glibc

```
cd /root/glibc-2.28/build
../configure --prefix=/usr --disable-profile --enable-add-ons --with-headers=/usr/include --with-binutils=/usr/bin

make && make install
```


### 如果出现错误

```
/usr/bin/ld: cannot find -lnss_test2
```

请修改`scripts/test-installation.pl`，新增如下内容 128行左右

```
&& $name ne "nss_test1" 
```

改为 

```
&& $name ne "nss_test1" && $name ne "nss_test2"
```

如果报错

```
/lib/../lib64/libnss_nis.so: undefined reference to `_nsl_default_nss@GLIBC_PRIVATE'
```

请加--enable-obsolete-nsl

```
../configure --prefix=/usr --disable-profile --enable-add-ons --with-headers=/usr/include --with-binutils=/usr/bin --enable-obsolete-nsl
```


如果还是出现 

```
node: /lib64/libstdc++.so.6: version `GLIBCXX_3.4.20' not found (required by node)
node: /lib64/libstdc++.so.6: version `CXXABI_1.3.9' not found (required by node)
node: /lib64/libstdc++.so.6: version `GLIBCXX_3.4.21' not found (required by node)
```


通过查看`strings /usr/lib64/libstdc++.so.6 | grep GLIBCXX` 发现少了GLIBCXX_3.4.20，解决方法是升级libstdc++.

```
yum provides libstdc++.so.6


cd /usr/local/lib64
# 下载最新版本的libstdc.so_.6.0.26
wget http://www.vuln.cn/wp-content/uploads/2019/08/libstdc.so_.6.0.26.zip
unzip libstdc.so_.6.0.26.zip
# 将下载的最新版本拷贝到 /usr/lib64
cp libstdc++.so.6.0.26 /usr/lib64
cd  /usr/lib64
# 查看 /usr/lib64下libstdc++.so.6链接的版本
ls -l | grep libstdc++
libstdc++.so.6 ->libstdc++.so.6.0.19
# 删除/usr/lib64原来的软连接libstdc++.so.6，删除之前先备份一份
rm libstdc++.so.6
# 链接新的版本
ln -s libstdc++.so.6.0.26 libstdc++.so.6
# 查看新版本，成功
strings /usr/lib64/libstdc++.so.6 | grep GLIBCXX

```

升级导致的语言包问题，中文有乱码

特别是`crontab -e`编辑时里面的中文有些正常，有些乱码

```
-bash: warning: setlocale: LC_ALL: cannot change locale (en_US.UTF-8)
```

可以通过如下解决

```
cd /root/glibc-2.28/build
make localedata/install-locales
```

这样每次登录ssh就不会提示 `LC_ALL: cannot change locale` 了。


参考链接：

- https://blog.csdn.net/esdhhh/article/details/121196317
- https://www.jianshu.com/p/050b2b777b9d

