---
title: github新仓库初始设置
date: 2016-10-21 15:35:37
tags: [git,github]
id: 314022
categories: 技术
---


```
echo "# leadscloud.github.io" >> README.md
git init
git add README.md
git commit -m "first commit"
git remote add origin git@github.com:leadscloud/leadscloud.github.io.git
git push -u origin master
```