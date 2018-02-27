---
title: centos-6-4下的python2-6-6下安装pip
tags:
  - pip
  - shadowsocks
id: 313724
categories:
  - Linux
date: 2014-03-01 07:46:21
---

Pyuthon如果需要升级，请按以下步骤执行，注意版本号不同，命令可能会有所不同，注意下版本号数字就行，别输错了。

先升级Python,执行
<div>
<pre>wget http://www.python.org/ftp/python/2.7.5/Python-2.7.5.tgz
tar zxvf Python-2.7.5.tgz
cd Python-2.7.5
./configure
make all
make install
make clean
make distclean</pre>
</div>
目前的路径应该是/usr/local/bin/python2.7,顺便看下版本
<div>
<pre>/usr/local/bin/python2.7 -V</pre>
</div>
然后查下当前的版本
<div>
<pre>python -V</pre>
</div>
我这里显示的是2.6.6
<div>
<pre>mv /usr/bin/python /usr/bin/python2.6.6
ln -s /usr/local/bin/python2.7 /usr/bin/python</pre>
</div>
现在再看下版本
<div>
<pre>python -V</pre>
</div>
应该显示2.7.5了

**以上操作可以不执行，现在来说下如何安装pip**

安装pip前，可能会需要让你安装setuptools
<pre>wget https://pypi.python.org/packages/2.6/s/setuptools/setuptools-0.6c11-py2.6.egg --no-check-certificate
sh setuptools-0.6c11-py2.6.egg</pre>

安装好后，如下所示：
<pre>
[root@zhongwen ~]# sh setuptools-0.6c11-py2.6.egg
Processing setuptools-0.6c11-py2.6.egg
Copying setuptools-0.6c11-py2.6.egg to /usr/local/lib/python2.6/site-packages
Adding setuptools 0.6c11 to easy-install.pth file
Installing easy_install script to /usr/local/bin
Installing easy_install-2.6 script to /usr/local/bin

Installed /usr/local/lib/python2.6/site-packages/setuptools-0.6c11-py2.6.egg
Processing dependencies for setuptools==0.6c11
Finished processing dependencies for setuptools==0.6c11
</pre>
正式安装pip,此为依pip 1.4为例
<pre>wget --no-check-certificate https://pypi.python.org/packages/source/p/pip/pip-1.4.tar.gz
tar -zxvf ./pip-1.4.tar.gz
cd pip-1.4
python setup.py install</pre>

升级python后会导致yum不可用，解决办法如下：

vi /usr/bin/yum
把 #/usr/bin/python to #/usr/bin/python2.6

或者下载rpm包重新安装下yum
http://mirror.centos.org/centos/5/os/x86_64/CentOS/yum-3.2.22-40.el5.centos.noarch.rpm
rpm -Uvh --replacepkgs yum-3.2.22-40.el5.centos.noarch.rpm