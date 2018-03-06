---
title: google自定义搜索结果底部空白问题解决方案
tags:
  - Google
id: 313001
categories:
  - HTML/CSS
date: 2011-01-24 06:57:00
---

google 自定义搜索结果底部会出现很高的一部分空白，今天找到两个方法来解决此问题：

```
<form action="search-result.html">
  <fieldset>
    <input type="hidden" name="cx" value="012093381724872904271:tu4gwgmzymc" />
    <input type="hidden" name="cof" value="FORID:10" />
    <input type="hidden" name="ie" value="UTF-8" />
    <input type="text" name="q" size="31" class="form_inputtext" />
    <input type="submit" name="sa" value="Search" class="searchBtn" />
  </fieldset>
</form>

<div id="cse-search-results"></div>
<script type="text/javascript">
	var googleSearchIframeName = "cse-search-results";
	var googleSearchFormName = "cse-search-box";
	var googleSearchFrameWidth = 600;
	var googleSearchDomain = "www.google.com";
	var googleSearchPath = "/cse";
</script>
<script type="text/javascript" src="http://www.google.com/afsonline/show_afs_search.js"></script>
<script type="text/javascript">
	try{document.getElementsByName('googleSearchFrame')[0].height=910;}catch(e){}
</script>
```

```
<script type="text/javascript">
  try{document.getElementsByName('googleSearchFrame')[0].height=910;}catch(e){}
</script>
```


上面的代码可以设置iframe的高度。一般情况下930左右就行了，可自己根据实际调节。

另外一种办法是把http://www.google.com/afsonline/show_afs_search.js下载到本地。CTR+F找到

```
{name:"googleSearchFrame",src:b,frameBorder:a.googleSearchFrameborder,width:c,height:d,
```

把`height:d`,改为`height:930` 你可以自己设置数值。

这是一个例子

[http://www.rockscrusher.com/product/search-result.html?cx=012093381724872904271%3Atu4gwgmzymc&amp;cof=FORID%3A10&amp;ie=UTF-8&amp;q=crusher&amp;sa=&amp;siteurl=www.rockscrusher.com%2F#922](http://www.rockscrusher.com/product/search-result.html?cx=012093381724872904271%3Atu4gwgmzymc&amp;cof=FORID%3A10&amp;ie=UTF-8&amp;q=crusher&amp;sa=&amp;siteurl=www.rockscrusher.com%2F#922)