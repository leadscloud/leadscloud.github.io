---
title: HTML 5 的自定义 data-* 属性和jquery的data()方法的使用
tags:
  - HTML5
id: 313595
categories:
  - 前端设计
date: 2013-05-11 05:34:07
---

人们总喜欢往HTML标签上添加自定义属性来存储和操作数据。但这样做的问题是，你不知道将来会不会有其它脚本把你的自定义属性给重置掉，此外，你这样做也会导致html语法上不符合Html规范，以及一些其它副作用。这就是为什么在HTML5规范里增加了一个自定义data属性，你可以拿它做很多有用的事情。

你可以去读一下HTML5的详细规范，但这个自定义data属性的用法非常的简单，就是你可以往HTML标签上添加任意以 "data-"开头的属性，这些属性页面上是不显示的，它不会影响到你的页面布局和风格，但它却是可读可写的。

下面的一个代码片段是一个有效的HTML5标记：

<pre class="lang:xhtml decode:true " > &lt;div id="awesome" data-myid="3e4ae6c4e"&gt;Some awesome data&lt;/div&gt;</pre> 

可是，怎么来读取这些数据呢？你当然可以遍历页面元素来读取你想要的属性，但jquery已经内置了方法来操作这些属性。使用jQuery的.data()方法来访问这些"data-*" 属性。其中一个方法就是 .data(obj)，这个方法是在 jQuery1.4.3版本后出现的，它能返回相应的data属性。

举个例子，你可以用下面的写法读取 data-myid属性值：

<pre class="lang:js decode:true " > var myid= jQuery("#awesome").data('myid');
console.log(myid);</pre> 

你还可以在"data-*" 属性里使用json语法，例如，如果你写出下面的html：

<pre class="lang:xhtml decode:true " >&lt;div id="awesome-json" data-awesome='{"game":"on"}'&gt;&lt;/div&gt;</pre> 

你可以通过js直接访问这个数据，通过json的key值，你能得到相应的value：

<pre class="lang:js decode:true " >var gameStatus= jQuery("#awesome-json").data('awesome').game;
console.log(gameStatus);</pre> 

你也可以通过.data(key,value)方法直接给"data-*" 属性赋值。一个重要的你要注意的事情是，这些"data-*" 属性应该和它所在的元素有一定的关联，不要把它当成存放任意东西的存储工具。

译者补充：尽管"data-*" 是HTML5才出现的属性，但jquery是通用的，所以，在非HTML5的页面或浏览器里，你仍然可以使用.data(obj)方法来操作"data-*" 数据。

[英文原文：[HTML 5 data-* attributes, how to use them and why](http://blog.mitemitreski.com/2012/06/html-5-data-attributes-how-to-use-it.html) ]