---
title: Catalina 10.15 外接显示器后睡眠唤醒经常死机
date: 2020-10-13 09:18:28
tags: MacOS
id: 20201013
categories: 技术
---

这是一个MacOS的bug，发生的情况非常普遍。

一个可能的解决方案

`kextstat | grep -v com.apple`

```
Index Refs Address Size Wired Name (Version) UUID <Linked Against>
116 0 0xffffff7f83ee4000 0x42000 0x42000 com.paragon-software.filesystems.ntfs (66.5.15) 43B8E60C-1D4C-37A1-A831-0ECF23B29456 <8 6 5 1>
```

卸载它

`sudo kextunload -b com.paragon-software.filesystems.ntfs`

```
kextstat | grep -v com.apple
Index Refs Address Size Wired Name (Version) UUID <Linked Against>
```

- https://www.reddit.com/r/MacOS/comments/dr1b0v/kernal_panics_causing_restarts_in_sleep_mode_in/
