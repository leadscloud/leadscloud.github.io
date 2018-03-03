---
title: jquery的ajax全局事件详解
tags:
  - Ajax
  - JavaScript
id: 313571
categories:
  - [HTML/CSS]
  - [转载]
date: 2013-03-07 07:08:03
---

jquery在ajax方面是非常强大和方便的，以下是jquery进行ajax请求时方法模板：

```
$.ajax({
    type: "get",
    url: "",
            data : {},
    beforeSend : function(){

    },
    success : function(data){

    },
    complete : function(){

    }
});
```

#### jquery的ajax方法的全部全局事件：

*   ajaxStart：ajax请求开始前
*   ajaxSend：ajax请求时
*   ajaxSuccess：ajax获取数据后
*   ajaxComplete：ajax请求完成时
*   ajaxError：ajax请求发生错误后
*   ajaxStop：ajax请求停止后

当你使用jquery的ajax方法,不管是$.ajax()、$.get()、$.load()、$.getJSON()等都会默认触发全局事件，只是通常不绑定全局事件，但实际上这些全局事件非常有用处。

#### ajax方法的全局事件的用处

ajax全局事件，有个典型的应用场合：
你的页面存在多个甚至为数不少的ajax请求，但是这些ajax请求都有相同的消息机制。ajax请求开始前显示一个提示框，提示“正在读取数据“；ajax请求成功时提示框显示“数据获取成功”；ajax请求结束后隐藏提示框。

**不使用全局事件的做法是：**

给$.ajax()加上beforeSend、success、complete回调函数，在回调函数中加上处理提示框。

**使用全局事件的做法是：**

```
$(document).ajaxStart(onStart)
           .ajaxComplete(onComplete)
           .ajaxSuccess(onSuccess);

function onStart(event) {
    //.....
}
function onComplete(event, xhr, settings) {
    //.....
}
function onSuccess(event, xhr, settings) {
    //.....
}
```

#### ajax方法完整事件流

为了更直观的说明，明河使用Axure画了二个流程图，画的不好还请见谅，O(∩_∩)O
![](http://www.36ria.com/wp-content/uploads/2010/08/ajax-events-1.png "ajax-events-1")
![](http://www.36ria.com/wp-content/uploads/2010/08/ajax-events-2.png "ajax-events-2")

#### ajax方法完整事件流演示

为了让朋友更容易理解整个事件流，明河做了以下demo。

原文：http://www.36ria.com/2882