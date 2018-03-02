---
title: jquery的 $.post 和 $.ajax 的区别
id: 313569
categories:
  - 前端设计
date: 2013-03-05 07:57:39
tags:
---

 $.post 最终还是 $.ajax 实现的.

详见如下：

<pre class="lang:js decode:true " >post: function( url, data, callback, type ) {
		if ( jQuery.isFunction( data ) ) {
			callback = data;
			data = {};
		}

		return jQuery.ajax({
			type: "POST",
			url: url,
			data: data,
			success: callback,
			dataType: type
		});
	},
</pre> 