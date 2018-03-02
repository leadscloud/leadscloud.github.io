---
title: Python time datetime常用时间处理方法
date: 2016-03-01 16:11:20
tags: python
id: 313997
categories: 技术
---

## 常用时间转换及处理函数

```python
import datetime
# 获取当前时间
d1 = datetime.datetime.now()
print(d1)
# 当前时间加上半小时
d2 = d1 + datetime.timedelta(hours=0.5)
print(d2)
# 格式化字符串输出
d3 = d2.strftime('%Y-%m-%d %H:%M:%S')
print(d3)
# 将字符串转化为时间类型
d4 = datetime.datetime.strptime(date,'%Y-%m-%d %H:%M:%S.%f')
print(d4)
```

## 获取本周和本月第一天的日期

```python
# -*- coding:utf-8 -*-
import datetime
def first_day_of_month():
    '''
    获取本月第一天
    :return:
    '''
    # now_date = datetime.datetime.now()
    # return (now_date + datetime.timedelta(days=-now_date.day + 1)).replace(hour=0, minute=0, second=0,
    # microsecond=0)
    return datetime.date.today() - datetime.timedelta(days=datetime.datetime.now().day - 1)
def first_day_of_week():
    '''
    获取本周第一天
    :return:
    '''
    return datetime.date.today() - datetime.timedelta(days=datetime.date.today().weekday())

if __name__ == "__main__":
    this_week = first_day_of_week()
    last_week = this_week - datetime.timedelta(days=7)
    this_month = first_day_of_month()
    last_month = this_month - datetime.timedelta(days=(this_month - datetime.timedelta(days=1)).day)
    print(this_week)
    print(last_week)
    print(this_month)
    print(last_month)
```