---
title: 常用js函数汇总
tags:
  - JavaScript
  - JS
id: 313110
categories:
  - 前端设计
date: 2011-02-28 13:27:41
---

<pre class="brush: js">//http://www.robertnyman.com/2005/11/07/the-ultimate-getelementsbyclassname/
function getElementsByClassName(oElm, strTagName, strClassName){
	var arrElements = (strTagName == &quot;*&quot; &amp;&amp; oElm.all)? oElm.all : oElm.getElementsByTagName(strTagName);
	var arrReturnElements = new Array();
	strClassName = strClassName.replace(/\-/g, &quot;\\-&quot;);
	var oRegExp = new RegExp(&quot;(^|\\s)&quot; + strClassName + &quot;(\\s|$)&quot;);
	var oElement;
	for(var i=0; i&lt;arrElements.length; i++){
		oElement = arrElements[i];		
		if(oRegExp.test(oElement.className)){
			arrReturnElements.push(oElement);
		}	
	}
	return (arrReturnElements)
}

//http://www.bigbold.com/snippets/posts/show/2630
function addClassName(objElement, strClass, blnMayAlreadyExist){
   if ( objElement.className ){
      var arrList = objElement.className.split(' ');
      if ( blnMayAlreadyExist ){
         var strClassUpper = strClass.toUpperCase();
         for ( var i = 0; i &lt; arrList.length; i++ ){
            if ( arrList[i].toUpperCase() == strClassUpper ){
               arrList.splice(i, 1);
               i--;
             }
           }
      }
      arrList[arrList.length] = strClass;
      objElement.className = arrList.join(' ');
   }
   else{  
      objElement.className = strClass;
      }
}

//http://www.bigbold.com/snippets/posts/show/2630
function removeClassName(objElement, strClass){
   if ( objElement.className ){
      var arrList = objElement.className.split(' ');
      var strClassUpper = strClass.toUpperCase();
      for ( var i = 0; i &lt; arrList.length; i++ ){
         if ( arrList[i].toUpperCase() == strClassUpper ){
            arrList.splice(i, 1);
            i--;
         }
      }
      objElement.className = arrList.join(' ');
   }
}

//http://ejohn.org/projects/flexible-javascript-events/
function addEvent( obj, type, fn ) {
  if ( obj.attachEvent ) {
    obj[&quot;e&quot;+type+fn] = fn;
    obj[type+fn] = function() { obj[&quot;e&quot;+type+fn]( window.event ) };
    obj.attachEvent( &quot;on&quot;+type, obj[type+fn] );
  } 
  else{
    obj.addEventListener( type, fn, false );	
  }
}
//http://www.quirksmode.org/dom/getstyles.html
function getStyle(el,styleProp)
{
	var x = document.getElementById(el);
	if (x.currentStyle)
		var y = x.currentStyle[styleProp];
	else if (window.getComputedStyle)
		var y = document.defaultView.getComputedStyle(x,null).getPropertyValue(styleProp);
	return y;
}

//判断浏览器
var isFF=(navigator.userAgent.toLowerCase().indexOf(&quot;firefox&quot;)!=-1);
var isIE=(navigator.userAgent.toLowerCase().indexOf(&quot;msie&quot;)!=-1);
var isIE8=(navigator.userAgent.toLowerCase().indexOf(&quot;msie 8&quot;)!=-1);</pre>