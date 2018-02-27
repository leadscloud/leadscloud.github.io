---
title: 给你的blog添加twitter信息
tags:
  - Twitter
id: 206001
categories:
  - 转载
date: 2010-11-28 07:02:12
---

如果你有一个属于自己的博客（不是在新浪或者网易上免费申请的那种），都会想把自己的各种信息都展示在首页上。比如你的相册，你好友的链接，你的微博信息，当然还有你的Twitter信息。

由于不可说的原因，Twitter被墙了。虽然不能直接访问了，但是哪里有什么就，哪里就有什么，魔高一尺道高一丈。这里介绍一个简单的用PHP获取你的Twitter信息方法，当然前提是你的服务器在墙外，你的博客是基于PHP的。

### PHP Class For Twitter

<div class="php codecolorer"><span class="kw2">class</span> Twitter <span class="br0">{</span>

<span class="kw2">public</span> <span class="re0">$tweets</span> <span class="sy0">=</span> <span class="kw3">array</span><span class="br0">(</span><span class="br0">)</span><span class="sy0">;</span>

<span class="kw2">public</span> <span class="kw2">function</span> __construct<span class="br0">(</span><span class="re0">$user</span><span class="sy0">,</span> <span class="re0">$limit</span> <span class="sy0">=</span> <span class="nu0">5</span><span class="br0">)</span> <span class="br0">{</span>

<span class="re0">$user</span> <span class="sy0">=</span> <span class="kw3">str_replace</span><span class="br0">(</span><span class="st_h">' OR '</span><span class="sy0">,</span> <span class="st_h">'%20OR%20'</span><span class="sy0">,</span> <span class="re0">$user</span><span class="br0">)</span><span class="sy0">;</span>

<span class="re0">$feed</span> <span class="sy0">=</span> <span class="kw3">curl_init</span><span class="br0">(</span><span class="st_h">'http://search.twitter.com/search.atom?q=from:'</span><span class="sy0">.</span> <span class="re0">$user</span> <span class="sy0">.</span><span class="st_h">'&amp;rpp='</span><span class="sy0">.</span> <span class="re0">$limit</span><span class="br0">)</span><span class="sy0">;</span>

<span class="kw3">curl_setopt</span><span class="br0">(</span><span class="re0">$feed</span><span class="sy0">,</span> CURLOPT_RETURNTRANSFER<span class="sy0">,</span> <span class="kw4">true</span><span class="br0">)</span><span class="sy0">;</span>

<span class="kw3">curl_setopt</span><span class="br0">(</span><span class="re0">$feed</span><span class="sy0">,</span> CURLOPT_HEADER<span class="sy0">,</span> <span class="nu0">0</span><span class="br0">)</span><span class="sy0">;</span>

<span class="re0">$xml</span> <span class="sy0">=</span> <span class="kw3">curl_exec</span><span class="br0">(</span><span class="re0">$feed</span><span class="br0">)</span><span class="sy0">;</span>

<span class="kw3">curl_close</span><span class="br0">(</span><span class="re0">$feed</span><span class="br0">)</span><span class="sy0">;</span>

<span class="re0">$result</span> <span class="sy0">=</span> <span class="kw2">new</span> SimpleXMLElement<span class="br0">(</span><span class="re0">$xml</span><span class="br0">)</span><span class="sy0">;</span>

<span class="kw1">foreach</span><span class="br0">(</span><span class="re0">$result</span><span class="sy0">-&gt;</span><span class="me1">entry</span> <span class="kw1">as</span> <span class="re0">$entry</span><span class="br0">)</span> <span class="br0">{</span>

<span class="re0">$tweet</span> <span class="sy0">=</span> <span class="kw2">new</span> stdClass<span class="br0">(</span><span class="br0">)</span><span class="sy0">;</span>

<span class="re0">$tweet</span><span class="sy0">-&gt;</span><span class="me1">id</span> <span class="sy0">=</span> <span class="br0">(</span>string<span class="br0">)</span> <span class="re0">$entry</span><span class="sy0">-&gt;</span><span class="me1">id</span><span class="sy0">;</span>

<span class="re0">$user</span> <span class="sy0">=</span> <span class="kw3">explode</span><span class="br0">(</span><span class="st_h">' '</span><span class="sy0">,</span> <span class="re0">$entry</span><span class="sy0">-&gt;</span><span class="me1">author</span><span class="sy0">-&gt;</span><span class="me1">name</span><span class="br0">)</span><span class="sy0">;</span>

<span class="re0">$tweet</span><span class="sy0">-&gt;</span><span class="me1">user</span> <span class="sy0">=</span> <span class="br0">(</span>string<span class="br0">)</span> <span class="re0">$user</span><span class="br0">[</span><span class="nu0">0</span><span class="br0">]</span><span class="sy0">;</span>

<span class="re0">$tweet</span><span class="sy0">-&gt;</span><span class="me1">author</span> <span class="sy0">=</span> <span class="br0">(</span>string<span class="br0">)</span> <span class="kw3">substr</span><span class="br0">(</span><span class="re0">$entry</span><span class="sy0">-&gt;</span><span class="me1">author</span><span class="sy0">-&gt;</span><span class="me1">name</span><span class="sy0">,</span> <span class="kw3">strlen</span><span class="br0">(</span><span class="re0">$user</span><span class="br0">[</span><span class="nu0">0</span><span class="br0">]</span><span class="br0">)</span><span class="sy0">+</span><span class="nu0">2</span><span class="sy0">,</span> <span class="sy0">-</span><span class="nu0">1</span><span class="br0">)</span><span class="sy0">;</span>

<span class="re0">$tweet</span><span class="sy0">-&gt;</span><span class="me1">title</span> <span class="sy0">=</span> <span class="br0">(</span>string<span class="br0">)</span> <span class="re0">$entry</span><span class="sy0">-&gt;</span><span class="me1">title</span><span class="sy0">;</span>

<span class="re0">$tweet</span><span class="sy0">-&gt;</span><span class="me1">content</span> <span class="sy0">=</span> <span class="br0">(</span>string<span class="br0">)</span> <span class="re0">$entry</span><span class="sy0">-&gt;</span><span class="me1">content</span><span class="sy0">;</span>

<span class="re0">$tweet</span><span class="sy0">-&gt;</span><span class="me1">updated</span> <span class="sy0">=</span> <span class="br0">(</span>int<span class="br0">)</span> <span class="kw3">strtotime</span><span class="br0">(</span><span class="re0">$entry</span><span class="sy0">-&gt;</span><span class="me1">updated</span><span class="br0">)</span><span class="sy0">;</span>

<span class="re0">$tweet</span><span class="sy0">-&gt;</span><span class="me1">permalink</span> <span class="sy0">=</span> <span class="br0">(</span>string<span class="br0">)</span> <span class="re0">$entry</span><span class="sy0">-&gt;</span><span class="me1">link</span><span class="br0">[</span><span class="nu0">0</span><span class="br0">]</span><span class="sy0">-&gt;</span><span class="me1">attributes</span><span class="br0">(</span><span class="br0">)</span><span class="sy0">-&gt;</span><span class="me1">href</span><span class="sy0">;</span>

<span class="re0">$tweet</span><span class="sy0">-&gt;</span><span class="me1">avatar</span> <span class="sy0">=</span> <span class="br0">(</span>string<span class="br0">)</span> <span class="re0">$entry</span><span class="sy0">-&gt;</span><span class="me1">link</span><span class="br0">[</span><span class="nu0">1</span><span class="br0">]</span><span class="sy0">-&gt;</span><span class="me1">attributes</span><span class="br0">(</span><span class="br0">)</span><span class="sy0">-&gt;</span><span class="me1">href</span><span class="sy0">;</span>

<span class="kw3">array_push</span><span class="br0">(</span><span class="re0">$this</span><span class="sy0">-&gt;</span><span class="me1">tweets</span><span class="sy0">,</span> <span class="re0">$tweet</span><span class="br0">)</span><span class="sy0">;</span>

<span class="br0">}</span>

<span class="kw3">unset</span><span class="br0">(</span><span class="re0">$feed</span><span class="sy0">,</span> <span class="re0">$xml</span><span class="sy0">,</span> <span class="re0">$result</span><span class="sy0">,</span> <span class="re0">$tweet</span><span class="br0">)</span><span class="sy0">;</span>

<span class="br0">}</span>

<span class="kw2">public</span> <span class="kw2">function</span> getTweets<span class="br0">(</span><span class="br0">)</span> <span class="br0">{</span> <span class="kw1">return</span> <span class="re0">$this</span><span class="sy0">-&gt;</span><span class="me1">tweets</span><span class="sy0">;</span> <span class="br0">}</span>

<span class="br0">}</span></div>

