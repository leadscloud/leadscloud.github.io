---
title: js-设置-cookie
id: 313566
categories:
  - HTML/CSS
date: 2013-03-03 12:39:38
tags:
---

// 以名/值的形式储存cookie
// 同时采用encodeURIComponet()函数进行编码，来转义分号、逗号和空白符
// 如果daysToLive是一个数字，设置max-age属性为该数值表示cookie知道指定的天数
// 到了才会过期。如果daysToLive是0就表示删除cookie
function setCookie(name, value, daysToLive) {
var cookie = name + "=" + encodeURIComponent(value);
if (typeof daysToLive === "number") {
cookie += "; max-age=" + (daysToLive*60*60*24);
}
document.cookie = cookie;
}