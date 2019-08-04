---
title: Visual Studio Code 内置终端的shell和字体设置成与 iterm2 一样
date: 2019-04-14 11:10:21
tags: iterm
id: 20190414
categories: 技术
---

macos下面的终端设置成了 iterm2.app 

![](/wp-content/media/15552120055438.jpg)


但 Visual Studio Code 的内置终端还是原来的，导致一些字体图标显示为乱码，如果想让它与 iterm2设置的一样，需要进行以下操作：

![](/wp-content/media/15552118638003.jpg)



### 下载powerline等宽字体

任意目录下载字体

```
git clone https://github.com/abertsch/Menlo-for-Powerline.git
```

找到这几个字体，双击安装即可。

### 设置settings.json

添加如下几行

```
"terminal.integrated.shell.osx": "/bin/zsh",
"terminal.integrated.fontFamily": "Menlo for Powerline"
```

如果希望终端中运行iTerm2，再添加如下两行

```
 "terminal.explorerKind": "external",
 "terminal.external.osxExec": "iTerm.app"
```