如何使用：
<div class="php codecolorer"><span class="kw1">echo</span> <span class="st_h">'&lt;ul&gt;'</span><span class="sy0">;</span>

<span class="kw1">foreach</span> <span class="br0">(</span><span class="re0">$tweets</span> <span class="kw1">as</span> <span class="re0">$tweet</span><span class="br0">)</span> <span class="br0">{</span>

<span class="kw1">echo</span> <span class="st_h">'&lt;li&gt;'</span><span class="sy0">.</span> <span class="re0">$tweet</span><span class="sy0">-&gt;</span><span class="me1">content</span> <span class="sy0">.</span><span class="st_h">' by &lt;a href="http://twitter.com/'</span><span class="sy0">.</span> <span class="re0">$tweet</span><span class="sy0">-&gt;</span><span class="me1">user</span> <span class="sy0">.</span><span class="st_h">'"&gt;'</span><span class="sy0">.</span> <span class="re0">$tweet</span><span class="sy0">-&gt;</span><span class="me1">author</span> <span class="sy0">.</span><span class="st_h">'&lt;/a&gt;&lt;/li&gt;'</span><span class="sy0">;</span>

<span class="br0">}</span>

<span class="kw1">echo</span> <span class="st_h">'&lt;/ul&gt;'</span><span class="sy0">;</span></div>

‘jun1st’是你的Twitter用户名，5是此次获取的tweet的数目。传入的user可以是多个的，用’OR’链接，比如’jun1st OR jun2nd’

从类中可以看到，你可以从$tweet中获取id，发布时间，Avatar等数据

文章来源：[Twitter Integration Class Using PHP5 and cURL](http://blog.spookyismy.name/2010/05/18/twitter-integration-class-using-php5-and-curl/)