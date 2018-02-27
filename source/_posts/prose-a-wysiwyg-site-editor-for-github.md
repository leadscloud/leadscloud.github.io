---
title: prose-a-wysiwyg-site-editor-for-github
tags:
  - github
  - Prose
id: 313840
categories:
  - 转载
date: 2014-06-09 18:47:51
---

结合静态站点托管服务[Github Pages](http://pages.github.com/)与博客生成工具[Jekyll](https://github.com/mojombo/jekyll)，搭建博客站点，有着部署成本低、易于维护的特点。诚然，[Jekyll](https://github.com/mojombo/jekyll)可以与[Github Pages](http://pages.github.com/)无缝集成，专业人士通过pull request就可以发布内容，但不易用是其最大的问题。[Prose](http://prose.io/)是一个基于[Github Pages](http://pages.github.com/)的[Jekyll](https://github.com/mojombo/jekyll)内容编辑器，它的出现使得内容编辑更快、更方便。

**开通**[**Github Pages**](http://pages.github.com/)**服务**

从[Github](https://github.com)项目首页，点击进入后台管理页面

![](http://infoqstatic.com/resource/news/2012/07/prose-github-content-editor/zh/resources/20120520-dhb4uhf7gx977wfwqbg36wsnxu.png)

**图1：Github项目管理后台入口[<sup>[1]</sup>](#_Ref1)**

点击"Automatic Page Generator"按钮生成站点服务

![](http://infoqstatic.com/resource/news/2012/07/prose-github-content-editor/zh/resources/20120602-cqg5dkfeiqd85m5ghah6k1tnff.png)

**图2：Github项目页面生成器[<sup>[1]</sup>](#_Ref1)**

使用Markdown标记语言编辑站点内容，点击"Continue To Layouts"按钮

![](http://infoqstatic.com/resource/news/2012/07/prose-github-content-editor/zh/resources/page-generator-picker.png)

**图3：Github项目页面预览[<sup>[1]</sup>](#_Ref1)**

预览并发布

![](http://infoqstatic.com/resource/news/2012/07/prose-github-content-editor/zh/resources/page-generator-publish.png)

**图4：Github项目页面发布[<sup>[1]</sup>](#_Ref1)**

到这里，一个[Github](https://github.com)站点就生成了：http://<span style="color: #000000;">{**accountName**}</span>.github.com/{**<span style="color: #000000;">projectName</span>**}

**使用**[**Prose**](http://prose.io/)**所见即所得的编辑特性**

尝试[Prose](http://prose.io/)非常简单，首先通过[Github](https://github.com/)账户身份验证，便可以导航到相应的站点

![](http://infoqstatic.com/resource/news/2012/07/prose-github-content-editor/zh/resources/7441016028_3afa9a6397.jpg)

**图5：Prose验证页面[<sup>[2]</sup>](#_Ref2)**

着陆页会依次列举个人代码库（Repository）

![](http://infoqstatic.com/resource/news/2012/07/prose-github-content-editor/zh/resources/7441015894_f6866937f5.jpg)

**图6：Prose代码库列表[<sup>[2]</sup>](#_Ref2)**

选中之前开通[Github Pages](http://pages.github.com/)服务的代码库，可以浏览相应的文件以及创建新的文本文件

![](http://infoqstatic.com/resource/news/2012/07/prose-github-content-editor/zh/resources/7441016120_903bacee4d.jpg)

**图7：Prose代码库内容列表[<sup>[2]</sup>](#_Ref2)**

编辑内容的时候，[Prose](http://prose.io/)支持Markdown标签的高亮显示

![](http://infoqstatic.com/resource/news/2012/07/prose-github-content-editor/zh/resources/7441016244_3d4d614a25.jpg)

**图8：Prose编辑器高亮特性[<sup>[2]</sup>](#_Ref2)**

任意时刻，都可以点击"Preview"按钮预览当前编辑的内容

![](http://infoqstatic.com/resource/news/2012/07/prose-github-content-editor/zh/resources/7441016420_2c2a215a5f.jpg)

**图9：Prose编辑器预览特性[<sup>[2]</sup>](#_Ref2)**

[**Prose**](http://prose.io/)**附加特性**

在菜单工具条点击"M"按钮，可以获取Markdown标签参考语法列表

![](http://infoqstatic.com/resource/news/2012/07/prose-github-content-editor/zh/resources/synta.jpg)

![](http://infoqstatic.com/resource/news/2012/07/prose-github-content-editor/zh/resources/7441015648_6e0833877a.jpg)

**图10：Prose编辑器Markdown语法参考[<sup>[2]</sup>](#_Ref2)**

在菜单沟工具条点击"Metadata"按钮，可以看到文档的元数据以[YAML](http://www.yaml.org/)的格式展现

![](http://infoqstatic.com/resource/news/2012/07/prose-github-content-editor/zh/resources/meta.jpg)

**图11：Prose编辑器元数据特性[<sup>[2]</sup>](#_Ref2)**

![](http://infoqstatic.com/resource/news/2012/07/prose-github-content-editor/zh/resources/7441015476_2c81e4f182.jpg)

[**Prose**](http://prose.io/)**项目的架构特点与展望**

[Prose](http://prose.io/)的架构实现是以[Backbone](http://backbonejs.org/)与[Jekyll](https://github.com/mojombo/jekyll)为基础，应用托管在[Github](https://github.com/)上，浏览器端直接与[GitHub API](http://developer.github.com/v3/)交互。鉴于浏览器端无法直接与[Github](https://github.com/)通过[OAuth](http://en.wikipedia.org/wiki/OAuth)交互，服务器后端处理用户身份的验证，具体的实现可参照[Gatekeeper](https://github.com/prose/gatekeeper)。

**感兴趣的读者朋友既可以选择**[**Prose**](http://prose.io/)**作为**[**Github**](https://github.com/)**项目博客的内容编辑器，又可以参与**[**Prose**](http://prose.io/)**项目的建设（[<strong>Prose**](http://prose.io/)完全基于[BSD](http://en.wikipedia.org/wiki/BSD_licenses)开源协议），搭建本地开发环境请参照[http://prose.io/help/internals.html](http://prose.io/help/internals.html "http://prose.io/help/internals.html")</strong>。

**引用**

<a name="_Ref1"></a>[1] https://help.github.com/articles/creating-pages-with-the-automatic-generator

<a name="_Ref2"></a>[2] http://developmentseed.org/blog/2012/june/25/prose-a-content-editor-for-github/

原文： http://www.infoq.com/cn/news/2012/07/prose-github-content-editor