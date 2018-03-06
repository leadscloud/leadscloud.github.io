---
title: 安装apc为php加速
tags:
  - APC
  - VPS
id: 313393
categories:
  - Linux
date: 2012-06-02 05:20:56
---

`Alternative PHP Cache`（APC）是 PHP 的一个免费公开的优化代码缓存。它用来提供免费，公开并且强健的架构来缓存和优化 PHP 的中间代码。

安装方法:

```
wget http://pecl.php.net/get/APC-3.1.9.tgz
tar zxf APC-3.1.9.tgz
cd APC-3.1.9
/usr/local/php/bin/phpize
./configure --enable-apc --enable-apc-mmap --with-php-config=/usr/local/php/bin/php-config
export LD_LIBRARY_PATH
make 
make install
```

配置php.ini


```
vi /usr/local/php/lib/php.ini
``` 

在末尾加上，根据PHP不同的版本，路径会有不同，请作修改。

```
[APC]
extension = "/usr/local/php/lib/php/extensions/no-debug-zts-20090626/apc.so"
apc.enabled = 1
apc.cache_by_default = on
apc.shm_segments = 1
apc.shm_size = 32M
apc.ttl = 600
apc.user_ttl = 600
apc.num_files_hint = 0
apc.write_lock = On
```

然后重启Apache

```
service httpd restart
```