---
title: wordpress主题多语言支持
tags:
  - wordpress
  - wordpress中文
id: 313038
categories:
  - Wordpress学习
date: 2011-02-12 12:06:00
---

我们制作wordpress主题，对于中文用户来说最主要的还是主题对多语言的支持，这篇文章讲一下怎样让wodpress主题支持多语言，比如中文支持，而不必在主题里直接写上中文这种笨方法。

以为我的这篇博客的主题(<span style="color: #0080ff;">love4026)</span>为例

<!--more-->

首先你需要在主题文件中添加本地化支持语句，把下面的代码添加到你主题根目录中的functions.php文件中去：

    // Localization
    function theme_init(){
    	load_theme_textdomain('love4026', get_template_directory() . '/languages');
    }
    add_action ('init', 'theme_init');

上面的代码中love4026可以随便设（一般填上主题名字），它是用来告诉WordPress如何选择那些能本地化语言的代码，下面还会出现。'/languages' 字段是告诉WordPress本地化语言文件的调用路径（主题根目录下的languages文件夹），一般主题默认就是这样，很多主题中是没有这个文件夹的。

有了上面代码的设置后，就可心在主题文件中定义一下究竟那些文字需要支持语言的本地化。即多语言支持，我这里以侧栏中的一句标题代码为例。在还没有支持语言本地化时候，代码是这样的：

`&lt;h2&gt;Most Popular&lt;/h2&gt;`

因为我希望对上面红色字段Most Popular修改到支持本地化，即当主题选择不同的语言时出现对应的语言，只要把代码修改成如下：

`&lt;h2&gt;&lt;?php _e('Most Popular', 'love4026'); ?&gt;&lt;/h2&gt;`

或

`&lt;h2&gt;&lt;?php echo __('Most Popular', 'love4026'); ?&gt;&lt;/h2&gt;`

大家能看到修改的内容了吧，再举一例，比如我在footer信息中的一段代码：

`&lt;span&gt;<span style="color: #ff0000;">Copyright</span> 2011&lt;/span&gt;`

我要把红色的字段copyright修改到支持本地化，修改代码如下：

`&lt;span&gt;&lt;?php _e('Copyright', 'love4026'); ?&gt; 2011&lt;/span&gt;`

相信到此大家就很了解是如何修改主题中显示字符段的代码了，注意的上面两句代码中都带有的标识字段：

`love4026`

它就是用来对应在文章最开头那段代码中的**love4026**那部分，它们之间必须要对应。一般情况下主题你也可以这样写_e('Copyright'); ，这样就会自动调用wordpress默认的语言文件（如果你用的是wordpress的中文版，在wp-content下会有languages目录），然后就用使用languages下的zh_CN.mo文件，翻译Copyright这个字段。

