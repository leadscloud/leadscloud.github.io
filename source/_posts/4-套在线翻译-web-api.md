---
title: 4 套在线翻译 web api
tags:
  - Google
  - Google翻译
id: 279001
categories:
  - Google SEO
date: 2011-01-05 13:07:06
---

在线自动翻译不再是神话，虽然机器的翻译质量仍不能和专业翻译人员相提并论，但已经发展到可以让人大体理解的地步，目前，最著名的4个翻译引擎包括Google Translate, Babel Fish, Promt or FreeTranslations，其中 GoogleTranslate 发展最为迅猛，本文介绍4个在线翻译 Web API，它们绝大多数都基于 Google Translate。

![](http://images.sixrevisions.com/2010/01/25-01_translation_on_the_web.png)

### [Google  Translate Tools ](http://translate.google.com/translate_tools)

![Google Translate Tools ](http://images.sixrevisions.com/2010/01/25-02_google_translate_tools.png)

首先，[Google  Translate](http://translate.google.com/translate_tools) 提供了一个简单的 widget，你可以直接将这个 widget 复制粘贴到你的 Web 页面，这个 widget 会显示一个 52 种语言的下拉菜单，选中相应语言，用户会被重定向到 [translate.google.com](http://translate.google.com/) 进行翻译，并看到前页的翻译结果。

虽然这个 widget 很简单，但缺点是有点过时，而且，用户会被重定向到 Google 站点，用户的访问体验会被打断。

译者注：事实上，除了这个简单的 widget ，Google 还提供一整套非常强大的[翻译 API](http://code.google.com/apis/ajaxlanguage/documentation/)，基于这套 API 你可以设计出非常好用的在线翻译工具。以下的第三方翻译 API 都是基于 Google 翻译 API。

### [The TranslateThis Button ](http://translateth.is/)

![The TranslateThis Button ](http://images.sixrevisions.com/2010/01/25-03_translate_this_button.png)

Google Translate Tools 的一个替代品是 [The  TranslateThis Button](http://translateth.is/)。这也是一个翻译 widget，可以被复制粘贴到你的网页，该 widget 基于 Google 翻译 API，因此，也提供52种语言的翻译，但用户界面更漂亮一些，使用了灯箱式对话框，现实不同语种的图标，更重要的是它不会将用户重定向到 Google 站点。

该 widget 使用 JavaScript，将 Google 的翻译结果替换到当前页面，它的速度也很不错。整个 API 的尺寸不少过12 k，相当小巧。

[阅读该 API 文档和更多资料](http://translateth.is/docs)

### [jQuery  Translate Plugin ](http://code.google.com/p/jquery-translate/)

![jQuery Translate Plugin ](http://images.sixrevisions.com/2010/01/25-04_jquery_logo.png)

另一个客户端翻译 API 为 [jQuery Translate   Plugin](http://code.google.com/p/jquery-translate/)。这个 API 也是对当前页面内容进行识别，并用 JavaScript 送到 Google 翻译 API 那里翻译。

该 API 的优点是，它可以将多段分散的文本连起来，一次性送给 Google 翻译 API进行翻译，这样可以显著降低请求的次数，不过它的速度比 TranslateThis Button 慢，而且，即使不考虑 jQuery框架的尺寸，单纯这个插件的尺寸也和 TranslateThis 一样大。

### [Global  Translator (Wordpress)](http://wordpress.org/extend/plugins/global-translator/)

![Global Translator (Wordpress)](http://images.sixrevisions.com/2010/01/25-05_wordpress_logo.png)

客户端的翻译 API 速度很快，也容易部署，但，如果你的站点流量很大，为了提高性能，因该考虑服务器端的翻译API。

Davide Pozza 设计的 [Global   Translator](http://wordpress.org/extend/plugins/global-translator/)是一个 WordPress 插件，可以为任何基于 WordPress 的站点提供 41 个语种的翻译，它的功能包括快速缓存以及 SEO友好的静态永久链接，另外，该API允许你选用4种不同的翻印引擎，包括  Google Translate, Babel Fish, Promtor FreeTranslations。

### 在线翻译将何去何从？

自动在线翻译近年来获得长足发展，并变得越来越好，Google 翻译 API 支持的语种越来越多，而翻译质量已经速度也在稳步提高。

将来，Google 有可能允许更长的文本提交到他们的 API，目前是 1000 字，如果提高到 2000 字，那些基于它的 API 的速度可能会明显提高。

另外，Google 翻译最近又推出了 [Text   to Speech](http://googleblog.blogspot.com/2009/11/new-look-for-google-translate.html) 支持，Weston Ruter 还推出了一个[基于该 API 和 HTML5  音频标签的脚本](http://weston.ruter.net/projects/google-tts/)。

本文国际来源：[http://sixrevisions.com/tools/reach-a-larger-audience-with-content-translation-tools/](http://sixrevisions.com/tools/reach-a-larger-audience-with-content-translation-tools/)