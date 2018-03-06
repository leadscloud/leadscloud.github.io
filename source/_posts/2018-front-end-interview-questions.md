---
title: 2018前端面试题收集
date: 2018-03-06 19:41:27
tags: [前端,面试]
id: 316020
categories: 技术
---

## CSS 有哪些样式可以给子元素继承!

可继承的:font-size,font-weight,line-height,color,cursor等
不可继承的一般是会改变盒子模型的:display,margin、border、padding、height等

##  box-sizing常用的属性有哪些? 分别有啥作用?

box-sizing有两个值:content-box(W3C标准盒模型),border-box(怪异模型),
这个css 主要是改变盒子模型大小的计算形式
可能有人会问padding-box,这个之前只有 Firefox 标准实现了,目前50+的版本已经废除;
用一个栗子来距离,一个div的宽高分别100px,border为5px,padding为5px

```
 <style>
    .test {
      box-sizing: content-box;
      border: 5px solid #f00;
      padding:5px;
      width: 100px;
      height: 100px;
    }

  </style>
  <div class="test"></div>
<!--
content-box的计算公式会把宽高的定义指向 content,border和 padding 另外计算,
也就是说 content + padding + border = 120px(盒子实际大小)

而border-box的计算公式是总的大小涵盖这三者, content 会缩小,来让给另外两者
content(80px) + padding(5*2px) + border(5*2px) = 100px
-->
```


## 清除浮动的方式有哪些?比较好的是哪一种?

常用的一般为三种`.clearfix`, `clear:both`,overflow:hidden;

## CSS 中transition和animate有何区别? animate 如何停留在最后一帧!

这种问题见仁见智,我的回答大体是这样的..待我捋捋.
transition一般用来做过渡的,而animate则是做动效,算是前者的一个补充拓展;
过渡的开销比动效小,前者一般用于交互居多,后者用于活动页居多;
至于如何让animate停留在最后一帧也好办,就它自身参数的一个值就可以了

```
animation-fill-mode: forwards;  
<!--backwards则停留在首帧,both是轮流-->
```

让我们来举个栗子....自己新建一个 html 跑一下....

```
<!DOCTYPE html>
<html lang="en">

<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <meta http-equiv="X-UA-Compatible" content="ie=edge">
  <title>Box-sizing</title>
  <style>
    .test {
      box-sizing: border-box;
      border: 5px solid #f00;
      padding: 5px;
      width: 100px;
      height: 100px;
      position:absolute;
      /*
      简写的姿势排序
      @keyframes name : 动画名
      duration 持续时间
      timing-function 动画频率
      delay 延迟多久开始
      iteration-count 循环次数
      direction 动画方式,往返还是正向
      fill-mode  一般用来处理停留在某一帧
      play-state running 开始,paused 暂停 ....
       更多的参数去查文档吧..我就不一一列举了
      */
      animation: moveChangeColor  ease-in 2.5s 1  forwards running;
    }

    @keyframes moveChangeColor {
       from {
         top:0%;
         left:5%;
         background-color:#f00
       }
       to{
         top:0%;
         left:50%;
         background-color:#ced;
       }
    }

  </style>
</head>

<body>
  <div class="test"></div>
</body>

</html>
```


## 块级元素水平垂直居中的方法

我们要考虑两种情况,定宽高和不定宽高的;

方案 N 多种,我记得我很早写过这类的笔记

