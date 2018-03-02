---
title: Python_序列与映射的解包操作
date: 2016-05-16 18:02:56
tags: [python]
id: 314002
categories: 技术
---

解包就是把序列或映射中每个元素单独提取出来，序列解包的一种简单用法就是把首个或前几个元素与后面几个元素分别提取出来，例如：

```
first, seconde, *rest = sequence
```

如果sequence里至少有三个元素，那么执行完上述代码后:

```
first == sequence[0]
second == sequence[0] 
rest == sequence[2:]
```

## 函数接收不确定参数

当函数的参数不确定时，可以使用`*args` 和 `**kwargs`，`*args` 没有key值，`**kwargs`有key值。

```python
#!/usr/bin/python
# -*- coding:utf-8 -*-
import sys
reload(sys)
sys.setdefaultencoding('utf-8')
 
'''
当函数的参数不确定时，可以使用*args 和**kwargs，*args 没有key值，**kwargs有key值。
 
'''
 
def fun_var_args_kwargs(data1, *args, **kwargs):
    print 'data1:', type(data1), data1
    print '*args:', type(args), args
    print '**kwargs:', type(kwargs), kwargs
 
fun_var_args_kwargs('this is data1', 2, '3', 4.0, k1='value1', k2='value2')
 
print '-------------'
 
def print_args(*args, **kwargs):
    print args.__class__.__name__, args, kwargs.__class__.__name__, kwargs
 
print_args()
print_args(1, 2, 3, a='A')
```


**打印结果：**

```
data1: <type 'str'> this is data1
*args: <type 'tuple'> (2, '3', 4.0)
**kwargs: <type 'dict'> {'k2': 'value2', 'k1': 'value1'}
-------------
tuple () dict {}
tuple (1, 2, 3) dict {'a': 'A'}
```