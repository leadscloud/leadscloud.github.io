---
title: Wordpress使用SQL语句替换所有关键词
tags:
  - wordpress
id: 20211231
categories:
  - Wordpress学习
date: 2021-12-31 10:09:03
---

Wordpress 使用 Eelementor 插件时，编辑内容，会保存到wp_postmeta中，对于中文一些替换插件 `Better Search Replace` 等没有问题，但如果是中文，你会发现使用替换工具替换后，内容不变。

这主要是因为中文内容保存为json格式后，会编码为unicode格式，所以无法替换，可以使用下面方法替换。


```
select count(*) from wp_postmeta where meta_value like '%\\\\u539f\\\\u59cb\\\\u5b57%\\\\u7b26';
```

  >SELECT语句中四个反斜杠（\）代表一个.
  >在mysql的like语法中，like后边的字符串除了会在语法解析时转义一次外，还会在正则匹配时进行第二次的转义。因此如果期望最终匹配到""，就要反转义两次，也就是由"\"到"\"再到""。
  >如果是普通的精确查询（=），则无需第二次的正则转义，和INSERT语句一样。

比如 `原始字符` 替换为 `替换字符`

```
UPDATE wp_postmeta 
SET meta_value = REPLACE( 
  meta_value, 
  '\\\u539f\\\u59cb\\\u5b57\\\u7b26', 
  '\\\u66ff\\\u6362\\\u5b57\\\u7b26' 
);
```

> 可以使用js的 `escape` 来把中文转为unicode编码

### wordpress内容替换SQL语句

```
UPDATE wp_options SET option_value = replace(option_value, 'http://www.yoursitename.com', 'http://localhost') WHERE option_name = 'home' OR option_name = 'siteurl';
UPDATE wp_posts SET post_content = replace(post_content, 'http://www.yoursitename.com', 'http://localhost');
UPDATE wp_postmeta SET meta_value = replace(meta_value,'http://www.yoursitename.com','http://localhost');
```

### mysqldump工具来备份wordpress数据库

在操作前，无论使用插件还是sql语句，都要先备份数据库

```
sudo mysqldump -u root wordpress > wordpress.sql
```

### 备份wordpress根目录下的所有文件

```
sudo tar -cpvzf wordpress.tar.gz /home/wwwroot/wordpress/
```

上面的命令包含5个参数，分别为：

- -c 创建一个归档文件；
- -p 保留已归档文件的相应权限设置；
- -v 显示详细信息；
- -z 使用gzip压缩归档文件；
- -f 代表文件。

执行上述命令后，`/home/wwwroot/wordpress/`文件夹下的所有文件都会被归档和压缩。