---
title: Visual Studio Code 如何设置运行python代码
tags:
  - Visual Studio Code
  - python
id: 314028
categories: [技术]
date: 2017-02-20 15:38:30
---

> 答案:
> http://stackoverflow.com/questions/29987840/how-to-execute-python-code-from-within-visual-studio-code

Visual Studio Code 现在用起来越来越好用了，如何让它像sublime text 一样 使用ctrl + b运行python代码呢？

Ctrl+Shift+P 调出命令面板，输入tasks 任务：配置任何运行程序，再点击other，会生成一个新文件task.json，编辑里面内容即可

```
{
    // See https://go.microsoft.com/fwlink/?LinkId=733558
    // for the documentation about the tasks.json format
    "version": "0.1.0",
    "command": "python",
    "isShellCommand": true,
    "args": ["${file}"],
    "showOutput": "always"
}
```

最后使用 Ctrl+Shift+B 就可以运行python程序了