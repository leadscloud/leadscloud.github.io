---
title: wordpress 相关阅读插件功能增强
id: 313795
categories:
  - Wordpress学习
date: 2014-05-19 04:37:12
tags: wordpress
---

本站用到了“相关阅读”插件，在文章尾部显示相关文章的链接，该插件非常实用。但是最近发现一个问题，就是当新的文章发布时，新文章尾部可以关联到已有文章，但是在老文章的相关阅读的列表并没有加入新发布的文章。感觉，应该是发布了新文章后，没有重建整个关联关系。插件本身为了性能考虑，应该只刷新了当前文章的关联信息，而没有刷新其他文章的。下面的代码分析也印证了这一点。

首先需要了解插件的运行流程，这里顺带发一下Yet Another Related Posts Plugin的代码分析。

插件的主函数为：

```php
public function __construct() {

    $this->yarppPro = get_option('yarpp_pro');
    $this->load_default_options();

    /* Loads the plugin's translated strings. */
    load_plugin_textdomain('yarpp', false, plugin_basename(YARPP_DIR).'/lang');

    /* Load cache object. */
    $this->storage_class    = 'YARPP_Cache_'.ucfirst(YARPP_CACHE_TYPE);
    $this->cache            = new $this->storage_class($this);
    $this->cache_bypass     = new YARPP_Cache_Bypass($this);

    register_activation_hook(__FILE__, array($this, 'activate'));

    /**
     * @since 3.2 Update cache on delete.
     */
    add_action('delete_post', array($this->cache, 'delete_post'), 10, 1);

    /**
     * @since 3.5.3 Use transition_post_status instead of save_post hook.
     * @since 3.2.1 Handle post_status transitions.
     */
    add_action('transition_post_status', array($this->cache, 'transition_post_status'), 10, 3);

    /* Automatic display hooks: */
    add_filter('the_content',        array($this, 'the_content'), 1200);
    add_filter('the_content_feed',   array($this, 'the_content_feed'), 600);
    add_filter('the_excerpt_rss',    array($this, 'the_excerpt_rss' ), 600);
    add_action('wp_enqueue_scripts', array($this, 'maybe_enqueue_thumbnails'));
```

注意，其中的几个filter和action，filter是显示文章的时候调用的回调，action是增、删、改文章时的回调。这里重点关注action。delete_post，当删除文章时，需要删除该文章的关联信息，还要删除指向该文章的关联信息。分析代码：

```
/**
 * Clear the cache for this entry and for all posts which are "related" to it.
 * @since 3.2 This is called when a post is deleted.
 */
function delete_post($post_ID) {
    // Clear the cache for this post.
    $this->clear((int) $post_ID);

    // Find all "peers" which list this post as a related post and clear their caches
    if ($peers = $this->related(null, (int) $post_ID)) $this->clear($peers);
}
```

可以看到这个函数分作两步，首先是删除当前文章的关联信息，接下来删除指向该文章的关联。

而修改文章状态，如：从草稿变成发布，从发布改为私密，等等，使用的是这个回调：

```
add_action('transition_post_status', array($this->cache, 'transition_post_status'), 10, 3);
```

当有文章的状态出现变化时，这个回调就会起作用：

```
/**
 * @since 3.2.1 Handle various post_status transitions
 */
function transition_post_status( $new_status, $old_status, $post ) {
    $post_ID = $post->ID;

    /**
     * @since 3.4 Don't compute on revisions
     * @since 3.5 Compute on the parent instead
     */
    if ($the_post = wp_is_post_revision($post_ID)) $post_ID = $the_post;

    // Un-publish
    if ($old_status === 'publish' &amp;&amp; $new_status !== 'publish') {
        // Find all "peers" which list this post as a related post and clear their caches
        if ($peers = $this->related(null, (int) $post_ID)) $this->clear($peers);
    }

    // Publish
    if ($old_status !== 'publish' &amp;&amp; $new_status === 'publish') {
        /*
         * Find everything which is related to this post, and clear them,
         * so that this post might show up as related to them.
         */
        if ($related = $this->related($post_ID, null)) $this->clear($related);
    }

    /**
     * @since 3.4 Simply clear the cache on save; don't recompute.
     */
    $this->clear((int) $post_ID);

}
```

