---
title: git设置代理及取消代理
id: 20190805
categories:
  - 技术
date: 2019-08-05 16:45:11
tags: git
---

### 设置代理

```
git config --global http.proxy 'socks5://127.0.0.1:1080'
git config --global https.proxy 'socks5://127.0.0.1:1080'
```

### 取消代理

```
git config --global --unset http.proxy
git config --global --unset https.proxy
```

### 列出配置清单

```
git config --global -l
```