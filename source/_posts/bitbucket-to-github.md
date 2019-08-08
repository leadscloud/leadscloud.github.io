---
title: 把代码从bitbucket迁移到github
id: 20190808
categories:
  - 技术
date: 2019-08-08 12:23:10
tags: git
---

github推出免费私人仓库已经很久了，之前的代码都放在bitbucket上面，今天迁移了一个到github上面

```
cd $HOME/Code/repo-directory
git remote rename origin bitbucket
git remote add origin https://github.com/leadscloud/leadscloud.github.io.git
git push origin master

git remote rm bitbucket

```

上面的方法可以保留所有的提交记录。