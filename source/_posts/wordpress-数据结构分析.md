---
title: wordpress 数据结构分析
tags:
  - wordpress
id: 313557
categories:
  - 转载
date: 2013-01-20 12:39:16
---

WordPress仅仅用了10 个表:wp_comments, wp_links, wp_options, wp_postmeta, wp_posts, wp_term_relationships, wp_term_taxonomy, wp_terms, wp_usermeta, wp_users

按照功能大致分为五类
用户信息: wp_users和wp_usermeta
链接信息: wp_links
文章及评论信息: wp_posts、wp_postmeta、wp_comments
对分类，链接分类，标签管理: wp_term，wp_term_relationships,wp_term_taxonomy
全局设置信息: wp_options

wp_posts
博客发表”文章”存放的地方就是这个wp_posts表了。这个表里存放的除了普通的文章之外，还有附件和页面（page）的一些信息。post_type 字段是用来区分文章类型的。如果post_type是’post’，那么就是文章，如果是’page’,那么就是页面，如果是’attachment’, 那么就是附件了.

wp_postmeta
这个表很简单，只有 meta_id, post_id, meta_key, meta_value 这四个字段。post_id 是相关 “文章” 的id。meta_value 是longtext类型的，这里仅是用来存储值。在撰写文章的时候，在编辑框下面有一个 Custom Fields 的选项，我们可以在这里添加post的meta信息。

wp_comments
比较重要的两个字段是 comment_post_ID 和 comment_approved，前一个用来指示这条评论隶属于哪一篇文章，后一个用来记录审核状况。还有一个比较有意思的是这个 commnet_agent 字段，可以利用这个字段来统计一下用户浏览器类型。

wp_users
用户帐号表。存储用户名、密码还有一些用户的基本信息。

wp_usermeta
类似上面的 wp_postmeta，存储一些其他的用户信息。

wp_options
用来记录Wordpress的一些设置和选项。里面有一个blog_id字段，这个应该是用在MU版里面来标示不同的 Blog 的。autoload这个字段用来控制是否选项总是被WordPress或者插件导入并缓存来使用，或者是否只是在要求的情况下才被导入。

wp_links
用来存储 Blogroll 里面的链接。

wp_terms
它保存（term）的基本信息。name 就是 term 的名字，slug 是用于使得 URL 友好化。term_group 是用于把相似的 terms 集合在一起。term_id 是term的唯一ID。

wp_term_taxonomy
分类信息,是对wp_terms中的信息的关系信息补充，有所属类型(category,link_category,tag)，详细描述所拥有文章(链接)数量。

wp_term_relationships
把 posts和links这些对象和term_taxonomy表中的term_taxonomy_id联系起来的关系表，object_id是与不同的对象关联，例如wp_posts中的ID（wp_links中的link_id）等，term_taxonomy_id就是关联 wp_term_taxonomy中的term_taxonomy_id。

WordPress使用MySQL数据库。作为一个开发者，我们有必要掌握WordPress数据库的基本构造，并在自己的插件或主题中使用他们。

截至WordPress3.0，WordPress一共有以下11个表。这里加上了默认的表前缀 wp_ 。

wp_commentmeta：存储评论的元数据
wp_comments：存储评论
wp_links：存储友情链接（Blogroll）
wp_options：存储WordPress系统选项和插件、主题配置
wp_postmeta：存储文章（包括页面、上传文件、修订）的元数据
wp_posts：存储文章（包括页面、上传文件、修订）
wp_terms：存储每个目录、标签
wp_term_relationships：存储每个文章、链接和对应分类的关系
wp_term_taxonomy：存储每个目录、标签所对应的分类
wp_usermeta：存储用户的元数据
wp_users：存储用户

在WordPress的数据库结构中，存储系统选项和插件配置的wp_options表是比较独立的结构，在后文中会提到，它采用了key-value模式存储，这样做的好处是易于拓展，各个插件都可以轻松地在这里存储自己的配置。

post，comment，user 则是三个基本表加上拓展表的组合。以wp_users为例，wp_users已经存储了每个用户会用到的基本信息，比如 login_name、display_name、 password、email等常用信息，但如果我们还要存储一些不常用的数据，最好的做法不是去在表后加上一列，去破坏默认的表结构，而是将数据存在 wp_usermeta中。wp_usermeta这个拓展表和wp_options表有类似的结构，我们可以在这里存储每个用户的QQ号码、手机号码、登录WordPress后台的主题选项等等。

