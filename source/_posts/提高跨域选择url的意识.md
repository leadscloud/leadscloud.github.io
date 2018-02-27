---
title: 提高跨域选择url的意识
id: 313236
categories:
  - Google SEO
date: 2011-11-30 07:43:00
tags:
---

发表者：Pierre Far，网站管理员趋势分析
原文：[Raising awareness of cross-domain URL selections](http://googlewebmastercentral.blogspot.com/2011/10/raising-awareness-of-cross-domain-url.html)
转载自：[谷歌中文网站管理员博客](http://googlewebmaster-cn.blogspot.com/2011/11/url.html)
发布时间：2011年11月29日 下午 01:57:00

一份内容一般可通过多个URL获得，而非全部集中在同一域名。几年来我们把用多个URL获得同一份内容，称为[重复内容](http://www.google.com/support/webmasters/bin/answer.py?answer=66359)。发现一组重复内容网页时，Google算法会选出一个有代表性的URL。一组网页可能包含来自相同或不同网站的URL。从一组不同的网站中选出有代表性的URL，这种选择就被称为跨域选择。举个简单的例子，如果一组URL中一个来自a网站，一个来自b网站，我们的算法选择了来自b网站的URL，那么a网站的URL就无法再在我们的搜索结果中显示，并且与此内容相关的搜索流量也会下降。

网站管理员通过使用一个目前支持的机制，比如[rel="canonical" elements ](http://www.google.com/support/webmasters/bin/answer.py?answer=139394)或 [301 重定向](http://www.google.com/support/webmasters/bin/answer.py?answer=93633) 来指示他们的首选URL，这在很大程度上影响了我们算法的选择结果。大多情况下，算法做出的选择正确反映了网站管理员的意图。但是在极少情况下，我们发现网站管理员不明白为何算法会做出此种选择，也不知如何处理，他们认为算法的选择是错误的。

为使跨域URL选择过程更透明，我们正在发布新的有关网站管理工具的信息，试图在我们的算法选择了外部URL而非管理员网站的URL时对网站管理员给予提示。这些信息的工作原理细节可在关于[该主题的帮助中心文章](http://www.google.com/support/webmasters/bin/answer.py?answer=1716747&amp;topic=20985)中找到，在本篇博文中我们将探讨各种可能出现跨域URL选择的情况，以及如何修复那些您认为是错误的情况。

引起跨域URL选择的主要原因：

很多情况都会导致我们的算法进行跨域URL选择。

多数情况下，网站管理员会发出能够影响选择结果的信号，我们的算法会根据此信号来选择URL。例如，如果网站管理员按照我们的[指南](http://www.google.com/support/webmasters/bin/answer.py?answer=83105)和[最佳方法](http://www.google.com.hk/ggblog/googlewebmaster-cn/2008/05/blog-post.html)对网站进行迁移，这明显表明新网站的URL才是他们希望Google选择的。如果您正在迁移您的网站并在网站管理工具中看到这些新信息，您可以对我们算法给出的提示予以确认。

不过，我们经常看见网站管理员提交问题说我们的算法选择的URL与他们想选择的不同。当您的网站遇到跨域选择，并且您认为该选择不正确（比如选择结果与您所预想的不符）时，您还可以运用一些策略来进行改善。这里有一些导致预料之外跨域选择URL的常见原因，以及改善方法：

1\. 重复内容，包括多域名网站上的内容：
我们常见到网站管理员在多个域名上使用同种语言和相似的内容。这有时是疏忽所致，有时是以地理区域为标准来决定显示语言种类的。例如，在域名为.com 和.net的网站上，管理员通常会使用英语作为显示语言，而在域名为 .de, .at,和.ch的网站则使用德语作为显示语言。

根据网站和用户的不同，您可以使用一种目前支持的标准化技术来提示算法您希望选择的URL。以下是关于此主题的文章，仅供参考：
* [规范化](http://www.google.com/support/webmasters/bin/answer.py?answer=139066), 尤其是 [rel="canonical" elements](http://www.google.com/support/webmasters/bin/answer.py?answer=139394) 和 [301 重定向](http://www.google.com/support/webmasters/bin/answer.py?answer=93633)
*[ 多域名及多语言网站](http://www.google.com/support/webmasters/bin/answer.py?answer=182192) 以及[管理多区域网站](http://www.google.com.hk/ggblog/googlewebmaster-cn/2010/04/blog-post.html)
* 关于 [rel="alternate" hreflang="x"](http://www.google.com/support/webmasters/bin/answer.py?answer=189077)

2\. 配置错误: 一些错误的配置会使我们算法作出错误决定。出现错误配置的例子包括：

1.标准化错误：错误使用[规范化](http://www.google.com/support/webmasters/bin/answer.py?answer=139066)技术指向外部网站上的URL会使我们的算法在搜索结果中选择外部URL。我们曾在配置错误的内容管理系统（CMS）或网站管理安装的CMS插件上遇到过此类问题。

要修复此类状况，需查清您的网站是如何错误指示规范URL偏好的（例如：通过错误使用了一个rel="canonical"元素或错误使用了301重定向）并进行修复。

2.服务器配置错误：有时我们会遇到主机托管配置错误的情况-a网站内容被返回b网站的URL。当两个无关的网站服务器返回相同[软 404](http://www.google.com/support/webmasters/bin/answer.py?answer=181708) 页面而我们又未能发现此错误网页时，以上类似状况会再次出现。这两种情况中，我们都会认为相同内容正从两个不同网站返回，而我们的算法可能错误地将a网站的URL选做了B网站URL的规范偏好。

您需要调查网站服务基础设施的哪部分配置有误。例如，在遇到错误网页时，您的服务器返回的可能是HTTP 200（成功）状态代码，也可能会混淆其托管的不同域名的要求。一旦查到问题的根本原因，您要和服务器管理员一起矫正配置进行。

3\. 恶性网站攻击：一些网站攻击会引入导致不良标准化的代码。例如，恶性代码可能导致网站返回HTTP 301 重定向 或在HTML 或HTTP header中插入一个跨域rel="canonical" 链接元素，这通常会指向一个托管恶性内容的外部URL。该情况下，我们的算法可能选择恶性或垃圾URL而非默认网站上的URL。

碰到这种情况，请按照我们的[网站清理指南](http://www.google.com/support/webmasters/bin/answer.py?answer=163634)进行操作并在清理完成后递交重新审核请求。如果想要识别[cloaked](http://www.google.com/support/webmasters/bin/answer.py?answer=66355)攻击，您可以使用网站管理工具中的[Googlebot 抓取](http://www.google.com/support/webmasters/bin/answer.py?answer=158587)功能，这样您看到的网页内容便会和在Googlebot上看到的一样。

极少情况下，我们的算法会未经您的允许，就选择那些包含您网站内容的外部网站的URL。如果您认为另一网站复制了您网站上的内容，违反了版权法，请联系网站托管主机，填写[数字千年版权法案](http://www.google.com/support/bin/answer.py?answer=1386831)政策申请删除那些侵权网页。

总之，如果您在如何认定错误原因或修复办法方面需要帮助，您可以浏览我们关于此主题的[帮助中心的文章](http://www.google.com/support/webmasters/bin/answer.py?answer=1716747&amp;topic=20985)并在我们的[网站管理员帮助论坛](http://www.google.com/support/forum/p/webmasters?hl=zh-cn)上提问。