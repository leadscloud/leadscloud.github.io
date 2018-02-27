---
title: 也许你还不知道的十二种css特殊选择器
tags:
  - CSS
id: 229001
categories:
  - HTML/CSS
date: 2010-12-02 13:01:20
---

<div>一、X:link&nbsp;X:visited&nbsp;X:hover&nbsp;X:active&nbsp;伪类

  <div>
    <div>a:link&nbsp;{&nbsp;color:&nbsp;red;&nbsp;}

      a:visted&nbsp;{&nbsp;color:&nbsp;purple;&nbsp;}</div>
  </div>

  伪类选择器，visted已被访问过的样式，hover鼠标经过的样式，link未被访问的样式。三种伪类选择器常用于链接，但不是说只适用于链接，可惜的是IE6只支持将这三种伪类选择器作用于链接。

  这里明河说明一点，由于CSS优先级的关系(后面比前面的优先级高)，这几个伪类的书写顺序，一般是link、visted、hover、active。

  二、X&nbsp;+&nbsp;Y&nbsp;相邻选择器

  <div>
    <div>ul&nbsp;+&nbsp;p&nbsp;{

      color:&nbsp;red;

      }</div>
  </div>

  相邻选择器，上述代码中就会匹配在ul后面的第一个p，将段落内的文字颜色设置为红色。(只匹配一个元素)

  三、X&nbsp;&gt;&nbsp;Y&nbsp;子选择器

  子选择器，留意X&nbsp;&gt;&nbsp;Y与X&nbsp;Y的区别，后者是子孙选择器，即无视层级，而X&nbsp;&gt;&nbsp;Y是字选择器，只匹配X下的子元素Y。

  从理论上来讲X&nbsp;&gt;&nbsp;Y是值得提倡选择器，可惜IE6不支持。

  四、X&nbsp;~&nbsp;Y&nbsp;相邻选择器

  <div>

    <div>ul&nbsp;~&nbsp;p&nbsp;{

      color:&nbsp;red;

      }</div>
  </div>

  相邻选择器，与X+Y类似，不同的是X&nbsp;~&nbsp;Y匹配的是元素集合，比如上述代码，匹配的是所有ul相邻的p

  五、X[title]&nbsp;属性选择器

  <div>

    <div>a[title]&nbsp;{

      color:&nbsp;green;

      }</div>
  </div>

  属性选择器，比如上述代码匹配的是带有title属性的链接元素。

  六、X[title=""]&nbsp;另一种属性选择器

  <div>

    <div>a[title="rockscrusher.com"]{

      color:#096;

      }</div>
  </div>

  属性选择器，上述代码不只匹配带有title属性，更匹配title属性等于"rockscrusher.com"的链接元素。[]内不只可用title属性，还可以使用其他属性。

  七、X[title*=""]&nbsp;模糊匹配属性选择器

  <div>

    <div>a[title*="crusher"]{

      color:#096;

      }</div>
  </div>

  加了*号，意味着是模糊匹配，比如上述代码，会匹配title属性为cusher或crusher machine等带有crusher的链接属性。

  八、X[title^=""]&nbsp;另一种模糊匹配属性选择器

  <div>

    <div>a[title^="crusher"]{

      color:#096;

      }</div>
  </div>

  模糊匹配,与*的作用相反，^起到排除的作用，比如上述代码，会匹配title属性不带有crusher的链接属性。

  九、X[href$=""]&nbsp;很实用的属性选择器

  <div>

    <div>a[href$=".png"]&nbsp;{

      color:&nbsp;red;

      }</div>
  </div>

  在属性选择器中多一个$符号，用于匹配结尾为特定字符串的元素，比如上述代码匹配的就是href属性值的结尾为.png的链接。

  十、X[data-*=""]&nbsp;不太常用的属性选择器

  <div>

    <div>a[data-filetype="image"]&nbsp;{

      color:&nbsp;red;

      }</div>
  </div>

  data-filetype这个属性目前用的实在不多，但有些场合非常好用。比如我要匹配所有的数据类型为图片的链接，如果使用X[href$=""]的方式如下：

  <div>

    <div>a[href$=".jpg"],

      a[href$=".jpeg"],

      a[href$=".png"],

      a[href$=".gif"]&nbsp;{

      color:&nbsp;red;

      }</div>
  </div>

  而使用data-filetype，只要：

  <div>

    <div>a[data-filetype="image"]&nbsp;{

      color:&nbsp;red;

      }</div>
  </div>

  当然前提是你给每一个链接加上data-filetype属性。

  十一、X[foo~=""]&nbsp;非常少用的选择器

  <div>

    <div>a[data-info~="external"]&nbsp;{

      color:&nbsp;red;

      }

      a[data-info~="image"]&nbsp;{

      border:&nbsp;1px&nbsp;solid&nbsp;black;

      }</div>
  </div>

  这也是非常少用的选择器，加上~号，有一种情况特别适用，比如你有个data-filetype=”external&nbsp;image”属性，这时候我希望分别针对external和image样式控制。

  <div>

    <div>a[data-info~="external"]&nbsp;{

      color:&nbsp;red;

      }

      a[data-info~="image"]&nbsp;{

      border:&nbsp;1px&nbsp;solid&nbsp;black;

      }</div>
  </div>

  上述代码会匹配data-filetype=”external”、data-filetype=”image”、data-filetype=”external&nbsp;image”的a。

  十二、X:checked&nbsp;另一种伪类选择器

  <div>

    <div>input[type=radio]:checked&nbsp;{

      border:&nbsp;1px&nbsp;solid&nbsp;black;

      }</div>
  </div>

  这个伪类选择器只用于匹配带有checked属性的元素，比如radio、checkbox即单选框和多选框。目前这个伪类选择器，IE9下都不支持，非IE浏览器基本上都支持。</div>