可以看到，这里只处理当文章的状态从发布修改为非发布等情况，对于新增文章，这里应该是什么都不做，也就是说，新增文章的关联关系是在另外的地方建立，而且每一次文章展示时，都会检查是否有关联关系，如果没有，则会全新计算生成。

那么这里就有了解决上面提到的功能增强的方法了，每次有文章更改时，清空关联关系表即可。增加一个方法：

```
public function clearall() {
}
```

在基类（YARPP_Cache）中提供默认实现，如上，什么都不做，由管理关联关系表的子类来实现清空关联表即可，在YARPP_Cache_Tables类中提供如下实现：

```
public function clearall() {
    global $wpdb;
    $wpdb->query("TRUNCATE TABLE {$wpdb->prefix}" . YARPP_TABLES_RELATED_TABLE);
}
```

在上述的delete_post和transition_post_status的回调中，增加这个方法的调用：

```
/**
 * Clear the cache for this entry and for all posts which are "related" to it.
 * @since 3.2 This is called when a post is deleted.
 */
function delete_post($post_ID) {
    // Clear the cache for this post.
    $this->clear((int) $post_ID);

    $this->clearall();

    // Find all "peers" which list this post as a related post and clear their caches
    if ($peers = $this->related(null, (int) $post_ID)) $this->clear($peers);
}
/**
 * @since 3.2.1 Handle various post_status transitions
 */
function transition_post_status( $new_status, $old_status, $post ) {
    $post_ID = $post->ID;

    /**
     * @since 3.4 Don't compute on revisions
     * @since 3.5 Compute on the parent instead
     */
    if ($the_post = wp_is_post_revision($post_ID)) $post_ID = $the_post;

    // Un-publish
    if ($old_status === 'publish' &amp;&amp; $new_status !== 'publish') {
        // Find all "peers" which list this post as a related post and clear their caches
        if ($peers = $this->related(null, (int) $post_ID)) $this->clear($peers);
    }

    // Publish
    if ($old_status !== 'publish' &amp;&amp; $new_status === 'publish') {
        /*
         * Find everything which is related to this post, and clear them,
         * so that this post might show up as related to them.
         */
        if ($related = $this->related($post_ID, null)) $this->clear($related);
    }

    /**
     * @since 3.4 Simply clear the cache on save; don't recompute.
     */
    $this->clear((int) $post_ID);

    $this->clearall();
}
```

注意，仅仅从操作关联关系表来看，在这两个方法中只需要clearall即可，其他流程都不需要，但是这个是基类，这个框架供各个子类使用，没有分析另外两个子类的功能，因此这里仅仅只增加clearall的流程，保留之前的已有实现。

在博客站点的文章数量不是特别多的情况下，该方法应该是非常有用的，如果文章特别多，则需要定点修改与该文章关联的文章的关联关系，将修改范围尽可能缩小，但是，可以想象，该实现将会非常复杂。建立关联关系的过程消耗站点的访问性能应该说是非常少的，如果只是访问一片文章，那么只会建这一篇文章的关联，不会全部创建，因此不会出现阻塞页面呈现的情况。

经过本站实测，该问题得到了解决。

来源：[http://shentar.me/wordpress-%E7%9B%B8%E5%85%B3%E9%98%85%E8%AF%BB%E6%8F%92%E4%BB%B6%E5%8A%9F%E8%83%BD%E5%A2%9E%E5%BC%BA/](http://shentar.me/wordpress-%E7%9B%B8%E5%85%B3%E9%98%85%E8%AF%BB%E6%8F%92%E4%BB%B6%E5%8A%9F%E8%83%BD%E5%A2%9E%E5%BC%BA/)