比较难以理解的是term，即wp_terms、wp_term_relationships、wp_term_taxonomy。在WordPress的系统里，我们常见的分类有文章的分类、链接的分类，实际上还有TAG，它也是一种特殊的分类方式，我们甚至还可以创建自己的分类方法。WordPress 将所有的分类及分类方法、对应结构都记录在这三个表中。wp_terms记录了每个分类的名字以及基本信息，如本站分为“WordPress开发”、 “WPCEO插件”等，这里的分类指广义上的分类，所以每个TAG也是一个“分类”。wp_term_taxonomy记录了每个分类所归属的分类方法，如“WordPress开发”、“WPCEO插件”是文章分类（category），放置友情链接的“我的朋友”、“我的同事”分类属于友情链接分类（link_category）。wp_term_relationships记录了每个文章（或链接）所对应的分类方法。

庆幸的是，关于term的使用，WordPress中相关函数的使用方法还是比较清晰明了，我们就没必要纠结于它的构造了。

&nbsp;

&nbsp;

在上文中我们已经介绍了WordPress数据库中各个表的作用，本文将继续介绍每个表中每个列的作用。WordPress官方文档已经有比较详细的表格，本文仅对常用数据进行介绍。

wp_commentmeta
meta_id：自增唯一ID
comment_id：对应评论ID
meta_key：键名
meta_value：键值
wp_comments
comment_ID：自增唯一ID
comment_post_ID：对应文章ID
comment_author：评论者
comment_author_email：评论者邮箱
comment_author_url：评论者网址
comment_author_IP：评论者IP
comment_date：评论时间
comment_date_gmt：评论时间（GMT+0时间）
comment_content：评论正文
comment_karma：未知
comment_approved：评论是否被批准
comment_agent：评论者的USER AGENT
comment_type：评论类型(pingback/普通)
comment_parent：父评论ID
user_id：评论者用户ID（不一定存在）

wp_links
link_id：自增唯一ID
link_url：链接URL
link_name：链接标题
link_image：链接图片
link_target：链接打开方式
link_description：链接描述
link_visible：是否可见（Y/N）
link_owner：添加者用户ID
link_rating：评分等级
link_updated：未知
link_rel：XFN关系
link_notes：XFN注释
link_rss：链接RSS地址

&nbsp;

wp_options
option_id：自增唯一ID
blog_id：博客ID，用于多用户博客，默认0
option_name：键名
option_value：键值
autoload：在WordPress载入时自动载入（yes/no）

&nbsp;

wp_postmeta
meta_id：自增唯一ID
post_id：对应文章ID
meta_key：键名
meta_value：键值

&nbsp;

wp_posts
ID：自增唯一ID
post_author：对应作者ID
post_date：发布时间
post_date_gmt：发布时间（GMT+0时间）
post_content：正文
post_title：标题
post_excerpt：摘录
post_status：文章状态（publish/auto-draft/inherit等）
comment_status：评论状态（open/closed）
ping_status：PING状态（open/closed）
post_password：文章密码
post_name：文章缩略名
to_ping：未知
pinged：已经PING过的链接
post_modified：修改时间
post_modified_gmt：修改时间（GMT+0时间）
post_content_filtered：未知
post_parent：父文章，主要用于PAGE
guid：未知
menu_order：排序ID
post_type：文章类型（post/page等）
post_mime_type：MIME类型
comment_count：评论总数

&nbsp;

wp_terms
term_id：分类ID
name：分类名
slug：缩略名
term_group：未知
wp_term_relationships
object_id：对应文章ID/链接ID
term_taxonomy_id：对应分类方法ID
term_order：排序
wp_term_taxonomy
term_taxonomy_id：分类方法ID
term_id：taxonomy：分类方法(category/post_tag)
description：未知
parent：所属父分类方法ID
count：文章数统计

&nbsp;

wp_usermeta
umeta_id：自增唯一ID
user_id：对应用户ID
meta_key：键名
meta_value：键值

&nbsp;

wp_users
ID：自增唯一ID
user_login：登录名
user_pass：密码
user_nicename：昵称
user_email：Email
user_url：网址
user_registered：注册时间
user_activation_key：激活码
user_status：用户状态
display_name：显示名称

