---
title: binrm-argument-list-too-long
id: 313627
categories:
  - Linux
date: 2013-08-22 12:39:10
tags:
---

如果你想很多数据，一般是大批量的，可能会提示以下错误： /BIN/RM: ARGUMENT LIST TOO LONG ， 以下语句可以解决此问题。

find . -name '*' | xargs rm -v