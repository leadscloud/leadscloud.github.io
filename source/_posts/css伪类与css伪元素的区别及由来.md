---
title: css伪类与css伪元素的区别及由来
id: 313590
categories:
  - 转载
date: 2013-04-15 06:10:56
tags:
---

关于两者的区别，其实是很古老的问题。但是时至今日，由于各种网络误传以及一些不负责任的书籍误笔，仍然有相当多的人将伪类与伪元素混为一谈，甚至不乏很多CSS老手。早些年刚入行的时候，我自己也被深深误导，因为论坛里的帖子大多不关心这种概念的细微差别，即使有人出来说一句：“这两个是不同的”，也只是被更多的帖子淹没掉而已。所以觉得有必要写下这些我所知的部分，这里着重写的是**为什么**这两者不同，以及一些平时容易错过的细节。

无论是**伪类**还是**伪元素**，都属于CSS选择器的范畴。所以它们的定义可以在CSS标准的选择器章节找到。分别是 [CSS2.1 Selectors](http://www.w3.org/TR/CSS2/selector.html) 和 [CSS Selector Level 3](http://www.w3.org/TR/selectors/)，两者都已经是推荐标准。

## 标准的定义

在CSS2.1里，[5.10 Pseudo-elements and pseudo-classes](http://www.w3.org/TR/CSS2/selector.html#pseudo-elements) 描述了这两个概念的由来，它们是被一同提及的。但到了 Selector Level 3 里，它们就被分开到两个小节里加以区分。但无论如何，伪类和伪元素的引入都是因为在文档树里有些信息无法被充分描述，比如CSS没有“段落的第一行”之类的选择器，而这在一些出版场景里又是必须的。用标准里的话说：
> CSS introduces the concepts of pseudo-elements and pseudo-classes to permit formatting based on information that lies outside the document tree.
简单翻译一下，就是：
> CSS 引入伪类和伪元素的概念是为了实现基于文档树之外的信息的格式化
这么说很抽象，其实就是为了描述一些现有CSS无法描述的东西。缺少什么，则引入什么，不管是标准，还是人，都是如此成长而来。

## 伪类与伪元素的区别

这里我大可以列一个表格，把所有的伪类和伪元素分开罗列，但这未免太形式化，与其记住“哪些是哪些不是”，不如真正地加以区分。伪类和伪元素本身就有一个根本的不同之处，这点直接体现在了标准的描述语句上。

先看一个伪元素 `first-line` 例子。现在有一段HTML，内容是一个段落：

<pre class="lang:xhtml decode:true " >&lt;p&gt;I am the bone of my sword. Steel is my body, and fire is my blood. 
I have created over a thoustand blades. 
Unknown to Death.Nor known to Life. Have withstood pain to create many weapon. 
Yet, those hands will never hold anything. So as I pray, unlimited blade works.&lt;/p&gt;</pre> 

如果我要描述这个段落的第一行，在不用伪元素的情况下，我会怎么做？想来我一定要嵌套一层 `span`，然后加上类名:

<pre class="lang:xhtml decode:true " >&lt;p&gt;&lt;span class="first-line"&gt;I am the bone of my sword. Steel is my body, and fire is my blood. &lt;/span&gt; 
I have created over a thoustand blades.
Unknown to Death.Nor known to Life. Have withstood pain to create many weapon. 
Yet, those hands will never hold anything. So as I pray, unlimited blade works.&lt;/p&gt;</pre> 

再反观一个伪类 `first-child` 的例子，有一个简单的列表：

<pre class="lang:xhtml decode:true " >&lt;ul&gt;
	&lt;li&gt;&lt;/li&gt;
	&lt;li&gt;&lt;/li&gt;
&lt;/ul&gt;</pre> 

如果我要描述 `ul` 的第一个元素，我无须嵌套新的元素，我只须给第一个已经存在的 `li` 添加一个类名就可以了：

<pre class="lang:xhtml decode:true " >&lt;ul&gt;
	&lt;li class="first-child"&gt;&lt;/li&gt;
	&lt;li&gt;&lt;/li&gt;
&lt;/ul&gt;</pre> 

尽管，**第一行**和**第一个元素**，这两者的语意相似，但最后作用的效果却完全不同。所以，伪类和伪元素的根本区别在于：**它们是否创造了新的元素(抽象)**。从我们模仿其意义的角度来看，如果需要添加新元素加以标识的，就是伪元素，反之，如果只需要在既有元素上添加类别的，就是伪类。而这也是为什么，标准精确地使用 “create” 一词来解释伪元素，而使用 “classify” 一词来解释伪类的原因。一个描述的是新创建出来的“幽灵”元素，另一个则是描述已经存在的符合“幽灵”类别的元素。

**伪类**一开始单单只是用来表示一些元素的动态状态，典型的就是链接的各个状态(LVHA)。随后CSS2标准扩展了其概念范围，使其成为了所有逻辑上存在但在文档树中却无须标识的“幽灵”分类。

**伪元素**则代表了某个元素的子元素，这个子元素虽然在逻辑上存在，但却并不实际存在于文档树中。

## 伪类和伪元素混淆的由来

最为混淆的，可能是大部分人都将 `:before` 和 `:after `这样的伪元素随口叫做伪类，而且即使在概念混淆的情况下，实际使用上也毫无问题——因为即使概念混淆，对真正使用也不会造成多少麻烦:)

CSS Selector Level 3 为了区分这两者的混淆，而特意用冒号加以区分：

*   伪类用一个冒号表示 `:first-child`
*   伪元素则使用两个冒号表示 `::first-line`
并且规定，浏览器既要兼容CSS1和2里既存的伪元素的单冒号表示，同时又要不兼容CSS3新引入的伪元素的单冒号表示。后来的结果大家都知道，因为低版本IE对双冒号的兼容问题，几乎所有的CSSer在写样式的时候都不约而同的使用了单冒号。这无形中，让这种混淆延续了下来。而CSS3新伪元素的使用到目前为止，还远远不成气候。

## 伪类和伪元素使用上需要注意的地方

明白其不同之后，就需要注意和考虑在实际使用上的一些问题。比如：伪类和伪元素的选择器特殊性(优先级)如何计算？

我在之前的 [CSS选择器距离无关](http://www.swordair.com/blog/2012/03/814/) 一文中，翻译过CSS标准的计算选择器的特殊性这一部分，看完那部分，答案就清楚了：除了否定伪类的特殊规定外，**分开各自作为真正的类和元素计算**。

虽然标准以后的版本可能会允许选择器多伪元素的情况，但就目前为止，伪元素在一个选择器里只能出现一次，并且只能出现在末尾。实则，伪元素是选中了某个元素的符合逻辑的某个实际却不存在的部分，所以应用中也不会有人将其误写成多个。伪类则是像真正的类一样发挥着类的作用，没有数量上的限制，只要不是相互排斥的伪类，也可以同时使用在相同的元素上。关于CSS3选择器的详细解释，推荐 rogerjohansson 的 [CSS 3 selectors explained](http://www.456bereastreet.com/archive/200601/css_3_selectors_explained/)。

## 结束语

本来只是想稍稍写点，不想话又多了…到了最后，我一度觉得自己还漏了很多，不断在脑海里搜索，但可能只能下次在补充了。写这篇的目的是为下篇《CSS伪类与CSS伪元素的典型应用》做个铺垫，不想理论的东西一写自己就开始废话连篇了，惭愧…回看本篇，自己的思路跳的有些乱了，洋洋洒洒这么多字，可能概括起来没几句话，但如果希望尽可能表达清楚，则又免不了冗余过头。理论总是显得枯燥了些，下篇闲谈应用应该不至于这么沉闷:)

## 参考资料

1.  [CSS2.1 Pseudo-elements and pseudo-classes](http://www.w3.org/TR/CSS2/selector.html#pseudo-elements) from W3C
2.  [Selectors Level 3 W3C Recommendation 29 September 2011](http://www.w3.org/TR/selectors/) from W3C
3.  [Difference between a pseudo-class and a pseudo-element](http://www.d.umn.edu/~lcarlson/csswork/selectors/pseudo_dif.html) by Laura L. Carlson
4.  [THE DIFFERENCE BETWEEN PSEUDO-CLASSES AND PSEUDO-ELEMENTS](http://www.stephanmuller.nl/difference-pseudo-classes-pseudo-elements/) by Stephan Muller