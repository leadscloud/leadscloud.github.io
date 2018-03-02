---
title: Python的装饰器
date: 2015-12-02 16:30:09
tags: python
id: 313991
categories: 技术
---


```python
def decorate(func, finery):
    def wrap(*args, **kwargs):
        return '{0} {1}'.format(finery, func(*args, **kwargs))
    return wrap

def big_trouser(func):
    return decorate(func, "垮裤")

def tsherts(func):
    return decorate(func, "大T恤")

def sneaker(func):
    return decorate(func, "破球鞋")

def suit(func):
    return decorate(func, "西装")

def tie(func):
    return decorate(func, "领带")

def leather_shoes(func):
    return decorate(func, "皮鞋")


class Main:
    def __init__(self, name):
        self.name = name

    @big_trouser
    @tsherts
    def one(self):
        print('第一种装扮')
        return self.show()

    @leather_shoes
    @tie
    @suit
    def two(self):
        print('第二种装扮')
        return self.show()

    @sneaker
    @leather_shoes
    @big_trouser
    @tie
    def three(self):
        print('第三种装扮')
        return self.show()

    def show(self):
        return '装扮的{0}'.format(self.name)


if __name__ == '__main__':
    xc = Main('小菜')
    print(xc.one())
    print(xc.two())
    print(xc.three())
```

输出

```
第一种装扮
垮裤 大T恤 装扮的小菜
第二种装扮
皮鞋 领带 西装 装扮的小菜
第三种装扮
破球鞋 皮鞋 垮裤 领带 装扮的小菜
```