### WordPress数据库中的表、字段、类型及说明

wordpress中各个表的字段，折腾WordPress必备良品~

**wp_categories: **用于保存分类相关信息的表。包括了5个字段，分别是:

*   cat_ID – 每个分类唯一的ID号，为一个bigint(20)值，且带有附加属性auto_increment。
*   cat_name – 某个分类的名称，为一个varchar(55)值。
*   category_nicename – 指定给分类的一个便于记住的名字，也就是所谓的slug，这是一个varchar(200)值。
*   category_description – 某个分类的详细说明，longtext型值。
*   category_parent – 分类的上级分类，为一个int(4)值，对应是的当前表中的cat_ID，即wp_categories.cat_ID。无上级分类时，这个值为0。
**wp_comments: **用于保存评论信息的表。包括了15个字段，分别为:

*   comment_ID – 每个评论的唯一ID号，是一个bigint(20)值。带有附加属性auto_increment。
*   comment_post_ID – 每个评论对应的文章的ID号，int(11)值，等同于wp_posts.ID。
*   comment_author – 每个评论的评论者名称，tinytext值。
*   comment_author_email – 每个评论的评论者电邮地址，varchar(100)值。
*   comment_author_url – 每个评论的评论者网址，varchar(200)值。
*   comment_author_IP – 每个评论的评论者的IP地址，varchar(100)值。
*   comment_date – 每个评论发表的时间，datetime值(是加上时区偏移量后的值)。
*   comment_date_gmt – 每个评论发表的时间，datetime值(是标准的格林尼治时间)。
*   comment_content – 每个评论的具体内容，text值。
*   comment_karma – 不详，int(11)值，默认为0。
*   comment_approved – 每个评论的当前状态，为一个枚举值enum(’0′,’1′,’spam’)，0为等待审核，1为允许发布，spam为垃圾评论。默认值为1。
*   comment_agent – 每个评论的评论者的客户端信息，varchar(255)值，主要包括其浏览器和操作系统的类型、版本等资料。
*   comment_type – 不详，varchar(20)值。
*   comment_parent – 某一评论的上级评论，int(11)值，对应wp_comment.ID，默认为0，即无上级评论。
*   user_id – 某一评论对应的用户ID，只有当用户注册后才会生成，int(11)值，对应wp_users.ID。未注册的用户，即外部评论者，这个ID的值为0。
**wp_linkcategories: **用于保存在WP后台中添加的链接的相关信息的表。包括13个字段:

*   cat_id – 每个链接分类的唯一ID，bigint(20)值，为一个自增量auto_increment。
*   cat_name – 每个链接分类的名字，tinytext值。
*   auto_toggle -这个字段所包含的是一个比较特别的属性。如果为Y，则当该分类中加入了新链接时，其它的链接会变为不可见。它是一个枚举型的值enum(’Y’,’N’)，默认为N。
*   show_images – 该字段也是枚举值enum(’Y’,’N’)，默认为Y。用户指定是否允许在该链接分类显示图片链接。
*   show_description – 该字段指定相应的链接分类下的链接，是否再专门[换行]显示它们的说明，这是一个枚举型值enum(’Y’,’N’)，默认为N，即不显示说明(但会通过title属性中显示说明)。
*   show_rating – 显示该分类下链接的等级。它也是一个枚举值enum(’Y’,’N’)，默认为Y。此时，你可以用链接等级的方式来对该链接分类下的链接进行排序。
*   show_updated – 指定该链接分类有更新是，是否进行显示，枚举值enum(’Y’,’N’)，默认为Y。
*   sort_order – 指定该链接分类中链接的排序依据，varchar(64)值。一般用链接的名字(name，即wp_links.link_name)或ID(id，即wp_links.link_id)。
*   sort_desc – 指定链接分类的排序方式，枚举值enum(’Y’,’N’)，默认为N，即用降序。
*   text_before_link – 该链接分类下每个链接的前置html文本，varchar(128)值，默认是’列表开始标签’。
*   text_after_link – 该链接分类下每个链接的中，链接与说明文字(wp_links.link_description)之间的html文本，varchar(128)值，默认是’换行标签’。
*   text_after_all – 该链接分类下每个链接的后置html文本，varchar(128)值，默认是’列表结束标签’。
*   list_limit – 用于规定某一链接分类中显示的(可设定的?)链接的个数，int(11)值，默认为-1，即对链接分类下链接的个数无限制。
**wp_links :**用于保存用户输入到Wordpress中的链接(通过Link Manager)的表。共14个字段:

