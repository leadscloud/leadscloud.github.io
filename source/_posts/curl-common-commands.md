---
title: curl常用命令
date: 2023-06-06 11:43:53
tags: curl
id: 20230606
categories: 技术
---

网站使用cloudflare时，无法得到真正的ip，如果知道域名的ip，一般使用下面的命令探测

```
curl -v -H "Host: leadscloud.xyz" 167.172.xx.xx
```

### CURL重定向

通过-L选项进行重定向 默认情况下CURL不会发送HTTP Location headers(重定向).当一个被请求页面移动到另一个站点时，会发送一个HTTP Loaction header作为请求，然后将请求重定向到新的地址上。

```
# 让curl使用地址重定向，此时会查询google.com.hk站点
curl -L http://www.google.com
```

### 下载单个文件，默认将输出打印到标准输出中(STDOUT)中

	curl http://www.centos.org

### 通过-o/-O选项保存下载的文件到指定的文件中：
> 1. -o：将文件保存为命令行中指定的文件名的文件中
> 1. -O：使用URL中默认的文件名保存文件到本地

	# 将文件下载到本地并命名为mygettext.html
	  curl -o mygettext.html http://www.gnu.org/software/gettext/manual/gettext.html
	 
	# 将文件保存到本地并命名为gettext.html
	  curl -O http://www.gnu.org/software/gettext/manual/gettext.html

同样可以使用转向字符">"对输出进行转向输出

### 同时获取多个文件

	curl -O URL1 -O URL2

若同时从同一站点下载多个文件时，curl会尝试重用链接(connection)。


### 断点续传

通过使用-C选项可对大文件使用断点续传功能，如：

	# 当文件在下载完成之前结束该进程
	$ curl -O http://www.gnu.org/software/gettext/manual/gettext.html
	##############             20.1%
	
	# 通过添加-C选项继续对该文件进行下载，已经下载过的文件不会被重新下载
	curl -C - -O http://www.gnu.org/software/gettext/manual/gettext.html
	###############            21.1%

### CURL授权

```
curl -u username:password URL
 
# 通常的做法是在命令行只输入用户名，之后会提示输入密码，这样可以保证在查看历史记录时不会将密码泄露
curl -u username URL
```

### 上传文件到FTP服务器

通过 -T 选项可将指定的本地文件上传到FTP服务器上

	# 将myfile.txt文件上传到服务器
	curl -u ftpuser:ftppass -T myfile.txt ftp://ftp.testserver.com
	
	# 同时上传多个文件
	curl -u ftpuser:ftppass -T "{file1,file2}" ftp://ftp.testserver.com
	
	# 从标准输入获取内容保存到服务器指定的文件中
	curl -u ftpuser:ftppass -T - ftp://ftp.testserver.com/myfile_1.txt

### 为CURL设置代理

x 选项可以为CURL添加代理功能

	 # 指定代理主机和端口
	 curl -x proxysever.test.com:3128 http://google.co.in

### 保存与使用网站cookie信息

	 # 将网站的cookies信息保存到sugarcookies文件中
	 curl -D sugarcookies http://localhost/sugarcrm/index.php
	 
	 # 使用上次保存的cookie信息
	 curl -b sugarcookies http://localhost/sugarcrm/index.php

### 设置user-agent

`-A`参数指定客户端的用户代理标头，即`User-Agent`。curl的默认用户代理字符串是`curl/[version]`。


```
$ curl -A 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/76.0.3809.100 Safari/537.36' https://google.com
```

也可以通过`-H`参数直接指定标头，更改`User-Agent`。

	curl -H 'User-Agent: php/1.0' https://google.com

### 传递请求数据

默认curl使用GET方式请求数据，这种方式下直接通过URL传递数据
可以通过 --data/-d 方式指定使用POST方式传递数据

	# GET
	curl -u username https://api.github.com/user?access_token=XXXXXXXXXX
	
	# POST
	curl -u username --data "param1=value1&param2=value" https://api.github.com
	
	# 也可以指定一个文件，将该文件中的内容当作数据传递给服务器端
	curl --data @filename https://github.api.com/authorizations

注：默认情况下，通过POST方式传递过去的数据中若有特殊字符，首先需要将特殊字符转义在传递给服务器端，如value值中包含有空格，则需要先将空格转换成%20，如：

	curl -d "value%201" http://hostname.com

在新版本的CURL中，提供了新的选项 --data-urlencode，通过该选项提供的参数会自动转义特殊字符。

	curl --data-urlencode "value 1" http://hostname.com

除了使用GET和POST协议外，还可以通过 -X 选项指定其它协议，如：

	curl -I -X DELETE https://api.github.cim

上传文件

	curl --form "fileupload=@filename.txt" http://hostname/resource

### 获取更多信息

通过使用 -v 和 -trace获取更多的链接信息

### 显示头信息

- `-i` 参数：可以显示http response 的头信息，连同网页代码一起。
- `-I` 参数：则只显示http response 的头信息, 不显示网页源码。 同 --head
