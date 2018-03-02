---
title: 理解python中的args和kwargs
tags:
  - python
id: 313999
categories:
  - 技术
date: 2016-04-27 11:35:58
---

Python是支持可变参数的，最简单的方法莫过于使用默认参数，例如：

```
def test_defargs(one, two = 2):
   print 'Required argument: ', one
   print 'Optional argument: ', two

test_defargs(1)
# result:
# Required argument: 1
# Optional argument: 2

test_defargs(1, 3)
# result:
# Required argument: 1
# Optional argument: 3
```

当然，本文章的主题并不是讲默认参数，而是另外一种达到可变参数 (Variable Argument) 的方法：使用`*args`和`**kwargs`语法。其中，`*args`是可变的positional arguments列表，`**kwargs`是可变的keyword arguments列表。并且，`*args`必须位于`**kwargs`之前，因为positional arguments必须位于keyword arguments之前。

<span id="more-197"></span>首先介绍两者的基本用法。

下面一个例子使用*args，同时包含一个必须的参数：

```
def test_args(first, *args):
   print 'Required argument: ', first
   for v in args:
      print 'Optional argument: ', v

test_args(1, 2, 3, 4)
# result:
# Required argument: 1
# Optional argument:  2
# Optional argument:  3
# Optional argument:  4
```

下面一个例子使用`*kwargs`, 同时包含一个必须的参数和`*args`列表：

```
def test_kwargs(first, *args, **kwargs):
   print 'Required argument: ', first
   for v in args:
      print 'Optional argument (*args): ', v
   for k, v in kwargs.items():
      print 'Optional argument %s (*kwargs): %s' % (k, v)

test_kwargs(1, 2, 3, 4, k1=5, k2=6)
# results:
# Required argument:  1
# Optional argument (*args):  2
# Optional argument (*args):  3
# Optional argument (*args):  4
# Optional argument k2 (*kwargs): 6
# Optional argument k1 (*kwargs): 5
```

`*args`和`**kwargs`语法不仅可以在函数定义中使用，同样可以在函数调用的时候使用。不同的是，如果说在函数定义的位置使用`*args`和`**kwargs`是一个将参数pack的过程，那么在函数调用的时候就是一个将参数unpack的过程了。下面使用一个例子来加深理解：

```
def test_args(first, second, third, fourth, fifth):
    print 'First argument: ', first
    print 'Second argument: ', second
    print 'Third argument: ', third
    print 'Fourth argument: ', fourth
    print 'Fifth argument: ', fifth

# Use *args
args = [1, 2, 3, 4, 5]
test_args(*args)
# results:
# First argument:  1
# Second argument:  2
# Third argument:  3
# Fourth argument:  4
# Fifth argument:  5

# Use **kwargs
kwargs = {
    'first': 1,
    'second': 2,
    'third': 3,
    'fourth': 4,
    'fifth': 5
}

test_args(**kwargs)
# results:
# First argument:  1
# Second argument:  2
# Third argument:  3
# Fourth argument:  4
# Fifth argument:  5
```

使用`*args`和`**kwargs`可以非常方便的定义函数，同时可以加强扩展性，以便日后的代码维护。

参考资料：

- http://kodango.com/variable-arguments-in-python
- http://www.wklken.me/posts/2013/12/21/how-to-use-args-and-kwargs-in-python.html