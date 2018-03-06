---
title: WordPress第三方主题文件漏洞分析
tags:
  - timthumb
  - wordpress
  - wordpress注入
id: 313334
categories:
  - Wordpress学习
date: 2012-04-23 05:29:46
---

国外博客最近公布了关于wordpress主题的一个0day,这些主题都使用了timthumb.php这个文件，该文件用于处理图片的显示效果等，原文地址可以参见：[http://sebug.net/vuldb/ssvid-20811](http://sebug.net/vuldb/ssvid-20811 "WordPress TimThumb Plugin - Remote Code Execution") 。这里具体分析下漏洞的成因，其实在国外这篇文章也有分析，只是不是很清晰.

### PHP 与 Wordpress 介绍 Appdir

[PHP](http://sebug.net/appdir/PHP)

[WordPress](http://sebug.net/appdir/WordPress)

## 漏洞成因

大家可以首先打开这个链接，[版本控制](http://sebug.net/lto?url=http://code.google.com/p/timthumb/source/list?path=/trunk/timthumb.php&amp;start=147)，可以看到：

[r143](http://sebug.net/lto?url=http://code.google.com/p/timthumb/source/detail?r=143&amp;path=/trunk/timthumb.php) ,`stronger website domain checks (don’t allow http://wordpress.com.hacker.com/)`

作者在这里标明了已经修复了这个漏洞，那么我们就对比下r143和r142两个版本的区别。

对比分析这两个版本，发现结果如下：

```
foreach ($allowedSites as $site) {
    if (strpos (strtolower ($url_info['host']), $site) !== false) {
        $isAllowedSite = true;
}
foreach ($allowedSites as $site) {
    if (strpos (strtolower ($url_info['host'] . ‘/’), $site) !== false) {
        $isAllowedSite = true;
}
```

多了一个’/'，在匹配的时候限制了白名单域名只能在地址的最后面，这样就限制了可以在任意的域名前面加上白名单的域名，举个例子来说，我们假如有域名xyz.com，那么我们可以随便添加二、三级域名。先看看timthumb限制了哪些域名。

```
// external domains that are allowed to be displayed on your website
$allowedSites = array (
        ‘flickr.com’,
        ‘picasa.com’,
        ‘blogger.com’,
        ‘wordpress.com’,
        ‘img.youtube.com’,
        ‘upload.wikimedia.org’,
);
```

这样的话我们就可以添加blogger.com.xyz.com，成功绕过白名单的检测。看到这里我不禁想到我上次分析的百度贴吧flash过滤机制研究，也存在一定的问题，因此在匹配或者是搜索的时候需要特别注意。

## 利用

如果大家看了原文的留言，别人给出了利用方法（不过我没域名测试），这里我们还是对源码进行一下分析。

首先是引入url的地方：

```
// sort out image source
$src = get_request (‘src’, ”);
if ($src == ” || strlen ($src) &lt;= 3) {
    display_error (‘no image specified’);
}
```

get_request函数：

```
/**
 *
 * @param [HTML_REMOVED] $property
 * @param [HTML_REMOVED] $default
 * @return [HTML_REMOVED]
 */
function get_request ($property, $default = 0) {
    if (isset ($_GET[$property])) {
        return $_GET[$property];
    } else {
        return $default;
    }
}
```

然后是文件检查：

```
// clean params before use
$src = clean_source ($src);
// get mime type of src
$mime_type = mime_type ($src);
// used for external websites only
$external_data_string = ”;
// generic file handle for reading and writing to files
$fh = ”;
// check to see if this image is in the cache already
// if already cached then display the image and die
check_cache ($mime_type);
```

其中cleansource函数中调用checkexternal函数实现了写文件操作。

```
**
 *
 * @global array $allowedSites
 * @param string $src
 * @return string
 */
function check_external ($src) {
        global $allowedSites;
        // work out file details
        $fileDetails = pathinfo ($src);
        $filename = ‘external_’ . md5 ($src);  //注意这个地方是文件生成后的文件名
        $local_filepath = DIRECTORY_CACHE . ‘/’ . $filename . ‘.’ . strtolower ($fileDetails['extension']);
        // only do this stuff the file doesn’t already exist
        if (!file_exists ($local_filepath)) {
                if (strpos (strtolower ($src), ‘http://’) !== false || strpos (strtolower ($src), ‘https://’) !== false) {
                        if (!validate_url ($src)) {
                                display_error (‘invalid url’);
                        }
                        $url_info = parse_url ($src);
                        // convert youtube video urls
                        // need to tidy up the code
                        if ($url_info['host'] == ‘www.youtube.com’ || $url_info['host'] == ‘youtube.com’) {
                                parse_str ($url_info['query']);
                                if (isset ($v)) {
                                        $src = ‘http://img.youtube.com/vi/’ . $v . ‘/0.jpg’;
                                        $url_info['host'] = ‘img.youtube.com’;
                                }
                        }
                        // check allowed sites (if required)
                        if (ALLOW_EXTERNAL) {
                                $isAllowedSite = true;
                        } else {
                                $isAllowedSite = false;  //注意这个地方是重点
                                foreach ($allowedSites as $site) {
                                        if (strpos (strtolower ($url_info['host']), $site) !== false) {
                                                $isAllowedSite = true;
                                        }
                                }
                        }
                        // if allowed  //判断正确了就直接写文件了。
                        if ($isAllowedSite) {
                                if (function_exists (‘curl_init’)) {
                                        global $fh;
                                        $fh = fopen ($local_filepath, ‘w’);
                                        $ch = curl_init ($src);
                                        curl_setopt ($ch, CURLOPT_TIMEOUT, CURL_TIMEOUT);
                                        curl_setopt ($ch, CURLOPT_USERAGENT, ‘Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.7.5) Gecko/20041107 Firefox/1.0′);
                                        curl_setopt ($ch, CURLOPT_URL, $src);
                                        curl_setopt ($ch, CURLOPT_RETURNTRANSFER, TRUE);
                                        curl_setopt ($ch, CURLOPT_HEADER, 0);
                                        curl_setopt ($ch, CURLOPT_SSL_VERIFYPEER, FALSE);
                                        curl_setopt ($ch, CURLOPT_FILE, $fh);
                                        curl_setopt ($ch, CURLOPT_WRITEFUNCTION, ‘curl_write’);
                                        // error so die
                                        if (curl_exec ($ch) === FALSE) {
                                                unlink ($local_filepath);
                                                touch ($local_filepath);
                                                display_error (‘error reading file ‘ . $src . ‘ from remote host: ‘ . curl_error ($ch));
                                        }
                                        curl_close ($ch);
                                        fclose ($fh);
                } else {
                                        if (!$img = file_get_contents ($src)) {
                                                display_error (‘remote file for ‘ . $src . ‘ can not be accessed. It is likely that the file’);
                                        }
                                        if (file_put_contents ($local_filepath, $img) == FALSE) {
                                                display_error (‘error writing temporary file’);
                                        }
                                }
                                if (!file_exists ($local_filepath)) {
                                        display_error (‘local file for ‘ . $src . ‘ can not be created’);
                                }
                                $src = $local_filepath;
                        } else {
                                display_error (‘remote host “‘ . $url_info['host'] . ‘” not allowed’);
                        }
                }
    } else {
                $src = $local_filepath;
        }
    return $src;
}
```

## 修复

作者已经修复了漏洞，可以到 [http://timthumb.googlecode.com/svn/trunk/timthumb.php](http://timthumb.googlecode.com/svn/trunk/timthumb.php "http://timthumb.googlecode.com/svn/trunk/timthumb.php") 更新你的 timthumb 脚本 。最新版本为 2.8.10

wordpress的一些插件很可能存在漏洞，所以使用的时候请注意。可以到儿查找一些wordpress漏洞方面的问题。

[http://sebug.net/appdir/WordPress](http://sebug.net/appdir/WordPress "http://sebug.net/appdir/WordPress")

里面介绍了wordpress的某些插件引起的安全问题。