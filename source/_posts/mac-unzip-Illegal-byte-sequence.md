---
title: MacOS 下解压文件遇到文件夹乱码解决办法
date: 2019-03-29 19:40:41
tags: MacOS
id: 20190329
categories: 技术
---

解压 windows 下压缩的 zip 存档时，如果文件夹名包含中文，可能会出现以下错误

```
checkdir error:  cannot create
Illegal byte sequence
```
解决办法

用 ditto 代替 unzip

```
ditto -V -x -k --sequesterRsrc --rsrc FILENAME.ZIP DESTINATIONDIRECTORY
```

BetterZip 也无法解决上面的问题，以上方法实测有效

solution: https://github.com/CocoaPods/CocoaPods/issues/7711