不过通常wordporess默认的不可能带所有英文的翻译，这时就要我们自己在主题里设置自己的zh_CN.mo文件，这就需要一个软件的支持[Poedit](http://www.poedit.net/download.php)。

去[这儿](http://downloads.sourceforge.net/project/poedit/poedit/1.4.6/poedit-1.4.6-setup.exe?r=http%3A%2F%2Fsourceforge.net%2Fprojects%2Fpoedit%2Ffiles%2F&amp;ts=1297508108&amp;use_mirror=nchc)下载一个[Poedit](http://www.poedit.net/download.php)编辑工具。然后我们需要在主题的目录中新建一个文件夹(**languages**)，因为我们需要在这个文件夹中放置翻译好供系统读取的文件，它对应文章开头那段代码 load_theme_textdomain('love4026', get_template_directory() . '/<span style="color: #ff0000;">languages</span>');  中的红色部分。

软件安装之后可以选择语言的，它支持中文。

下一步利用[Poedit](http://www.poedit.net/download.php)新建一个“消息目录文档”，如下图：

[![image](http://www.love4026.org/wp-content/uploads/2011/02/image_thumb.png "image")](http://www.love4026.org/wp-content/uploads/2011/02/image.png)

然后它需要我们对这个文档初始设置一下。

[![image](http://www.love4026.org/wp-content/uploads/2011/02/image_thumb1.png "image")](http://www.love4026.org/wp-content/uploads/2011/02/image1.png)

（上图）本例我需要把上面的英文字段翻译成中文的，所以在设置的“工程信息”一栏中我是这样填写的，这些填写都不是很重要，就是一些记录信息之类的，不影响翻译操作。

[![image](http://www.love4026.org/wp-content/uploads/2011/02/image_thumb2.png "image")](http://www.love4026.org/wp-content/uploads/2011/02/image2.png)

（上图）接着要填写的是第二个标签页“路径”。<span style="color: #ff0000;">这一步很重要，请按图中的填写</span>。因为它将会告诉这个软件从何处获取需要翻译的字段。

[![image](http://www.love4026.org/wp-content/uploads/2011/02/image_thumb3.png "image")](http://www.love4026.org/wp-content/uploads/2011/02/image3.png)

（上图）第三个标签页是用来决定自动获取需要翻译字段的关键字。就是告诉软件，当代码中出现什么的字时候，确定它为要翻译的字段而选择出来。大家按上图填写就好了，是不是发现上面的“_e”在较早我所说的例子代码里都存在啊，大家明白了吧。

当大家按上面的设置好之后，**记得把文件存放在较早前新建的目录<strong>languages**内（我的为wp-contentthemeslove4026languages），因为这是简体中文的翻译，所以文件名是zh_CN，后缀名是.po（完成之后为wp-contentthemeslove4026languageszh_CN.po）</strong>。

接下来点击一下软件中的第三个图标（如下图红色标记处）。软件就把我们主题文件中（zh_CN.po的上级目录）所有的php文件扫描一遍，合符要求的需要翻译的字段列举出来了。

[![image](http://www.love4026.org/wp-content/uploads/2011/02/image_thumb4.png "image")](http://www.love4026.org/wp-content/uploads/2011/02/image4.png)

如下图，工具显示两栏，左侧为需要翻译的字段，右侧是译文。当还没有翻译的字段的右侧是留空的。[![image](http://www.love4026.org/wp-content/uploads/2011/02/image_thumb5.png "image")](http://www.love4026.org/wp-content/uploads/2011/02/image5.png)

我们点击下需要翻译的字段，然后在最下面一栏填写翻译的内容就行了。大家就这样把需要翻译的字段一个一个翻译完吧，耐心点。

当所有需要翻译的字段都完成后，点击**如下图**的红色按钮。**软件会把当前的编译文件zh_CN.po进行保存并且同时在该文件的的有目录中生成一个文件名相同但后缀名是.mo的文件。**

[![image](http://www.love4026.org/wp-content/uploads/2011/02/image_thumb6.png "image")](http://www.love4026.org/wp-content/uploads/2011/02/image6.png)

因为后缀名是.po的文件我们是可以进行编译操作的，文件名是.mo的则是不能进行编译，但它却是系统需要读取的文件。**所以请务必日后在每次更改了.po文件后，都重复一下上面的这个步骤（就是保存一遍），更新一下对应的.mo文件。**

[![image](http://www.love4026.org/wp-content/uploads/2011/02/image_thumb7.png "image")](http://www.love4026.org/wp-content/uploads/2011/02/image7.png)

基本的操作就是这样的了，大家翻译好简体中文的，就翻译其它语言的吧。所有的步骤都与上面所说的相同，只是翻译的内容不同罢了。相信大家会举一反三的。

附：WordPress是怎样知道该读取哪个语言文件呢？其实就是在它的wp-config.php文件中，不是有下面的这样一句？

define ('WPLANG', ‘<span style="color: #ff0000;">zh_CN</span>’);

注意红色部分，为空默认为英语，zh_CN为中文。

下面是我的主题文件里多语言支持的写法，大家可以参考下写法

<pre class="lang:php decode:true ">&lt;h2&gt;&lt;?php _e('Error 404 - Not Found', 'love4026')?&gt;&lt;/h2&gt;</pre>
<pre class="lang:php decode:true ">&lt;?php the_content(__('Continue reading &amp;raquo;', 'love4026')); ?&gt;</pre>
<pre class="lang:php decode:true ">&lt;?php if ($req) echo __('(required)', 'love4026'); ?&gt;</pre>