[网页元素居中攻略记](http://blog.csdn.net/column/details/center-layout.html)


## CSS样式权重的优先级

        !important > 行内样式 > id > class > tag

CSS特异性

## JS有几种数据类型,其中哪些的基本数据类型有哪些!

七种数据类型

* Boolean
* Null
* Undefined
* Number
* String
* Symbol (ECMAScript 6 新定义)
* Object

其中5种为基本类型: `string`,`number`,`boolean`,`null`,`undefined`

`Object` 为引用类型(范围挺大),也包括数组、函数,

`Symbol`是原始数据类型 ，表示独一无二的值


## `null`和`undefined`的差异

**相同点**

在 if判断语句中,值都默认为 false
大体上两者都是代表无,具体看差异

**不同点**

* null转为数字类型值为0,而undefined转为数字类型为 NaN(Not a Number)
* undefined是代表调用一个值而该值却没有赋值,这时候默认则为undefined
* null是一个很特殊的对象,最为常见的一个用法就是作为参数传入(说明该参数不是对象)
* 设置为null的变量或者对象会被内存收集器回收

## this对象的理解

简言之: 谁调用指向谁, 运行时的上下文确定, 而非定义的时候就确定;

强行绑定 this的话,可以用 call,apply,bind,箭头函数....来修改this的指向

## bind的 js简单模拟

```
Function.prototype.emulateBind =  function (context) {
    var self = this;
    return function () {
        return self.apply(context);
    }

}
```

## 怎么解决跨域问题,有哪些方法

我一般用这三种, cors, nginx反向代理, jsonp

- jsonp : 单纯的 get 一些数据,局限性很大...就是利用script标签的src属性来实现跨域。

- nginx 反向代理: 主要就是用了nginx.conf内的proxy_pass http://xxx.xxx.xxx, 会把所有请求代理到那个域名,有利也有弊吧..

- cors的话,可控性较强,需要前后端都设置,兼容性 IE10+ ,比如

        Access-Control-Allow-Origin: http://foo.example  // 子域乃至整个域名或所有域名是否允许访问
        Access-Control-Allow-Methods: POST, GET, OPTIONS // 允许那些行为方法
        Access-Control-Allow-Headers: X-PINGOTHER, Content-Type  // 允许的头部字段
        Access-Control-Max-Age: 86400  // 有效期


若是我们要用 nginx或者 express 配置cors应该怎么搞起? 来个简易版本的


nginx 

```
location / {
   # 检查域名后缀
    add_header Access-Control-Allow-Origin xx.xx.com;
    add_header Access-Control-Allow-Methods GET,POST,OPTIONS;
    add_header Access-Control-Allow-Credentials true;
    add_header Access-Control-Allow-Headers DNT,X-CustomHeader,Keep-Alive,User-Agent,X-Requested-With,If-Modified-Since,Cache-Control,Content-Type;
    add_header Access-Control-Max-Age 86400;
} 
```

express, 当然这货也有一些别人封装好的 cors中间件,操作性更强...

```
let express = require('express');  
let app = express();  

//设置所有请求的头部
app.all('*', (req, res, next) =>  {  
    res.header("Access-Control-Allow-Origin", "xx.xx.com");  
    res.header("Access-Control-Allow-Headers", "DNT,X-CustomHeader,Keep-Alive,User-Agent,X-Requested-With,If-Modified-Since,Cache-Control,Content-Type");  
    res.header("Access-Control-Allow-Methods","PUT,POST,GET,DELETE,OPTIONS");  
    next();  
});  
```

有些还会跟你死磕,,除了这些还有其他姿势么...我说了一个HTML5的postMessage....

这货用于iframe 传递消息居多, 大体有这么两步步

* window打开一个实例,传递一个消息到一个x域名
* x 域名下监听message事件,获取传递的消息

这货的兼容性没那么好,而且没考虑周全的下容易遭受 CSRF 攻击

## 对于XSS 和 CSRF 如何防范

这里就不说概念性的东西了


**XSS的防范**

- 我能想到的就是转义<>这些造成代码直接运行的的标签..轮询或者正则替换
    而面试官说这种的效率最低下,我回来仔细找了找相关资料好像没有更优方案...有的留言...


- 若是有用到 cookie,设置为http-only,避免客户端的篡改


**CSRF的防范一般这几种**

* 验证码,用户体验虽然不好,,但是很多场合下可以防范大多数攻击
* 验证 HTTP Referer 字段,判断请求来源
* token加密解密,这种是目前很常用的手段了...


任何防范都有代价的,比如验证码造成的体验不好,token滥用造成的性能问题,轮询替换造成的响应时间等


## 描述下cookie,sessionStorage,localSotrage的差异

- cookie : 大小4KB 左右,跟随请求(请求头),会占用带宽资源,但是若是用来判断用户是否在线这些挺方便
- sessionStorage和localStorage大同小异,大小看浏览器支持,一般为5MB,数据只保留在本地,不参与服务端交互.
    - sessionStorage的生存周期只限于会话中,关闭了储存的数据就没了.
    - localStorage则保留在本地,没有人为清除会一直保留

## javascript里面的继承怎么实现，如何避免原型链上面的对象共享

我在写的时候,用了两种,一个是 ES5和 ES6的方案


ES5:寄生组合式继承:通过借用构造函数来继承属性和原型链来实现子继承父。


```
function ParentClass(name) {
      this.name = name;
    }
    ParentClass.prototype.sayHello = function () {
      console.log("I'm parent!" + this.name);
    }
    function SubClass(name, age) {
      //若是要多个参数可以用apply 结合 ...解构
      ParentClass.call(this, name);
      this.age = age;
    }
    SubClass.prototype = Object.create(ParentClass.prototype);
    SubClass.prototype.constructor = SubClass;
    SubClass.prototype.sayChildHello = function (name) {
      console.log("I'm child " + this.name)
    }

    let testA = new SubClass('CRPER')

    // Object.create()的polyfill
    /*
    function pureObject(o){
        //定义了一个临时构造函数
         function F() {}
         //将这个临时构造函数的原型指向了传入进来的对象。
         F.prototype = obj;
         //返回这个构造函数的一个实例。该实例拥有obj的所有属性和方法。
         //因为该实例的原型是obj对象。
         return new F();
    }
    */
```

ES6: 其实就是ES5的语法糖,不过可读性很强..

```
class ParentClass {
      constructor(name) {
        this.name = name;
      }
      sayHello() {
        console.log("I'm parent!" + this.name);
      }
    }

    class SubClass extends ParentClass {
      constructor(name) {
        super(name);
      }
      sayChildHello() {
        console.log("I'm child " + this.name)
      }
      // 重新声明父类同名方法会覆写,ES5的话就是直接操作自己的原型链上
      sayHello(){
        console.log("override parent method !,I'm sayHello Method")
      }
    }

    let testA = new SubClass('CRPER')
```

到这里就结束了么...不,这只是笔试,

问的时候你用过静态方法,静态属性,私有变量么?

这个静态方法是ES6之后才有这么个玩意,有这么些特点

* 方法不能给 this引用,可以给类直接引用
* 静态不可以给实例调用,比如 let a = new ParentClass => a.sayHello() 会抛出异常
* 父类静态方法,子类非static方法没法覆盖父类
* 静态方法可以给子类继承
* 静态属性可以继承也可以被修改

看下面的代码..


```
class ParentClass {
      constructor(name) {
        this.name = name;
      }
      static sayHello() {
        console.log("I'm parent!" + this.name);
      }

      static testFunc(){
        console.log('emm...Parent test static Func')
      }
    }

    class SubClass extends ParentClass {
      constructor(name) {
        super(name);
      }
      sayChildHello() {
        console.log("I'm child " + this.name)
      }
      static sayHello() {
        console.log("override parent method !,I'm sayHello Method")
      }

      static testFunc2() {
        console.log(super.testFunc() + 'fsdafasdf');
      }
    }
    ParentClass.sayHello(); // success print

    let a = new ParentClass('test');
    a.sayHello() // throw error

    SubClass.sayHello(); // 同名 static 可以继承且覆盖
    
    SubClass.testFunc2(); // 可以继承

    let testA = new SubClass('CRPER');
```

私有变量这个我没答出来,只是说了下没有private这个关键字和基本用下划线的人为区分

所以回来只是找了下相关的资料,发现有一个比较好的模拟方案,就是WeakMap;

WeakMap可以避免内存泄露,当没有被值引用的时候会自动给内存寄存器回收了.

```
const _ = new WeakMap(); // 实例化,value 必须为对象,有 delete,get,has,set四个方法,看名字都知道了

class TestWeakMap {
  constructor(id, barcode) {
    _.set(this, { id,barcode });
  }
  testFunc() {
    let { id,barcode } = _.get(this); // 获取对应的值
    return { id,barcode };
  }
}
```

## 谈谈你对 Promise 的理解? 和 ajax 有关系么?

Promise和ajax没有半毛钱直接关系. promise只是为了解决"回调地狱"而诞生的;

平时结合 ajax是为了更好的梳理和控制流程...这里我们简单梳理下..

Promise有三种状态,Pending/resolve()/reject();

一些需要注意的小点,如下

* 在 Pending 转为另外两种之一的状态时候,状态不可在改变..
* Promise的 then为异步.而(new Promise())构造函数内为同步
* Promise的catch不能捕获任意情况的错误(比如 then 里面的setTimout内手动抛出一个Error)
* Promise的 resolve若是传入值而非函数,会发生值穿透的现象

Promise 还有一些自带的方法,比如race,all,前者有任一一个解析完毕就返回,后者所有解析完毕返回...

[Promise 必知必会（十道题）](https://juejin.im/post/5a04066351882517c416715d)
[JavaScript Promise迷你书（中文版）](http://liubin.org/promises-book/)


## 谈谈你对 TCP 的理解


        Q: TCP 是在哪个OSI 的哪个层!通讯过程是全双工还是半双工(单工)?
        A: 传输层,全双工
        Q: TCP的通讯的过程是怎么样的!
        A: 整个过程是三次握手,四次挥手..
        Q: 你说的没错,说说整个过程如何?
        A: 举个栗子,我把 TCP 比做两个人用对讲机沟通(大白话)..三次握手就是.A1(吼叫方,客户端)想要呼叫 A2(控制室的某某,服务端)..
        A1对着对讲机说"over over ,听到请回答"(第一次,请求应答) ...
        A2收到回应"收到收到,你说"(第二次,确认应答)
        A1开始巴拉巴拉个不停而 A2没拒绝(第三次,通讯建立)

        而四次挥手则是两者确认互相倾述完毕的过程..
        A1说:"控制室,报告完毕了"(第一次挥手)
        A2说:"知道了...那么你废话说完就好好听我指挥....巴拉巴拉.."(第二次挥手)
        A1此时等待控制室说完毕,而控制室等回应(第三次挥手)
        等到 A1回馈控制室确认都知道完毕了..(第四次挥手)...

以上都是瞎掰,可能有些地方描述不当,笑笑就好了
TCP没有百分百建立成功的,会造成链接失败的情况有很多..
比如长时间没应答(A1吼了半天没有反应或者 A2应答了而 A1不再鸟它)..亦或者丢包(对讲机也没了);
TCP 协议相关的文章网上很多,若是要更加全面的了解该协议请自行引擎..
我建议阅读<<TCP-IP详解卷1~卷3>>,这个是网络圣经...很厚...我只看了一丢丢..

## TCP 你了解了,那么 OSI 七层协议和五层网络架构应该知道吧?

对于这类的问题我也只能大体点了下,毕竟不是专攻网络这块的...
OSI 七层涵盖:物理层,数据链路层,网络层,传输层,会话层,表示层,应用层;
五层模型就是"会话,表示,应用层"同为一层;
Q: DNS 的大体的执行流程了解么,属于哪个层级?工作在哪个层级?
DNS 属于应用层协议, 至于TCP/UDP哪一层上面跑,看情况 , 大体的执行流程是这样的;

优先读取浏览器缓存
其次系统的缓存
都没有的情况下,找本地hosts文件(比如你写了映射关系优先寻找)
再没有的情况找最近的域名解析服务器
再没有则扩大访问,最终找到根服务器,还是没有就失败了..

DNS 的解析的几个记录类型需要了解:

A: 域名直接到 IP
CNAME: 可以多个域名映射到一个主机,类似在 Github Page就用 CNAME 指向
MX: 邮件交换记录,用的不多,一般搭建邮件服务器才会用到
NS: 解析服务记录,可以设置权重,指定谁解析
TTL: 就是生存时间(也叫缓存时间),一般的域名解析商都有默认值,也可以人为设置
TXT: 一般指某个主机名或域名的说明

回来我找下相关的资料,有兴趣的可以深入了解下,传送门如下:

[梳理Linux下OSI七层网络与TCP/IP五层网络架构](http://www.cnblogs.com/kevingrace/p/5909719.html)
[TCP/IP（六）应用层（DNS和HTTP协议）](https://www.html5rocks.com/zh/tutorials/file/xhr2/)
[DNS域名解析解剖](https://zhuanlan.zhihu.com/p/28305778)


## HTTP 和 HTTPS 有何差异? 听说过 SPDY 么?

我只是粗浅的回答了下...
HTTP相对于 HTTPS来说,速度较快且开销较小(没有 SSL/TSL) 对接,默认是80端口;
HTTP容易遭受域名劫持,而HTTPS相对来说就较为安全但开销较大(数据以加密的形式传递),默认端口为443..
HTTP是明文跑在 TCP 上.而HTTPS跑在SSL/TLS应用层之下,TCP上的
Q: 那么 HTTPS中的TLS/SSL是如何保护数据的...
一般有两种形式,非对称加密,生成公钥和私钥,私钥丢服务器,公钥每次请求去比对验证;
更严谨的采用 CA(Certificate Authority),给密钥签名....
Q: SPDY 听说过么.什么来的?
谷歌推行一种协议(HTTP 之下SSL之上[TCP]),可以算是HTTP2的前身,有这么些优点

压缩数据(HEADER)
多路复用
优先级(可以给请求设置优先级)

而这些优点基本 HTTP2也继承下来了..
Q: 你对 HTTP 的状态吗了解多少...
这里列举一丢丢常见的..

1XX: 一般用来判断协议更换或者确认服务端收到请求这些

100: 服务端收到部分请求,若是没有拒绝的情况下可以继续传递后续内容
101: 客户端请求变换协议,服务端收到确认


2xx: 请求成功,是否创建链接,请求是否接受,是否有内容这些

200: 请求成功
201: 请求创建成功和资源创建成功


3XX: 一般用来判断重定向和缓存

301: 所有请求已经转移到新的 url(永久重定向),会被缓存
302: 临时重定向,不会被缓存
304: 本地资源暂未改动,优先使用本地的(根据If-Modified-Since or If-Match去比对服务器的资源,缓存)


4XX: 一般用来确认授权信息,请求是否出错,页面是否丢失

400: 请求出错
401: 未授权,不能读取某些资源
403: 阻止访问,一般也是权限问题
404: 页面丢失,资源没找到
408: 请求超时
415: 媒介类型不被支持，服务器不会接受请求。


5XX: 基本都是服务端的错误

500: 服务端错误
502: 网关错误
504: 网关超时


## 几个短而让我印象深刻的题


```
if(!("a" in window)){
    var a = 10;
}
console.log(a); // undefined

// !("a" i n window)  , 返回 true
// 留言小伙伴的刨析,非常感谢,还是涉及变量提升的问题
/*
 var a;
if(!("a" in window)){
    a = 10;
}
*/

// 变种题
(function(){
 var  x = c =  b = {a:1}
})()

console.log(x.a); // error , a is not defined
console.log(c,b) // {a: 1} {a: 1}
```


```
var count = 0;

console.log(typeof count === "number"); // true , 这个不用解释了

console.log(!!typeof count === "number"); // false

// 这里涉及到就是优先级和布尔值的问题
// typeof count 就是字符串"number"
// !!是转为布尔值(三目运算符的变种),非空字符串布尔值为 true
// 最后才=== 比较 , true === "number" , return false

```

```
(function(){
  var a = b = 3;
})()

console.log(typeof a === "undefined"); // true
console.log(typeof b === "undefined"); // false

// 这里涉及的就是立即执行和闭包的问题,还有变量提升,运算符执行方向(=号自左向右)
// 那个函数可以拆成这样

(function()
  var a; /* 局部变量,外部没法访问*/
  b = 3; /* 全局变量,so . window.b === 3 , 外部可以访问到*/
  a = b;
})()

// 若是改成这样,这道题应该是对的
console.log(typeof b === "number" && b ===3
); // true
```

```
function foo(something){
  this.a = something;
}

var obj1 = {
  foo:foo
};

var obj2 = {};

obj1.foo(2)

console.log(obj1.a) // 2 ,此时的 this 上下文还在 obj1内,若是 obj1.foo 先保存当做引用再执行传参,则上下文为 window

obj1.foo.call(obj2,3); // 用 call 强行改变上下文为 obj2内
console.log(obj2.a); // 3

var  bar = new obj1.foo(4); // 这里产生了一个实例
console.log(obj1.a); // 2
console.log(bar.a); // 4;  new的绑定比隐式和显式绑定优先级更高
```

## 还有一道题目是涉及事件循环,执行的优先权的..

就是 macrotask和microtask 相关的, 具体记不起来了..那时候给了答案虽然对了.

要说出所以然,给秀了一脸..回来找了下相关的资料;

[JavaScript 运行机制详解：再谈Event Loop](http://www.ruanyifeng.com/blog/2014/10/event-loop.html)
[深入理解事件循环和异步流程控制](https://juejin.im/post/5a2e21486fb9a0450407d370)
[所有你需要知道的关于完全理解 Node.js 事件循环及其度量](https://juejin.im/post/5984816a518825265674c8f6)


## 你对基础算法这块掌握的如何....

        来,这纸给你,写个快排试试...

[十大经典排序算法总结（JavaScript描述）](https://juejin.im/post/57dcd394a22b9d00610c5ec8)

## 设计模式你了解多少?

[Javascript常用的设计模式详解](http://www.cnblogs.com/tugenhua0707/p/5198407.html)
[js-design-pattern](https://github.com/ToNiQian/js-design-pattern)

## 思维拓展题: 你有两个玻璃球,有个100米的高楼,求玻璃球在哪个楼层扔下会碎(用的次数最少);

问题的要点: 玻璃球碎(有限个数) ,确定楼层数 , 最少次数 => 就是求最优的公式

在这道题上给秀的一脸,我的第一次的思路

        先折半,就变成[1-50][51-100], 那就是 1+50 = 51次 ...

面试大佬说,你用了快排的思路就肯定不是最优的..

        憋了许久,想到开平方 \sqrt[2]{100} , 这样的话,最多只要20次

然后又说给我三个球,在1000米的高楼,判断多少次...但是根据我上面的话,

        开立方, \sqrt[3]{1000} , 那最多不超过30次;

至于第一次丢球的位置如何确定, 就是开平之后的值作为一个区间.

若 N 个球和 M 米的大厦...第一次丢球的高度区间就是这个了\frac{m}{\sqrt[n]{m}}

面试大佬说这个还可以...那就暂且告一段落

...回来用万能的搜索引擎找了下..最优方案+最少次数需要考虑的东西很多,没那么简单

传送门: [知乎有人讨论了这个问题](https://www.zhihu.com/question/31855632);

但是高数还老师了..这种帖子看的一脸懵逼....抽空再好好研究下

## 你对优化这块了解多少?

大体常见的手段了解.

比如从客户端着手的:

* 压缩代码(JS/CSS),压缩图片
* 合并一些小图片(css sprite)
* 若是打包的代码尽可能切割成多个 chunk,减少单一 chunk过大
* 静态文件采用 cdn 引入
* HTTP的缓存头使用的合理
* 减小第三方库的依赖
* 对于代码应该考虑性能来编写,比如使用requestAnimationFrame绘制动画,尽可能减少页面重绘(DOM 改变)
* 渐进升级,引入preload这些预加载资源
* 看情况用server worker来缓存资源(比如移动端打算搞 PWA)

比如从服务端着手:

* 带宽,域名解析, 多域名解析等
* 页面做服务端渲染,减小对浏览器的依赖(不用客户端解析)
* 渐进升级,比如引入 HTTP2(多路复用,头部压缩这些可以明显加快加载速度)

当然,这是这些都是很片面的点到...实际工作中去开展要复杂的多;

比如我们要多个维度去考虑的话,要去优化 DOM 的绘制时间,资源的加载时间,域名解析这些;

要全面的优化一个项目是一个大工程...

还有一些题目记不起来了,就没辙了...还有一些题目是看你个人发挥的,没法写,比如

        Q: 让你来为公司的一个项目做技术选型,你会怎么做,为什么?
        Q: MVVM 和 MVC 的差异? 听说过 MVP?
        Q: React,Angular,Vue的比较? 等等...

面试的过程中磕磕碰碰才能发现自身的很多不足和需要去努力的方向.

此篇文章暂未停更,随时会更新,因为作为技术渣的我还木有找到工作;

在找到工作之前会一直更新面试碰到问到的问题;

有不对之处请留言,会及时跟进修正,谢谢各位大佬

[2018春招前端面试: 闯关记](https://juejin.im/post/5a998991f265da237f1dbdf9)