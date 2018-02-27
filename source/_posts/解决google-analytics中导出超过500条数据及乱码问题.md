---
title: 解决google-analytics中导出超过500条数据及乱码问题
tags:
  - Google Analytics
id: 313115
categories:
  - 前端设计
date: 2011-03-11 07:35:19
---

Google analytics支持将报告中的数据以四种格式导出：PDF - 便携式文档格式；XML - 可扩展标记语言；Excel (CSV,CSV for Excel)- 逗号分隔值；TSV - 制表符分隔值。但在导出时，Google analytics只提供了10，25，50，100，250和500六种等级供选择。并且限制一次最多只能导出500条数据。

们可以通过修改google导出数据的URL来自定义导出的数量，并突破500条的限制，一次性导出500条以上数据。下面具体介绍一下如何操作。

1、打开要导出数据的报告。

2、点击顶部的Export，选择导出格式。

3、复制CSV的链接，粘贴在新窗口并在URL最后增加&quot;&amp;limit=5000&rdquo;参数 

![](http://love4026.files.wordpress.com/2011/03/ga-csv.jpg)

4、在该窗口地址栏的URL中找到&ldquo;&amp;trows=10&rdquo;参数。

https://www.google.com/analytics/reporting/export?******* &amp;trows=10*******

5、将trows=后面的数字修改成你想要导出的数量，<span class="Apple-style-span" style="color: rgb(51, 51, 51); font-family: 'Lucida Grande', Arial, Helvetica, sans-serif; line-height: 18px; ">（最多500条）</span>

6、确定后，该窗口重新弹出保存文件对话框。选择文件保存路径后，开始下载导出的报告。

&nbsp;

<span class="Apple-style-span" style="font-family: 'Lucida Grande', Arial, Helvetica, sans-serif; color: rgb(0, 0, 0); ">**一次导出50000条数据的步骤是：**</span>

<span class="Apple-style-span" style="font-family: 'Lucida Grande', Arial, Helvetica, sans-serif; color: rgb(0, 0, 0); ">1打开要导出数据的报告。</span>

<span class="Apple-style-span" style="font-family: 'Lucida Grande', Arial, Helvetica, sans-serif; color: rgb(0, 0, 0); ">2点击顶部的Export，选择CSV格式。</span>

<span class="Apple-style-span" style="font-family: 'Lucida Grande', Arial, Helvetica, sans-serif; color: rgb(0, 0, 0); ">3点击CSV格式导出后，google会新打开一个窗口，并弹出保存文件的对话框。</span>

<span class="Apple-style-span" style="font-family: 'Lucida Grande', Arial, Helvetica, sans-serif; color: rgb(0, 0, 0); ">4关闭保存文件的对话框，在该窗口地址栏的URL尾部加参数&ldquo;**<span style="margin-top: 0px; margin-right: 0px; margin-bottom: 0px; margin-left: 0px; padding-top: 0px; padding-right: 0px; padding-bottom: 0px; padding-left: 0px; border-top-width: 0px; border-right-width: 0px; border-bottom-width: 0px; border-left-width: 0px; border-style: initial; border-color: initial; font-weight: inherit; font-style: inherit; font-size: 12px; font-family: inherit; vertical-align: baseline; color: rgb(255, 0, 0); ">&amp;limit=50000</span>&rdquo;**。</span>

<span class="Apple-style-span" style="font-family: 'Lucida Grande', Arial, Helvetica, sans-serif; color: rgb(0, 0, 0); ">https://www.google.com/analytics/reporting/export?*****************<span style="margin-top: 0px; margin-right: 0px; margin-bottom: 0px; margin-left: 0px; padding-top: 0px; padding-right: 0px; padding-bottom: 0px; padding-left: 0px; border-top-width: 0px; border-right-width: 0px; border-bottom-width: 0px; border-left-width: 0px; border-style: initial; border-color: initial; font-weight: inherit; font-style: inherit; font-size: 12px; font-family: inherit; vertical-align: baseline; color: rgb(255, 0, 0); ">**&amp;limit=50000**</span></span>

<span class="Apple-style-span" style="font-family: 'Lucida Grande', Arial, Helvetica, sans-serif; color: rgb(0, 0, 0); ">5确定后，该窗口重新弹出保存文件对话框。选择保存文件保存路径，开始下载导出的报告。</span>

目前导出的限制是20000行。如果你需要更多行，那么，先导出前20000行，然后，查看第20000行,，最后再导出。

这也是网上最常见的方法。如果你是用英文语言界面，并且看的是URL相关报告，那么是不会碰到中文乱码问题的。对于一些需要导出关键字报告的朋友来说，就会碰到乱码问题。凡不是英文字符都会是乱码显示，需要用excel的导入文本功能把刚才导出的csv文件再导入，如下图（新建个工作表）：

![](http://love4026.files.wordpress.com/2011/03/ga-excel.jpg)

分隔符号选择逗号

![](http://love4026.files.wordpress.com/2011/03/ga-excel2.jpg)

这样导入就不会有乱码了。