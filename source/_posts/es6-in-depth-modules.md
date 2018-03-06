---
title: 深入理解ES6的模块 -【翻译】
date: 2018-03-06 13:37:57
tags: [es6,javascript]
id: 314016
categories: 技术
---

回想2007年，那时候我刚加入Mozilla's JavaScript团队，那时候的一个典型的JavaScript程序只需要一行代码，听起来像个笑话。

两年后，Google Maps发布。在这之前，JavaScript主要用来做表单的验证，你用来处理`<input onchange=>`这个程序当然只需要一行。

时过境迁，JavaScript项目已经发展到让人叹为观止，社区涌现了许多帮助开发的工具。但是最迫切需要的是一个模块系统，它能将你的工作分散到不同的文件与目录中，在需要的时候他们能彼此之间相互访问，并且可以有效的加载所有代码。所以JavaScript有模块系统这很正常，而且还有多个模块系统（CommonJS、AMD、CMD、UMD）。不仅如此，它还有几个包管理器（npm、bower），用来安装软件还能拷贝一些深度依赖。你可能认为ES6和它的新模块系统出现得有点晚。

那我们来看看ES6为现存的模块系统添加了什么，以及未来的标准和工具能否建立在这个系统上。首先，让我们看看ES6的模块是什么样子的。

## 模块的基础知识

ES6模块是一个包含了JS代码的文件。没有所谓的`module`关键词，一个模块看起来和一个脚本文件没什么不一样，除了一下两个区别：

* ES6的模块自动开启严格模式，即使你没有写`"use strict";`；
* 在模块中，你可以使用`import`和`exprot`。

先来谈谈export。在默认情况下，模块中所有的声明都是私有的，如果你希望模块中的某些声明是公开的，并在其他模块中使用它们，你就必须导出它们。这里有一些实现方法，最简单的是添加`export`关键字

```javascript
// kittydar.js - Find the locations of all the cats in an image.
// (Heather Arthur wrote this library for real)
// (but she didn't use modules, because it was 2013)

export function detectCats(canvas, options) {
  var kittydar = new Kittydar(options);
  return kittydar.detectCats(canvas);
}

export class Kittydar {
  ... several methods doing image processing ...
}

// This helper function isn't exported.
function resizeCanvas() {
  ...
}
...

```

你可以`export`任何的顶级变量：`function`、`class`、`var`、`let`、`const`。

你如果要写一个模块知道这么多就够了！你不必再把所有的东西放到一个立即执行函数或者回调函数里面，只需要在你需要的地方进行声明。由于这个代码是一个模块，而不是一个脚本，所有的声明的作用域都只属于这个模块，而不是所有脚本和模块都能全局访问的。你只要把模块中的声明导出成一组公共模块的API就足够了。

除了导出，模块里的代码和其他普通代码没有什么区别。它可以访问全局变量，像`Object`和`Array`。如果你的模块在浏览器运行，还能够使用`document`和`XMLHttpRequest`。

在另一个文件中，我们可以导入并使用`detectCats()`函数：

```
// demo.js - Kittydar demo program

import {detectCats} from "kittydar.js";

function go() {
    var canvas = document.getElementById("catpix");
    var cats = detectCats(canvas);
    drawRectangles(canvas, cats);
}
```

要从一个模块导入多个变量，你可以这样写：

```
import {detectCats, Kittydar} from "kittydar.js";
```

当你运行一个包含`import`声明的模块，会先导入要导入的模块并加载，然后根据深度优先的原则遍历依赖图谱来执行对应模块，并跳过已经执行的模块，来避免循环。

这就是模块基础知识，这真的很简单。;-)

## 导出列表

你可以把你要导出的功能名写在一个列表里，然后用大括号括起来，这样就不用在每个要导出的功能前面加上export标记。

```
export {detectCats, Kittydar};

// no `export` keyword required here
function detectCats(canvas, options) { ... }
class Kittydar { ... }
```

导出列表并不需要写在文件的第一行，它可以出现在模块文件的顶级作用域的任何位置。你可以有多个导出列表，或者将导出列表与导出声明混合使用，只要不重复导出同一个变量名就行。

## 重命名导出和导入

有时，导入的变量名碰巧与你需要使用的一些变量名冲突了，ES6允许你重命名导入的变量。

```
// suburbia.js

// Both these modules export something named `flip`.
// To import them both, we must rename at least one.
import {flip as flipOmelet} from "eggs.js";
import {flip as flipHouse} from "real-estate.js";
...
```

同样，你在导出变量的时候也可以重命名它们。这在你想使用不同名字导出相同功能的时候十分方便。

