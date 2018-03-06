---
title: privoxy 广告过滤和自动代理切换
tags:
  - privoxy
id: 313599
categories:
  - 转载
date: 2013-06-04 10:24:31
---

最初用Privoxy是因为七星庐的文章[强大的代理调度器代理Privoxy](http://qixinglu.com/archives/powerful_filter_proxy_privoxy "http://qixinglu.com/archives/powerful_filter_proxy_privoxy")，用作代理切换，后来顺便也用起它广告过滤的功能

能实现这两个功能的软件/插件很多，而且用起来往往比privoxy来的方便，比如foxproxy和adblock。我之所以用privoxy是因为以下原因：

* 作为系统的全局自动代理切换器。GNOME和环境变量的代理设置不是对任何软件都管用，PAC也不是哪里都行
* 广告过滤可用于任何浏览器，并且容易定制，改改网页什么的

配置是繁琐些，但用起来确实不错。

安装用源里的就可以，默认是作为系统服务启动的。装好后请将浏览器代理设置为127.0.0.1:8118，以便测试。地址栏输入”p.p”可以查看配置、文档、调试等等。

## 代理切换

配置文件都在/etc/privoxy目录下。编辑config文件，加入一行
`actionsfile pac.action`
这表示添加一个动作文件，文件名是pac.action。在同目录下建立文件”pac.action”，并写入配置。一个示例如下

```
{{alias}}
direct      = +forward-override{forward .}
ssh         = +forward-override{forward-socks5 127.0.0.1:7000 .}
gae         = +forward-override{forward 127.0.0.1:8000} 
default     = direct
#==========默认代理==========
{default}
/
#==========直接连接==========
{direct} 
.edu.cn
202.117.255.
222.24.211.70
#==========SSH代理==========
{ssh}
.launchpad.net
#==========GAE代理==========
{gae}
.webupd8.org
222.24.211.70
```

上面的`{{alias}}`部分定义了一些缩写，注意http代理和socks代理的写法不同。

后面的如{direct}部分定义对哪些地址应用这个代理。其中”/“表示全部地址。注意一个URL的域名部分只能用glob匹配，而地址部分可以用复杂的正则表达式。具体可以看Privoxy的文档

这些规则在后面的会覆盖前面的，比如`222.24.211.70`实际是以gae代理访问的。这样可以实现一些稍微复杂的功能

## 广告过滤

广告过滤用的文件要多些，可能还需要filter文件。先看一个最基本的只使用action文件和block动作的广告过滤。直接编辑user.action文件，添加

```
{+block}
.5622.cn
/.*\.swf$
```

这样5622.cn和所有flash都被阻止了。如果你还想看某些flash视频，可以在后面再-block，这会覆盖前面的设置，如

```
{-block}
static.youku.com/.*\.swf$
```

配合filter文件和action文件，可以实现对网页内容的替换，从而屏蔽某些不想要的内容。先编辑config文件，去掉”filterfile user.filter”这行的注释，然后在同目录下建立user.filter文件，写入

```
FILTER: iframe
s@</head>@<style type="text/css">\n\
    iframe {display:none; !important}\n\
</style>\n$0@
```

这样就定义了一个名为”iframe”的过滤器。之后再编辑user.action文件，添加

```
{+filter{iframe}}
.filestube.com
```

这表明对filestube应用”iframe”这个过滤器。filter书写复杂些

除了过滤广告，还能做做地址转向，比如

```
{+redirect{s@^http://[^/]*/.*?&amp;q=(.*)@http://www.google.com/search?hl=en&amp;q=$1@}}
.google.com.hk/search

{+redirect{s@^http://[^/]*(/$|$)@http://www.google.com/ncr@}}
.google.com.hk/$
```

## 其它内容

<div></div>

### 以普通用户启动

先关掉privoxy服务，可以用sysv-rc-conf或者直接删掉/etc/init.d/privoxy文件。然后将/etc/privoxy目录的内容复制到家目录下，比如~/.privoxy。编辑config文件，将”confdir /etc/privoxy”改为

`confdir /home/用户名/.privoxy`
然后用下面命令启动
`privoxy --no-daemon $HOME/.privoxy/config`


### 有身份验证的代理

先获得”用户名:密码”的base64编码，方法如下

```
perl -e "use MIME::Base64; print encode_base64('用户名:密码');"
```

然后这样写alias

```
proxy = +forward-override{forward 127.0.0.1:808} +add-header{Proxy-authorization: Basic <auth>}
```

将`<auth>`替换为上面得到的base64编码的用户名和密码


## 一个完整的方案

<div>

上面这些文件完全可以精简和清晰，我的目录下只有config、pac.action、user.action、user.filter这四个文件。另外还可以小脚本来切换默认的代理。下面贴出这些配置和切换脚本，略加修改过的，我的配置目录是~/.proxy

*   `config`文件：[http://paste.pocoo.org/show/372744/](http://paste.pocoo.org/show/372744/ "http://paste.pocoo.org/show/372744/")
*   `pac.action`文件：[http://paste.pocoo.org/show/372758/](http://paste.pocoo.org/show/372758/ "http://paste.pocoo.org/show/372758/")
*   `user.action`文件：[http://paste.pocoo.org/show/372759/](http://paste.pocoo.org/show/372759/ "http://paste.pocoo.org/show/372759/")
*   `user.filter`文件：[http://paste.pocoo.org/show/372761/](http://paste.pocoo.org/show/372761/ "http://paste.pocoo.org/show/372761/")
上面的`pac.action`是我在家里用的，学校因为有ipv6等有些不一样：[http://paste.pocoo.org/show/372767/](http://paste.pocoo.org/show/372767/ "http://paste.pocoo.org/show/372767/")

切换脚本：[http://paste.pocoo.org/show/372771/](http://paste.pocoo.org/show/372771/ "http://paste.pocoo.org/show/372771/")

这个脚本是，在家里默认代理`(default)`在`direct`和`gae`之间切换，学校是在paper和gae之间切换。绑定个快捷键会很方便