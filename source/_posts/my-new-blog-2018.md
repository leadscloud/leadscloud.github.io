---
title: 重新整理下我的个人博客
date: 2018-02-28 16:22:13
tags:
id: 316002
categories:
---


昨天把个人博客迁移到github pages上面了，今天把博客主题重新整理了下。

这个博客从10年到今年，有8年时间了，最近一年因为域名过期，一直也没有整理它，今天把它弄好了，过几天再把之前的域名申请好，然后就可以上线了，未来准备换个域名，时间久了，人也变化很多，等这个域名的权重转移好之后，就可以更换了。

此博客重新上线，放到了github.com上面一份，VPS上面一份，使用了travis自动发布，由于国内域名需要备案，要在国内畅通打开还需要一段时间。

博客涉及到诸多技术问题，有想了解的，可以到[我的github页面](https://github.com/leadscloud/leadscloud.github.io/tree/source)去查看源码，不是特别难，但第一次部署比较麻烦。

## 博客添加RSS功能

### 安装RSS插件

`npm install hexo-generator-feed --save`

### 开启网站 RSS 支持

编辑网站根目录下的 _config.yml，添加以下代码开启

```
# RSS订阅支持
plugin:
- hexo-generator-feed

# Feed Atom
feed:
type: atom
path: atom.xml
limit: 20
```

### 主题开启 RSS 支持

主题不同开启方法不同，我的是 NexT 主题，默认就可以；其他主题请参考主题说明。

### 生成 RSS

执行 hexo clean && hexo g重新生成博客文件完成部署即可。 转载请注明出处，本文采用 CC4.0 协议授权

## 头像生成地址

https://faceyourmanga.com


## 参考资料

https://reuixiy.github.io/technology/computer/computer-aided-art/2017/06/09/hexo-next-optimization.html
https://github.com/willin/hexo-wordcount
[体验GitHub Issues的评论系统——Gitment](https://www.tiexo.cn/gitment/)
https://github.com/iissnan/hexo-theme-next
http://saili.science/2017/04/02/github-for-win/
