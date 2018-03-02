---
title: git code conflict common solution
tags:
  - Git
id: 314023
categories:
  - 个人日志
date: 2016-11-02 16:32:16
---

如果代码本地有修改，这个时候你使用 `git pull` 会产生以下错误提示

```
error: Your local changes to 'DailyBot/web/data/config.ini' would be overwritten by merge.  Aborting.
Please, commit your changes or stash them before you can merge.
```

如果希望保留服务器上的代码改动，不保留本地改动，可以这样操作：

```
git stash
git pull
git stash pop
```

如果希望用代码库中的文件完全覆盖本地工作版本

```
git reset --hard
git pull
```
