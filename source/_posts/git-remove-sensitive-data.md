---
title: 彻底清除Github上某个文件包括它的历史记录
date: 2018-02-28 19:07:01
tags: github
id: 316004
categories:
---


## 删除命令

```
git filter-branch --force --index-filter 'git rm --cached --ignore-unmatch FILE_PATH' --prune-empty --tag-name-filter cat -- --all

git push origin master --force
rm -rf .git/refs/original/
git reflog expire --expire=now --all

git gc --prune=now
git gc --aggressive --prune=now
```

    上面的FILE_PATH要是路径而不只是文件名字

## 参考资料

[Removing sensitive data from a repository](https://help.github.com/articles/removing-sensitive-data-from-a-repository/)