*   link_id – 每个链接的唯一ID号，bigint(20)值，附加属性为auto_increment。
*   link_url – 每个链接的URL地址，varchar(255)值，形式为http://开头的地址。
*   link_name – 单个链接的名字，varchar(255)值。
*   link_image – 链接可以被定义为使用图片链接，这个字段用于保存该图片的地址，为varchar(255)值。
*   link_target – 链接打开的方式，有三种，_blank为以新窗口打开，_top为就在本窗口中打开并在最上一级，none为不选择，会在本窗口中打开。这个字段是varchar(25)值。
*   link_category – 某个链接对应的链接分类，为int(11)值。相当于wp_linkcategories.cat_id。
*   link_description – 链接的说明文字。用户可以选择显示在链接下方还是显示在title属性中。varchar(255)值。
*   link_visible – 该链接是否可以，枚举enum(’Y’,’N’)值，默认为Y，即可见。
*   link_owner – 某个链接的创建人，为一int(11)值，默认是1。(应该对应的就是wp_users.ID)
*   link_rating – 链接的等级，int(11)值。默认为0。
*   link_updated – 链接被定义、修改的时间，datetime值。
*   link_rel – 链接与定义者的关系，由XFN Creator设置，varchar(255)值。
*   link_notes – 链接的详细说明，mediumtext值。
*   link_rss – 该链接的RSS地址，varchar(255)值。
**wp_options: **用于保存Wordpress相关设置、参数的表，共11个字段。最重要是的option_value字段，里面包括了大量的重要信息。

*   option_id – 选项的ID，bigint(20)值，附加auto_increment属性。
*   blog_id – 不详。或许用在单在用户的WP版本上并不重要吧，或许是针对不同用户的Blog来设置的一个值。int(11)值，默认为0，即当前blog。
*   option_name – 选项名称，varchar(64)值。
*   option_can_override – 该选项是否可被重写、更新，枚举enum(’Y’,’N’)值，默认为Y，即可被重写、更新。
*   option_type – 选项的类型，作用不详，int(11)值，默认为1。
*   option_value – 选项的值，longtext值，这个字段的内容比较重要。Wordpress初始化时就会设定好约70个默认的值，这里暂不介绍。
*   option_width – 选项的宽(?)，作用不详。int(11)值，默认为20。
*   option_height – 选项的高(?)，作用不详。int(11)值，默认为8。
*   option_description – 针对某个选项的说明，tinytext值。
*   option_admin_level – 设定某个选项可被操纵的用户等级(详情见我的相关文章)，int(11)值，默认为1。
*   autoload – 选项是否每次都被自动加载，枚举enum(’yes’,’no’)值，默认为yes。
**wp_post2cat: **用于保存文章(posts)与分类(categories)之间的关系的表，只有三个字段:

*   rel_id – 关联ID，bigint(20)值，是个有auto_increment属性的自增量。
*   post_id – 文章的ID，bigint(20)值，相当于wp_posts.ID。
*   category_id – 分类的ID，也是bigint(20)值，相当于wp_categories.ID。
文章与分类的关系的形成是这样的:rel_id是一个不断增加的自增量，它用于识别每不同的post。post_id可以重复(当它对应多个分类时)，因为它可被rel_id识别，所以不会出现混乱。每个post_id可对应多个category_id时，一个rel_id + post_id组合，可以识别某一个分类，因此每个文章的分类可以是不同的。通过这张表，可以非常快速、高效地找出某篇文章(post)对应了哪些分类 (category)，反之亦然。

**wp_postmeta: **用于保存文章的元信息(meta)的表，四个字段:

*   meta_id – 元信息ID，bigint(20)值，附加属性为auto_increment。
*   post_id – 文章ID，bigint(20)值，相当于wp_posts.ID。
*   meta_key – 元信息的关键字，varchar(255)值。
*   meta_value – 元信息的值，text值。
这些内容主要是在文章及页面编辑页(Write Post, Write Page)的”Add a new custom field to this post(page):”下进行设定的。meta_key就对应名为”key”的下拉列表中的项，而值由用户自己填上(某些时候，wp也会自动加入，如文章中有的音频媒体)。