```
// unlicensed_nuclear_accelerator.js - media streaming without drm
// (not a real library, but maybe it should be)

function v1() { ... }
function v2() { ... }

export {
  v1 as streamV1,
  v2 as streamV2,
  v2 as streamLatestVersion
};
```

## 默认的导出

新的标准在设计上是兼容已经存在的CommonJS和AMD模块的。如果你有一个Node项目，并且你已经执行了`npm install lodash`。你使用ES6代码能够单独引入Lodash中的函数：

```
import {each, map} from "lodash";

each([3, 2, 1], x => console.log(x));
```

如果你已经习惯使用`_.each`而不是`each`，你依然想像以前一样使用它。或者， 你想把_当成一个函数来使用，因为这才是Lodash。

这种情况下，你只要稍微改变下你的写法：不使用花括号来导入模块。

```
import _ from "lodash";
```

这个写法等同于`import {default as _} from "lodash";`。所有的CommonJS 和AMD模块在ES6中都能被当作`default`导出，这个导出和你在CommonJS中使用`require()`导出得到东西一样，即`exports`对象。

ES6模块在设计上可以让你导出更多的东西，但对于现在的CommonJS模块，导出的default模块就是能导出的全部东西了。例如，在写这篇文章时，据我所知，著名的[colors模块](https://github.com/Marak/colors.js)没有特意去支持ES6语法，这是一个CommonJS模块组成的包，就像npm上的那些包一样，但是你可以直接引入到你的ES6代码中。

```
// ES6 equivalent of `var colors = require("colors/safe");`
import colors from "colors/safe";
```

如果你希望自己ES6模块也具有默认导出，这很简单。默认的导出方式并没有什么魔力；他就像其他导出一样，除了它的导出名为default。你可以使用我们之前提到的重命名语法：

```
let myObject = {
  field1: value1,
  field2: value2
};
export {myObject as default};
```

或者使用简写：

```
export default {
  field1: value1,
  field2: value2
};
```

`export default`关键词后面可以跟任何值：一个函数、一个类、一个对象，所有能被命名的变量。

## 模块对象

不好意思，这篇文章有点长。JavaScript并不孤独：因为一些原因，所有的语言中都有模块系统，并且倾向于设计大量杂乱而又无聊的小特性。幸运的是我们只剩下一个话题，噢，不对，是两个。

```
import * as cows from "cows";
```

当你使用`import *`的时候，被引入的是一个模块命名空间对象（module namespace object），它的属性是模块的输出。如果“cows”模块导出一个名为moo()的函数，那么在导入“cows”之后，你可以使用`cows.moo()`来进行调用。

## 聚合模块

有时候一个包的主模块只不过是导入包其他所有的模块，并用统一的方式导出。为了简化这种代码，有一种将导入导出全部合一的简写：

```
// world-foods.js - good stuff from all over

// import "sri-lanka" and re-export some of its exports
export {Tea, Cinnamon} from "sri-lanka";

// import "equatorial-guinea" and re-export some of its exports
export {Coffee, Cocoa} from "equatorial-guinea";

// import "singapore" and export ALL of its exports
export * from "singapore";
```

这种`export-from`表达式类似于`import-from`后面跟了一个export。这和真正的导入有一些区别，它不会在当前作用域中绑定将要导出的变量。如果你打算在`world-foods.js`中使用`Tea`来编写一些代码，请不要使用这种简写，你会发现Tea为定义。

如果“singapore”导出的命名与其他导出发生了冲突，那就会出现错误，所以请谨慎使用。

呼，我们已经把语法介绍完了！下面来谈谈一些有趣的事情。


## `import`到底做了什么？

不管你信不信，它什么都没做。

噢，你看起来没那么好骗。那么你会相信标准几乎没有说import到底该怎么做吗？这是件好事吗？（作者貌似很爱开玩笑。）

ES6将模块的加载细节[完全交给了实现](http://www.ecma-international.org/ecma-262/6.0/index.html#sec-hostresolveimportedmodule)，其余的模块执行部分却[规定得非常详细](http://www.ecma-international.org/ecma-262/6.0/index.html#sec-toplevelmoduleevaluationjob)。

简单来说，当你告诉JS引擎运行一个模块的时候，它的行为可以归纳为以下四部：

1. 解析：读取模块的源代码，并检查语法错误。
2. 加载：加载所有的导入模块（递归进行），这是还未标准化的部分。
3. 链接：对于每个新加载的模块，在实现上都会创建一个作用域，并把模块中声明的所有变量都绑定在这个作用域上，包括从其他模块导入的变量。如果你想试试`import {cake} from "paleo"`，但是“paleo”模块没真正导出名为cake的变量，你会得到一个错误。这很糟糕，因为你离运行js并品尝蛋糕只有一步之遥。
4. 运行时间：最后，开始执行加载进来的新的模块中的代码。这时，整个import过程已经完成了，所以前面说代码执行到import这一行声明时，什么都没有发生。

看到没？我说了什么都不会发生，在编程语言这件事上，我从来都不说慌。

现在我们可以开始介绍这个系统中有趣的部分了。这有一个非常炫酷的技巧。由于系统没有指定如何加载的这方面的细节，并且你可以通过查看源代码中导入的声明，提前计算出所有的依赖项，所以ES6的实现可以通过预处理器完成所有的工作，然后把所有的模块打包到一个文件中，最后通过网络进行请求一次即可。像webpack这样的工具就是这么做的。

这是一个优雅的解决方案，因为通过网络加载所有的脚本文件很耗时，假如你请求一个资源后，发现里面有import声明，然后你又得请求更多资源。一个加载器需要非常多的网络请求来回传输。通过webpack，你不仅能在今天就使用ES6的模块话，你还能获得很多好处，并且不需要担心会造成运行时的性能下降。

原本是有计划制定一个ES6中模块加载的详细规范的，并且已经初步成型。它没有成为标准的原因之一是不知道如何与打包这一特性进行整合。我希望模块化的加载会更加标准化，也希望打包工具会越来越好。

## 静态 VS 动态，或者说：规则如何打破规则

作为一个动态编译语言，令人惊奇的是JavaScript拥有一个静态的模块系统。

- 所有的`import`和`export`只能写在顶级作用域中。你不能在条件判断语句和函数作用域内使用import。
- 所有导出的变量名必须是显式的，你不能通过遍历一个数组，动态生成一组导出名进行导出。
- 模块对象都是被冻结的，不能通过polyfill为它添加新的特性。
- 在所有模块运行之前， 其依赖的模块都必须经过加载、解析、链接的过程，目前没有import懒加载相关的语法。（现在import()方法已经在提案中了）
- 对于import的错误，无法进行recovery。一个应用可能依赖许多的模块，一旦有一个模块加载失败，这个应用都不会运行。你不能在`try/catch`中使用`import`。正是因为es6的模块表现得如此静态，webpack才能在编译的时候检测出代码中的错误。
- 你没法为一个模块在加载所有依赖项之前添加钩子，这意味着一个模块没有办法控制其依赖项的加载方式。

如果你的需求是静态的，ES6的模块系统还是相当不错的。但是你有时候你还是向进行一些hack，对吧？

这就是为什么你使用的模块加载系统会提供一些系统层次的API来配合ES6的静态的`import/export`语法。例如，webpack有一个API能进行代码的分割，按照你的需求对一些模块进行懒加载。这个API能够打破之前列出的规矩。

ES6的模块语法非常静态，这很好-在使用一些编译工具时我们都能尝到一些甜头。静态语法的设计可以让它与动态加载器丰富的API进行工作。


## 我什么时候才能使用ES6模块？

如果你今天就想使用，你需要一个预编译器，如 [Traceur](https://github.com/google/traceur-compiler#what-is-traceur) 和 [Babel](http://babeljs.io/) 。这个系列之前也有相关文章，[Gastón I. Silva：如何使用 Babel 和 Broccoli](https://hacks.mozilla.org/2015/06/es6-in-depth-babel-and-broccoli/) 编译 ES6 代码为 web 可用。Gastón也将案例[放在了 GitHub 上](https://github.com/givanse/broccoli-babel-examples/tree/master/es6-modules)。另外[这篇文章](http://2ality.com/2015/04/webpack-es6.html)也介绍了如何使用 Babel 和 webpack。

ES6 模块系统由 Dave Herman 和 Sam Tobin-Hochstadt进行设计，他们不顾多人（包括我）的反对，多年来始终坚持模块系统是静态的。JonCoppeard正在Firefox上实现ES6的模块化功能。JavaScript Loader的相关标准的工作也正在进行中，预计在HTML中将会被添加类似`<script type=module>` 这样的东西。

这便是 ES6 了。

这太有趣了，我不希望现在就结束。也许我们还能再说一会。我们还能够讨论一些关于ES6规范中零零碎碎的东西，但这些又不足够写成文章。也行会有一些关于ES6未来特性的一些东西，尽请期待下周的`ES6 In Depth`

原文链接：[ES6 In Depth: Modules](https://hacks.mozilla.org/2015/08/es6-in-depth-modules/)