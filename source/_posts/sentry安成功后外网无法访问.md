---
title: sentry安成功后外网无法访问
id: 313953
categories:
  - 个人日志
date: 2015-08-13 19:05:22
tags: sentry
---

sentry 安装成功后使用127.0.0.1:9000可以访问，但局域网之外的ip都无法访问，查询文档发现是因为ALLOWED_HOSTS没有设置。

在sentry.conf.py里设置下

`ALLOWED_HOSTS = ['*']`

即可。

你通过这个源代码，也可以看出来为什么需要设置这个
https://github.com/getsentry/sentry/blob/master/src/sentry/utils/runner.py