**wp_posts: **用于保存你所有的文章(posts)的相关信息的表，非常的重要。一般来讲，它存储的数据是最多的。一共包括了21个字段。
ID – 每篇文章的唯一ID，bigint(20)值，附加属性auto_increment。

*   post_author – 每篇文章的作者的编号，int(4)值，应该对应的是wp_users.ID。
*   post_date – 每篇文章发表的时间，datetime值。它是GMT时间加上时区偏移量的结果。
*   post_date_gmt – 每篇文章发表时的GMT(格林威治)时间，datetime值。
*   post_content – 每篇文章的具体内容，longtext值。你在后台文章编辑页面中写入的所有内容都放在这里。
*   post_title – 文章的标题，text值。
*   post_category – 文章所属分类，int(4)值。
*   post_excerpt – 文章摘要，text值。
*   post_status – 文章当前的状态，枚举enum(’publish’,’draft’,’private’,’static’,’object’)值，publish为已发表，draft为草稿，private为私人内容(不会被公开) ，static(不详)，object(不详)。默认为publish。
*   comment_status – 评论设置的状态，也是枚举enum(’open’,’closed’,’registered_only’)值，open为允许评论，closed为不允许评论，registered_only为只有注册用户方可评论。默认为open，即人人都可以评论。
*   ping_status – ping状态，枚举enum(’open’,’closed’)值，open指打开pingback功能，closed为关闭。默认值是open。
*   post_password – 文章密码，varchar(20)值。文章编辑才可为文章设定一个密码，凭这个密码才能对文章进行重新强加或修改。
*   post_name – 文章名，varchar(200)值。这通常是用在生成permalink时，标识某篇文章的一段文本或数字，也即post slug。
*   to_ping – 强制该文章去ping某个URI。text值。
*   pinged – 该文章被pingback的历史记录，text值，为一个个的URI。
*   post_modified – 文章最后修改的时间，datetime值，它是GMT时间加上时区偏移量的结果。
*   post_modified_gmt – 文章最后修改的GMT时间，datetime值。
*   post_content_filtered – 不详，text值。
*   post_parent – 文章的上级文章的ID，int(11)值，对应的是wp_posts.ID。默认为0，即没有上级文章。
*   guid – 这是每篇文章的一个地址，varchar(255)值。默认是这样的形式: http://your.blog.site/?p=1，如果你形成permalink功能，则通常会是: 你的Wordpress站点地址+文章名。
*   menu_order – 不详，int(11)值，默认为0。
*   post_type – 文章类型，具体不详，varchar(100)值。默认为0。
*   post_mime_type – 不详。varchar(100)值。
*   comment_count – 评论计数，具体用途不详，bigint(20)值。
**wp_usermeta : **用于保存用户元信息(meta)的表，共4个字段:

*   umeta_id – 元信息ID，bigint(20)值，附加属性auto_increment。
*   user_id – 元信息对应的用户ID，bigint(20)值，相当于wp_users.ID。
*   meta_key – 元信息关键字，varchar(255)值。
*   meta_value – 元信息的详细值，longtext值。
**wp_users:**用于保存Wordpress使用者的相关信息的表。WP官方对2.0.2版本中该表的情况的说明有些矛盾(称有22个字段，但详细的列表中只有11个)，所以这里只能列出11个字段进行说明:

*   ID – 用户唯一ID,bigint(20)值，带附加属性auto_increment。
*   user_login – 用户的注册名称，varchar(60)值。
*   user_pass – 用户密码，varchar(64)值，这是经过加密的结果。好象用的是不可逆的MD5算法。
*   user_nicename – 用户昵称，varchar(50)值。
*   user_email – 用户电邮地址，varchar(100)值。
*   user_url – 用户网址，varchar(100)值。
*   user_registered – 用户注册时间，datetime值。
*   user_level – 用于等级，int(2)值，可以是0-10之间的数字，不同等级有不同的对WP的操作权限。
*   user_activation_key – 用户激活码，不详。varchar(60)值。
*   user_status – 用户状态，int(11)值，默认为0。
*   display_name – 来前台显示出来的用户名字，varchar(250)值。