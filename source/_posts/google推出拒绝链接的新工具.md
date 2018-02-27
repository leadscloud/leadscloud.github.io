---
title: google推出拒绝链接的新工具
id: 313505
categories:
  - Google SEO
date: 2012-10-24 11:19:13
tags:
---

英文版的早就有了，现在终于有翻译的了。不知道效果如何。最近Google对网站惩罚的力度好像越来越大，网站由于大量发链接，是极容易被惩罚的，并且很难出来。几乎是不再有任何反应了。除非你重定向。

发表者：[Jonathan Simon](https://plus.sandbox.google.com/100827970491354551456/posts),网站管理员趋势分析师
原文：[A new tool to disavow link](http://googlewebmastercentral.blogspot.ch/2012/10/a-new-tool-to-disavow-links.html)s

今天我们将要推出的工具让您能够拒绝连接到您网站的链接。如果Google通知您，您的网站由于“非自然链接”而受到了人工处理，那么该工具可以帮助您解决这个问题。如果您没有收到该通知，通常来说您无需使用该工具。

首先大概地介绍一下。链接是我们用以给搜索结果排序的最众所周知的指标之一。通过观察页面之间的链接，我们可以了解哪些网页具有良好声誉和重要性，从而对我们的用户来说更可能具有相关性。这是[PageRank](http://en.wikipedia.org/wiki/PageRank)的基础；PageRank是我们赖以确定排名的超过200种指标中的一种。由于PageRank是如此地众所周知，所以也是垃圾网站的目标，所以我们不断通过各种算法和执行手动操作来打击垃圾链接。

如果您被发现涉及垃圾链接问题，那么您可能已经在网站管理员工具中看到过一条关于指向您的网站的“非自然链接”的消息。当我们发现付费链接、链接交换或其他违反我们[质量指南](http://support.google.com/webmasters/bin/answer.py?hl=zh-cn&amp;answer=35769)的[链接计划](http://support.google.com/webmasters/bin/answer.py?hl=zh-cn&amp;answer=66356)证据时，就会向您发送该消息。如果您收到此消息，我们建议您从网络上尽量删除连接到您网站的垃圾链接或低质量链接。这能从根源上解决问题，所以是最好的办法。通过直接移除这些不良链接，您就是在防止Google（和其他搜索引擎）未来再对您的网站采取人工处理。另外，您这样做也帮助保护了您网站的形象，因为人们再也不会发现网络上有垃圾链接指向您的网站，也就不会对您的网站或业务妄下结论。

如果您为了删除问题链接已经竭尽所能，但还是有一些链接就是无法删除，那么这时不妨看看我们新的[拒绝链接](https://www.google.com/webmasters/tools/disavow-links-main?hl=zh-cn)页面。您到达该页面后，首先要选择您的网站。
<div>[![](https://lh4.googleusercontent.com/-XQqY2Ss7Rjc/UIZdUpbndPI/AAAAAAAAAqM/KvXgjlReRAo/s446/img1.png)](https://lh4.googleusercontent.com/-XQqY2Ss7Rjc/UIZdUpbndPI/AAAAAAAAAqM/KvXgjlReRAo/s446/img1.png)</div>
然后，您会被提示上传一个含有您想要拒绝的链接的文件。
<div>[![](https://lh3.googleusercontent.com/-7N3JGGpxwug/UIZdUpdeBjI/AAAAAAAAAqI/38vy7lnXfdA/s713/img2.png)](https://lh3.googleusercontent.com/-7N3JGGpxwug/UIZdUpdeBjI/AAAAAAAAAqI/38vy7lnXfdA/s713/img2.png)</div>
格式很简单。您所需要的只是一个纯文本文件，每行列一个网址。看起来可能会是下面这样：

# Contacted owner of spamdomain1.com on 7/1/2012 to
# ask for link removal but got no response
domain:spamdomain1.com
# Owner of spamdomain2.com removed most links, but missed these
http://www.spamdomain2.com/contentA.html
http://www.spamdomain2.com/contentB.html
http://www.spamdomain2.com/contentC.html

在这个例子中，以井号（＃）开始的行被认为是评论内容，Google会忽略它们。“domain:”关键字表示您想拒绝来自某个网站（在该示例中，是“spamdomain1.com”网站）所有页面上的的链接。另外，您也可以要求拒绝特定页面上的链接（在该示例中，是spamdomain2.com上的三个单独网页）。目前，我们每个站点支持一个否定文件，该文件为网站管理员工具中的网站所有者共享。如果您希望更新该文件，您需要下载现有文件，对其进行修改，并上传修改后的新文件。文件大小限制为2MB。

网站管理员工具中的“指向您网站的链接”功能是开始寻找不良链接的一个好地方。具体方法是，从网站管理员工具主页开始，先找到您想要的网站，然后选择“流量 &gt; 指向您网站的链接 &gt; 与您的网站链接次数最多的对象&gt; 详细信息，然后单击下载按钮。该文件列出了链接到您的网站的网页。如果您单击“下载最新链接”选项，就会看到日期。这是您开始展开调查的一个好地方，但务必确保别上传关于连接到您网站的链接的完整列表 —— 您肯定不想拒绝全部链接吧！

欲了解有关该功能的更多信息，请查看我们的[帮助中心](http://support.google.com/webmasters/bin/answer.py?hl=zh-cn&amp;answer=2648487)，并欢迎您到我们的[论坛](http://productforums.google.com/forum/#!forum/webmaster-zh-cn)发表意见和提问。