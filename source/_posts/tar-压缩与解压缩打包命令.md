---
title: tar 压缩与解压缩打包命令
tags:
  - tar
id: 313383
categories:
  - Linux
date: 2012-05-29 03:03:09
---

`tar [-cxtzjvfpPN] 文件与目录`

**参数：**
`-c` :建立压缩文件的参数命令（creat的意思）
`-x` :解压缩文件的参数命令
`-t` :查看tar包里文件的命令特别注意，在使用参数时,`c/x/t`只能有一个，不能同时存在
因为不可能同时压缩与解压缩。
`-z` :是否同时具有gzip的属性，即是否需要用gzip压缩
`-j` :是否同时具有bz2的属性，即是否需要用bzip2压缩（记不住的就是它）
`-v` :压缩过程中显示文件，这个常用，呵基本上我现在每次解压都会看一下里面的文件
`-f` :使用文件名，之后立即加文件名，不能再加别的参数
`-p` :使用原文件的原来属性（属性不会根据用户而变），这个从来没用过。。
`-P` :可以使用绝对路径来压缩
`-N` :比后面接的日期（`yyyy/mm/dd`)还要新的才会被打包进新建的文件中
`–exclude FILE` :在压缩的过程中，不要将FILE打包

呵，基本上我现在常用的四个命令如下：


压缩成gzip文件：


```
tar -zcvf shell.tar.gz shell/
```

将gzip文件解压：

```
tar -zxvf shell.tar.gz
```

压缩为bz2文件：

```
tar -jcvf shell.tar.bz2 shell/
```

将bz2文件解压：

```
tar -jxvf shell.tar.bz2
```


如果只想将文件打成tar包，不做压缩：

```
tar -cvf shell.tar shell/
```


同样，解压你也就知道了

```
tar -xvf shell.tar
```
