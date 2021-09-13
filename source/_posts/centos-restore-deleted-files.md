---
title: centos恢复被删除的文件
id: 20210913
categories:
  - Linux
date: 2021-09-13 15:35:00
tags: centos
---

### 列出被删除的文件

```
lsof | grep deleted
```

第2列是进程id，第4列是文件描述符

### 查看删除文件

```
ls -l /proc/进程id/fd/文件描述符
```

### 恢复文件

```
cp /proc/进程id/fd/文件描述符 Newfilename
```


## mysql数据库删除恢复

使用上面的命令恢复文件后，发现mysql数据库只恢复了`.ibd`文件，`.frm`文件无法使用lsof恢复

使用其它的表结构，复制到数据库目录，或者重新创建一个表`drop table tbl_name`。

```
ALTER TABLE tbl_name DISCARD TABLESPACE;
```

这个命令会删除相应的ibd文件。

从备份文件中复制ibd文件到数据库目录，然后执行下面的命令。

```
ALTER TABLE tbl_name IMPORT TABLESPACE;
```