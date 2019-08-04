---
title: 启用 macOS 原生的U盘读写NTFS功能
id: 20190521
categories:
  - 技术
date: 2019-05-21 23:01:00
tags: [macos]
---

> 默认情况下，把一个NTFS格式的磁盘插入到Mac里，是只能读不能写的。网上一直流传着这么一个简单的方法是用第三方工具，Paragon NTFS for MAC。但是要收费，第二就是破解版还不一定能运行。其实最早在OSX 10.5的时候，OSX其实原生就支持直接写入NTFS的盘的，后来由于微软的限制，把这个功能给屏蔽了，我们可以通过命令行手动打开这个选项。

## 先插入你的 U 盘

先把你的移动硬盘插入到 mac 电脑上面


## 在Finder中查看你的驱动器名称

左侧 位置 下面会显示你的 U 盘名称，记下它例如名字为： myDiskName

你也可以使用命令查看你的驱动器名称

`df`

或者

`diskutil list`

## 更新 fstab 文件

`sudo vim /etc/fstab`

如果 vim 不会用，可以使用 `sudo nano /etc/fstab` 这个命令

把以下内容写入进去

```
LABEL=myDiskName none ntfs rw,auto,nobrowse
```

`myDiskName` 这个是你的驱动器名称，记住别弄错了

##  重新插入 U 盘

拔掉你的移动硬盘或优盘，再重新插入，这时你会发现找不到之前看到的那个驱动器了，这是正常的，按以下方法操作

* 打开 Finder
* 使用快捷键 `Command+Shift+G`
* 输入框中输入 `/Volumes`
* 回车

然后你就能看到你的磁盘了

方便起见，你可以直接把磁盘拖到Finder侧边栏中，这样下次使用就不用进入到/Volumes目录打开了


