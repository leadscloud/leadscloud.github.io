---
title: python-的-generator-以及-yield-和-yield-from-关键字解释
tags:
  - python
id: 314005
categories:
  - 个人日志
date: 2016-06-01 17:39:17
---

Python 的 generator（生成器）是指包含有 yield 关键字的函数。即使这个函数同时包含 return 和 yield 关键字，它也是一个 generator。

generator（生成器）的作用和函数有点像，但是区别在于：如果需要生成并返回一个很长很长的列表，那么函数必须把这个列表的每个值**全部**计算完后一起返回。然而有时候这个列表是无穷无尽的，或者全部计算完的话耗时很久，亦或是列表的长度超过了内存容量，而实际上我们一次只需要取一个值。此时就可以使用 generator 来『一边用，一边生成』，有点类似『流式处理』。

比如说著名的斐波那契数列，一次生成所有值是不可能的，因为是个无穷序列。但是可以用 generator 来逐个生成各项的值，即调用一次只得到下一个需要的值。

TL;DR (一句话解释）：
<div class="green-box">

yield 相当于特殊版的 return。当第一次运行生成器的代码时，会从头开始，直到遇到 `yield [某个值]` 就返回一个值。以后再次调用这个生成器时，会从那个 yield 处恢复执行，而不像普通函数一样每次调用都从第一句开始。

</div>
接下来是详细版解释：

yield 关键字可以用来实现协程（coroutine），能够让程序运行时在各个函数间跳来跳去，『多次进入，多次返回，每次接着上次的断点运行』。协程比多线程的开销要小得多，可以让多个函数配合完成一项任务，在函数遇到了阻塞（比如要等待网络上远程发来的信息）时及时跳出来去处理其他事情，避免空等。因此协程在在异步 I/O 设计中十分常见。

生成器只能向前，不能回头，也不保存之前生成的任何值。当所有值都生成完毕后，就会抛出 StopIteration 异常，再也不能使用它了。如果需要提前终止，调用 close() 方法即可。

## yield 关键字

首先来看一段代码：
<pre class="lang:python decode:true ">def get_sequence():
    i = 1

    while True:
        print('get_sequence: 生成 %d 之前' % i)
        yield i
        print('get_sequence: 生成 %d 之后\n' % i)
        i += 1

def main():
    get_num = get_sequence()

    print('main: 得到了生成器返回的值 %d' % next(get_num))
    print('main: 得到了生成器返回的值 %d' % next(get_num))
    print('main: 得到了生成器返回的值 %d' % next(get_num))
    get_num.close()

    try:
        print('main: 得到了生成器返回的值 %d' % next(get_num))
    except StopIteration:
        print('main: generator 已经结束,不能再生成数字了')

if __name__ == '__main__':
    main()</pre>
&nbsp;

上述代码定义了一个生成器，可以依次生成 1, 2, 3, 4 .... 到 ∞ 的整数序列。每调用一次 `next(get_num)` 就可以得到一个下一个需要生成的值。

运行结果是：
<div class="yellow-box">
> get_sequence: 生成 1 之前> 
> main: 得到了生成器返回的值 1> 
> get_sequence: 生成 1 之后> 
> 
> get_sequence: 生成 2 之前> 
> main: 得到了生成器返回的值 2> 
> get_sequence: 生成 2 之后> 
> 
> get_sequence: 生成 3 之前> 
> main: 得到了生成器返回的值 3> 
> main: generator 已经结束,不能再生成数字了
</div>
在第一次调用 `next(get_num)` 时，也是第一次进入 get_sequence() 函数。然后 i = 1，进入 while 循环，然后打印`get_sequence: 生成 1 之前`。之后遇到了 `yield i` 语句，就返回当前的 i 的值给调用者 main()，生成器在此保存断点。main() 得到了返回值，就传递给 print 语句来输出 `main: 得到了生成器返回的值 1`。

main() 函数接着运行，遇到了下一个 `next(get_num)`，相当于 `next_num.send(None)`，给生成器发送信息会重新切换到 get_sequence() 函数，并接着之前的断点执行。然后就输出了 `get_sequence: 生成 1 之后`，执行 i += 1，i 的值变为 2，然后进入下一轮 while 循环，直到再次遇到 yield 关键字才返回 main 函数。

调用生成器的 close() 方法可以强制关闭它。这样再次给它 send 任何信息，都会抛出 StopIteration 异常，表明没什么可以生成了。

另一个例子：
<pre class="lang:python decode:true "># 定义一个生成器
def generator():
    i = 0
    while True:
        i += 1
        recv = yield i      # 将 i 的值返回调用者，然后暂时冻结在这里。等到调用者发出 send 或者 next 的话，再从这里复苏并将传入的值赋给 recv

        try:
            print("&gt;&gt;&gt; Generator: 我收到了 %d" % recv)
        except TypeError:
            print("&gt;&gt;&gt; Generator: 我收到了 None, 因为 next(m) 与 m.send(None) 效果是一样的")

# 主函数
def main():
    m = generator()
    print("得到返回值: %d" % next(m))   # 相当于 m.send(None)，第一次调用生成器
    print("得到返回值: %d" % next(m))   # 相当于 m.send(None)
    print("得到返回值: %d" % m.send(4))

if __name__ == '__main__':
    main()</pre>
&nbsp;

运行结果是：
<div class="yellow-box">
> 得到返回值: 1> 
> &gt;&gt;&gt; Generator: 我收到了 None, 因为 next(m) 与 m.send(None) 效果是一样的> 
> 得到返回值: 2> 
> &gt;&gt;&gt; Generator: 我收到了 4> 
> 得到返回值: 3
</div>
可以通过在 PyCharm 或者 pdb 加断点的方式来追踪程序的运行流程，从而发现『交替执行』的规律。

这段代码定义了一个生成器，其中最难理解的是 `recv = yield i` 这个语句。这句话并不是一句普通的赋值语句，而是分两步完成：

首先可以将 yield i 先理解为暂时的 return i，这样就会把 i 的值返回给调用者（main 函数）。然后生成器的执行被**冻结在这一行**，CPU 切换回 main() 函数。

`print("得到返回值: %d" % next(m))` 这句代码将 `next(m)` 的返回值打印到屏幕上。

然后执行到下一个 `next(m)` 或者 `m.send()` 语句时，就会给生成器发回一个值（None 也是一个值），然后再次回到之前被冻结到的 `recv = yield i` 这一行，随后把这个发回的值赋给 recv 变量，并输出 recv 变量的值。然后继续执行，直到遇到下一个 yield 语句... （文字描述有些绕，单步调试可以看得很清晰）

## yield from

`yield from` 可以实现『 generator 嵌套』，也就是一个 generator 嵌套另一个 generator。有没有联想到装饰器的相关知识？可以用 `yield from` 来很方便地实现『生成器的装饰器』。

将上述代码稍作修改，就加上了装饰器功能；
<pre class="lang:python decode:true ">def generator_decorator(the_generator):
    def gen(*args, **kwargs):
        print('我是装饰器。在您使用 generator 前后，我负责做一些处理工作...')

        # 这里做一些预处理工作
        # do_something()

        yield from the_generator(*args, **kwargs)

        # 这里可以做一些后续处理工作
        # do_something_else()

    return gen

@generator_decorator
def generator():
    i = 0
    while True:
        i += 1
        recv = yield i      # 将 i 的值返回调用者，然后暂时冻结在这里。等到调用者发出 send 或者 next 的话，再从这里复苏并将传入的值赋给 recv

        try:
            print("&gt;&gt;&gt; Generator: 我收到了 %d" % recv)
        except TypeError:
            print("&gt;&gt;&gt; Generator: 我收到了 None, 因为 next(m) 与 m.send(None) 效果是一样的")

# 主函数
def main():
    m = generator()
    print("得到返回值: %d" % next(m))
    print("得到返回值: %d" % next(m))
    print("得到返回值: %d" % m.send(4))

if __name__ == '__main__':
    main()</pre>
&nbsp;

运行结果如下：
<div class="yellow-box">
> 我是装饰器。在您使用 generator 前后，我负责做一些处理工作...> 
> 得到返回值: 1> 
> &gt;&gt;&gt; Generator: 我收到了 None, 因为 next(m) 与 m.send(None) 效果是一样的> 
> 得到返回值: 2> 
> &gt;&gt;&gt; Generator: 我收到了 4> 
> 得到返回值: 3
</div>
与之前运行结果作对比，可以看到，除了第一行是 `我是装饰器。在您使用 generator 前后，我负责做一些处理工作...`，与不加装饰器一模一样。说明装饰起作用了，可以先做一些预处理工作，然后完成被装饰对象（generator）的本职功能。

## 另外...

动态语言之间是越来越像了，JavaScript 的 ES6 支持 yield 关键字来实现生成器，C# 也早就支持了它。知识点总是相通的，不同语言之间也经常相互借鉴，而它们追根溯源，往往都来自于几十年前提出的概念（维基百科上说生成器的概念 1975 年就有了）。

&nbsp;

来源：https://www.hikyle.me/archives/601/