---
title: Nginx Pagespeed 配置
date: 2017-12-21 10:01:53
tags: 
    - nginx
    - pagespeed
id: 315050
categories: 
    - 技术
---

Nginx服务器，可以安装ngx_pagespeed扩展，这样你的服务器下面的网站就可以自动通过pagespeed优化。网站返回的源码数据是经过pagespeed处理过的，比如处自动压缩css、html、javascript，图片自动压缩及处理为更小的格式webp。

同时包含一些最佳实践：

 - 优化缓存——整合应用程序的数据和逻辑
 - 最小化round-trip次数——削减连续的请求/响应周期数
 - 最小化请求开销——削减上传大小
 - 最小化负载大小——削减响应、下载及缓存页面大小
 - 优化浏览器渲染——改善浏览器页面布局
 - 移动方面的优化——优化站点移动网络和设备方面的相关特性


## 网站配置

你可以在nginx.conf中全局配置，也可以针对某个网站进行配置，放在虚拟主机配置server中

```
server
    {
        listen 80 default_server;
        server_name _;
        #listen [::]:80;
        #server_name  *.org *.in;
        index index.html index.htm index.php default.html default.htm default.php;
        root  /home/wwwroot/youwebsite;

        # 从这儿开始添加, 下面的代码放在这儿

    }
```

```bash
pagespeed on;

# Needs to exist and be writable by nginx.  Use tmpfs for best performance.
pagespeed FileCachePath /var/ngx_pagespeed_cache;

pagespeed RewriteLevel CoreFilters;
pagespeed EnableFilters local_storage_cache;
pagespeed EnableFilters collapse_whitespace,remove_comments;
pagespeed EnableFilters outline_css;
pagespeed EnableFilters flatten_css_imports;
pagespeed EnableFilters move_css_above_scripts;
pagespeed EnableFilters move_css_to_head;
pagespeed EnableFilters outline_javascript;
pagespeed EnableFilters combine_javascript;
pagespeed EnableFilters combine_css;
pagespeed EnableFilters rewrite_javascript;
pagespeed EnableFilters rewrite_css,sprite_images;
pagespeed EnableFilters rewrite_style_attributes;
pagespeed EnableFilters recompress_images;
pagespeed EnableFilters resize_images;
pagespeed EnableFilters convert_meta_tags;

# Ensure requests for pagespeed optimized resources go to the pagespeed handler
# and no extraneous headers get set.
location ~ "\.pagespeed\.([a-z]\.)?[a-z]{2}\.[^.]{10}\.[^.]+" {
  add_header "" "";
}
location ~ "^/pagespeed_static/" { }
location ~ "^/ngx_pagespeed_beacon$" { }

```

## 安装过程

```
#[check the release notes for the latest version]
NPS_VERSION=1.12.34.3-stable
cd
wget https://github.com/pagespeed/ngx_pagespeed/archive/v${NPS_VERSION}.zip
unzip v${NPS_VERSION}.zip
cd ngx_pagespeed-${NPS_VERSION}/
NPS_RELEASE_NUMBER=${NPS_VERSION/beta/}
NPS_RELEASE_NUMBER=${NPS_VERSION/stable/}
psol_url=https://dl.google.com/dl/page-speed/psol/${NPS_RELEASE_NUMBER}.tar.gz
[ -e scripts/format_binary_url.sh ] && psol_url=$(scripts/format_binary_url.sh PSOL_BINARY_URL)
wget ${psol_url}
tar -xzvf $(basename ${psol_url})  # extracts to psol/
```

修改lnmp `include/upgrade_nginx.sh` 文件

添加 `--add-module=$HOME/ngx_pagespeed-${NPS_VERSION} ${PS_NGX_EXTRA_FLAGS}`

## 参考资料

[Google: Build ngx_pagespeed From Source](https://www.modpagespeed.com/doc/build_ngx_pagespeed_from_source)
[Github: Automatic PageSpeed optimization module for Nginx](https://github.com/apache/incubator-pagespeed-ngx)

