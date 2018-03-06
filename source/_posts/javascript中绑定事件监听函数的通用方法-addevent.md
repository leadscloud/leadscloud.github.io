---
title: javascript中绑定事件监听函数的通用方法 addEvent
tags:
  - JavaScript
id: 313120
categories:
  - HTML/CSS
date: 2011-03-17 10:24:21
---

上篇文章讲到了事件绑定的3中常用方法：传统绑定、W3C绑定方法、IE绑定方法。但是，在实际开发中对于我们来讲重要的是需要一个通用的、跨浏览器的绑定方法。如果我们在互联网上搜索一下会发现许多方法，一下是比较知名的几种方法：

在开始学期下面几种方法之前，应当讨论一下，一个好的addEvent()方法应当达到哪些要求：

a、支持同一元素的同一事件句柄可以绑定多个监听函数；

b、如果在同一元素的同一事件句柄上多次注册同一函数，那么第一次注册后的所有注册都被忽略；

c、函数体内的**this**指向的应当是正在处理事件的节点（如当前正在运行事件句柄的节点）；

d、监听函数的执行顺序应当是按照绑定的顺序执行；

e、在函数体内不用使用 event = event || window.event; 来标准化Event对象；

一、John Resig 所写的 addEvent() 函数：[http://ejohn.org/projects/flexible-javascript-events/](http://ejohn.org/projects/flexible-javascript-events/)
  
```
function addEvent( obj, type, fn ) { 
if ( obj.attachEvent ) { 
        obj['e'+type+fn] = fn; 
        obj[type+fn] = function(){obj['e'+type+fn]( window.event );} 
        obj.attachEvent( 'on'+type, obj[type+fn] ); 
    } else 
        obj.addEventListener( type, fn, false ); 
} 
function removeEvent( obj, type, fn ) { 
if ( obj.detachEvent ) { 
        obj.detachEvent( 'on'+type, obj[type+fn] ); 
        obj[type+fn] = null; 
    } else 
        obj.removeEventListener( type, fn, false ); 
}
```

这个函数如此简单易懂，的确非常令人惊讶。那么我们还是要看看上面的五点要求：

对于第一点满足了；

对于第三点和第五点，肯定也满足了；

对于第二点，并没有满足，因为addEventListener()会忽略重复注册，而attachEvent()则不会忽略；

但是第四点，并没有满足，因为Dom标准没有确定调用一个对象的时间处理函数的顺序，所以不应该想当然的认为它们以注册的顺序调用。

但是这个函数仍然是一个非常优秀的函数。

二、Dean Edward 所写的 addEvent() 函数 ：[http://dean.edwards.name/weblog/2005/10/add-event2/](http://dean.edwards.name/weblog/2005/10/add-event2/)


```
function addEvent(element, type, handler) {
    if (!handler.$$guid) handler.$$guid = addEvent.guid++;
    if (!element.events) element.events = {};
        var handlers = element.events[type];
    if (!handlers) {
        handlers = element.events[type] = {};
        if (element[&quot;on&quot; + type]) {
            handlers[0] = element[&quot;on&quot; + type];
        }
    }
    handlers[handler.$$guid] = handler;
    element[&quot;on&quot; + type] = handleEvent;
}

addEvent.guid = 1;

function removeEvent(element, type, handler) {
    if (element.events &amp;&amp; element.events[type]) {
        delete element.events[type][handler.$$guid];
    }
}
function handleEvent(event) {
    var returnValue = true;
    event = event || fixEvent(window.event);
    var handlers = this.events[event.type];
    for (var i in handlers) {
        this.$$handleEvent = handlers[i];
        if (this.$$handleEvent(event) === false) {
            returnValue = false;
        }
    }
    return returnValue;
};

function fixEvent(event) {
    event.preventDefault = fixEvent.preventDefault;
    event.stopPropagation = fixEvent.stopPropagation;
    return event;
};
fixEvent.preventDefault = function() {
    this.returnValue = false;
};
fixEvent.stopPropagation = function() {
    this.cancelBubble = true;
};
```

该函数使用了传统的绑定方法，所以它可以在所有的浏览器中工作，也不会造成内存泄露。

&#160;&#160;&#160;&#160;&#160;&#160;&#160; 但是对于最初提出的5点，该函数只是满足了前四点。只有最后一点没有满足，因为在JavaScript中对for/in语句的执行顺序没有规定是按照赋值的顺序执行，尽管大部分时刻是按照预期的顺序执行，因此在不同的JavaScript版本或实现中这一语句的顺序有可能不同。

三、Dean Edward 的 addEvent() 函数的改进


```
Array.prototype.indexOf = function( obj ){
    var result = -1 , length = this.length , i=length - 1;
    for ( ; i&gt;=0 ; i-- ) {
        if ( this[i] == obj ) {
            result = i;
            break;
        }
    }
    return result;
}
Array.prototype.contains = function( obj ) {
    return ( this.indexOf( obj ) &gt;=0 )
}
Array.prototype.append = function( obj , nodup ) {
    if ( !(nodup &amp;&amp; this.contains( obj )) ) {
        this[this.length] = obj;
    }
}
Array.prototype.remove = function( obj ) {
    var index = this.indexOf( obj );
    if ( !index ) return ;
    return this.splice( index , 1);
};
function addEvent(element , type , fun){
    if (!element.events) element.events = {};            
    var handlers = element.events[type];
    if (!handlers) {
        handlers = element.events[type] = [];
        if(element['on' + type]) {        
            handlers[0] = element['on' + type];
        }
    }
    handlers.append( fun , true)
    element['on' + type] = handleEvent;
}
function removeEvent(element , type , fun) {
    if (element.events &amp;&amp; element.events[type]) {
        element.events[type].remove(fun); 
    }
}
function handleEvent(event) {
    var returnValue = true , i=0;
    event = event || fixEvent(window.event);
    var handlers = this.events[event.type] , length = handlers.length;
    for ( ; i &lt; length ; i++) {
        if ( handlers[i].call( this , event) === false ){
            returnValue = false;
        }
    }
    return returnValue;
}
function fixEvent(event) {
    event.preventDefault = fixEvent.preventDefault;
    event.stopPropagation = fixEvent.stopPropagation;
    return event;
}
fixEvent.preventDefault = function() {
    this.returnValue = false;
};
fixEvent.stopPropagation = function() {
    this.cancelBubble = true;
};
```

该函数是本人对Dean Edward 的 addEvent() 函数的改进，完全满足了最初提出的5点要求。如果大家有更好的方法，期待分享！

转载自：[http://www.cnblogs.com/rainman/archive/2009/02/11/1387955.html](http://www.cnblogs.com/rainman/archive/2009/02/11/1387955.html)