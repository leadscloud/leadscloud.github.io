---
date: '2018-07-30 12:31:07'
id: 20180730
tags: 'javascript'
categories: '技术'
title: JavaScript中的匿名函数、闭包
---

## 匿名函数

匿名函数：就是没有函数名的函数。

```
//普通函数 
function box() {               //函数名是 box 
       return'Lee'; 
}


//匿名函数
 function(){               //匿名函数，会报错
     return'Lee'; 
}


//通过表达式自我执行
 (functionbox() {            //封装成表达式
        alert('Lee'); 
})();                  //()表示执行函数，并且传参


//把匿名函数赋值给变量 
var box=function(){            //将匿名函数赋给变量 
       return'Lee'; 
};
 alert(box());            //调用方式和函数调用相似


//函数里的匿名函数
function box() { 
    return function(){                  //函数里的匿名函数，产生闭包 
        return'Lee';
    } 
} 
alert(box()());               //调用匿名函数
```

## 闭包

闭包的英文单词是closure，这是JavaScript中非常重要的一部分知识，因为使用闭包可以大大减少我们的代码量，使我们的代码看上去更加清晰等等，总之功能十分强大。

闭包的含义：闭包说白了就是函数的嵌套，内层的函数可以使用外层函数的所有变量，即使外层函数已经执行完毕（这点涉及JavaScript作用域链）。

使用闭包有一个优点，也是它的缺点：就是可以把局部变量驻留在内存中，可以避免使用全局变量。


```
function a(){

    var name='sun';

    return function (){     //通过匿名函数返回 a() 局部变量 
        return name; 
    }
}    
alert(a()());         //通过a()()来直接调用匿名函数返回值

var b=a();
alert(b());          //另一种调用匿名函数返回值

```

匿名函数最大的用途是创建闭包（这是JavaScript语言的特性之一），并且还可以构建命名空间，以减少全局变量的使用。


## 闭包的经典案例

通过全局变量来累加

```
var num=0;     //全局变量 
function a(){
  num++;               //模块级可以调用全局变量，进行累加
}

a();   //1
a();   //2           //执行函数，累加了 
alert(num);      //输出全局变量

//---------------------------------------------------------------

function a(){
    var num=0;
    num++;
    return num;
}


alert(a());         //1
alert(a());        //1               //无法实现累加，因为局部变量又被初始化了

```

每次调用，变量num都会被初始化，所以每次调用都会返回1而不是累加。我们可以用普通函数内部嵌套匿名函数，形成一个闭包来使变量驻留在内存中。

使用闭包进行累加


```
function a(){
    var num=0;
    return function(){
        num++;
        return num;
    }
}

var b=a();      //获得函数 

alert(b());  //1     //调用匿名函数 
alert(b());  //2      //第二次调用匿名函数，实现累加


```

**注意** 闭包允许内层函数引用父函数中的变量，但是该变量是最终值

看下面的例子

```
/**
 * <body>
 * <ul>
 *     <li>one</li>
 *     <li>two</li>
 *     <li>three</li>
 *     <li>one</li>
 * </ul>
 */

var lists = document.getElementsByTagName('li');
for(var i = 0 , len = lists.length ; i < len ; i++){
    lists[i].onmouseover = function(){
        alert(i);    
    };
}
```

你会发现当鼠标移过每一个<li>元素时，总是弹出4，而不是我们期待的元素下标。这是为什么呢？

**注意事项里已经讲了（最终值）。**

显然这种解释过于简单，当mouseover事件调用监听函数时，首先在匿名函数` (function(){ alert(i); })` 内部查找是否定义了 i，结果是没有定义；因此它会向上查找，查找结果是已经定义了，并且i的值是4（循环后的i值）；所以，最终每次弹出的都是4。


### 解决方案一

```
var lists = document.getElementsByTagName('li');
for(var i = 0 , len = lists.length ; i < len ; i++){
    (function(index){
        lists[index].onmouseover = function(){
            alert(index);    
        };                    
    })(i);
}
```

### 解决方案二

```
var lists = document.getElementsByTagName('li');
for(var i = 0, len = lists.length; i < len; i++){
    lists[i].$$index = i;    //通过在Dom元素上绑定$$index属性记录下标
    lists[i].onmouseover = function(){
        alert(this.$$index);    
    };
}
```

### 解决方案三

```
function eventListener(list, index){
    list.onmouseover = function(){
        alert(index);
    };
}
var lists = document.getElementsByTagName('li');
for(var i = 0 , len = lists.length ; i < len ; i++){
    eventListener(lists[i] , i);
}
```