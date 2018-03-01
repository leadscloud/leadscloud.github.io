---
title: 如何在hexo博客文章中插入图片
date: 2018-03-01 10:55:26
tags: hexo
id: 316010
categories: 技术
---


## 绝对路径

当Hexo项目中只用到少量图片时，可以将图片统一放在`source/images`文件夹中，通过markdown语法访问它们。

`source/images/image.jpg`

```
![](/images/image.jpg)
```

图片既可以在首页内容中访问到，也可以在文章正文中访问到。

## 相对路径

图片除了可以放在统一的images文件夹中，还可以放在文章自己的目录中。文章的目录可以通过配置_config.yml来生成。

`_config.yml`

```
post_asset_folder: true
```

将`_config.yml`文件中的配置项post_asset_folder设为true后，执行命令`$ hexo new post_name`，在`source/_posts`中会生成文章post_name.md和同名文件夹post_name。将图片资源放在post_name中，文章就可以使用相对路径引用图片资源了。

`_posts/post_name/image.jpg`

```
![](image.jpg)
```

上述是markdown的引用方式，图片只能在文章中显示，但无法在首页中正常显示。

如果希望图片在文章和首页中同时显示，可以使用标签插件语法。

`_posts/post_name/image.jpg`


```
{% asset_img image.jpg This is an image %}
```