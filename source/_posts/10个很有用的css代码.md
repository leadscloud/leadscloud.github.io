---
title: 10个很有用的css代码
id: 313179
categories:
  - HTML/CSS
date: 2011-07-30 06:36:07
tags:
---

**1\. 页面居中**
 HTML

<pre class="brush: css">   &lt;div class="wrap"&gt;  &lt;/div&gt;&lt;!-- end wrap --&gt;</pre>

CSS

<pre class="brush: css">  .wrap { width:960px; margin:0 auto;}</pre>

**2\. 固定页脚**（不通过绝对定位使页脚始终固定在底部）
 HTML

<pre class="brush: css"> &lt;div id="wrap"&gt;
   &lt;div id="main" class="clearfix"&gt; &lt;/div&gt;
 &lt;/div&gt;
 &lt;div id="footer"&gt; &lt;/div&gt;</pre>

CSS

<pre class="brush: css">  * { margin:0; padding:0; } 
  html, body, #wrap { height: 100%; }
  body &gt; #wrap {height: auto; min-height: 100%;}
  #main { padding-bottom: 150px; }  /* must be same height as the footer */
  #footer {
     position: relative;
     margin-top: -150px; /* negative value of footer height */
     height: 150px;
     clear:both;
  } 

  /* CLEAR FIX*/
  .clearfix:after {content: ".";
   display: block;
   height: 0;
   clear: both;
   visibility: hidden;}
  .clearfix {display: inline-block;}
  /* Hides from IE-mac */
  * html .clearfix { height: 1%;}
  .clearfix {display: block;}
  /* End hide from IE-mac */</pre>

**3\. 跨浏览器实现最小高**

<pre class="brush: css">  .element { 
    min-height:600px; 
    height:auto !important; 
    height:600px; 
  }</pre>

**4\. 区块阴影效果**

<pre class="brush: css">  .box { 
    box-shadow: 5px 5px 5px #666;  
    -moz-box-shadow: 5px 5px 5px #666;  
    -webkit-box-shadow: 5px 5px 5px #666; 
  }</pre>

**5\. 文字阴影效果及IE下的Hack**

<pre class="brush: css">  .text { 
    text-shadow: 1px 1px 1px #666; 
    filter: Shadow(Color=#666666, Direction=135, Strength=5); 
  }</pre>

**6\. 跨浏览器CSS透明效果**

<pre class="brush: css">  .transparent {    
    /* Modern Browsers */ opacity: 0.7;  
    /* IE 8 */ -ms-filter: "progid:DXImageTransform.Microsoft.Alpha(Opacity=70)";
    /* IE 5-7 */ filter: alpha(opacity=70);
    /* Netscape */ -moz-opacity: 0.7;
    /* Safari 1 */ -khtml-opacity: 0.7;    
  }</pre>

**7\. 重置CSS， 著名的Meyer Reset**

<pre class="brush: css">html, body, div, span, applet, object, iframe,
h1, h2, h3, h4, h5, h6, p, blockquote, pre,
a, abbr, acronym, address, big, cite, code,
del, dfn, em, font, img, ins, kbd, q, s, samp,
small, strike, strong, sub, sup, tt, var,
dl, dt, dd, ol, ul, li,
fieldset, form, label, legend,
table, caption, tbody, tfoot, thead, tr, th, td {
 margin: 0;
 padding: 0;
 border: 0;
 outline: 0;
 font-weight: inherit;
 font-style: inherit;
 font-size: 100%;
 font-family: inherit;
 vertical-align: baseline;
}
/* remember to define focus styles! */
:focus {
 outline: 0;
}
body {
 line-height: 1;
 color: black;
 background: white;
}
ol, ul {
 list-style: none;
}
/* tables still need 'cellspacing="0"' in the markup */
table {
 border-collapse: separate;
 border-spacing: 0;
}
caption, th, td {
 text-align: left;
 font-weight: normal;
}
blockquote:before, blockquote:after,
q:before, q:after {
 content: "";
}
blockquote, q {
 quotes: "" "";
}</pre>

**8\. 移除点线外边框**

<pre class="brush: css">  a, a:active { outline: none; }</pre>

**9\. 圆角CSS（非IE）**

<pre class="brush: css"> .element {
   -moz-border-radius: 5px;
   -webkit-border-radius: 5px;
   border-radius: 5px; /* future proofing */
  }
  .element-top-left-corner {
   -moz-border-radius-topleft: 5px;
   -webkit-border-top-left-radius: 5px;
  }</pre>

**10\. 使用!important 重写行内样式**

<pre class="brush: css">  .override {
     font-size: 14px !important;
  }</pre>

**
**