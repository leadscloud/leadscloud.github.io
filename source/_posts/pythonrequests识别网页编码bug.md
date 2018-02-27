---
title: pythonrequests识别网页编码bug
tags:
  - python
  - requests
id: 313896
categories:
  - 转载
date: 2014-08-05 22:00:33
---

Requests 使用的是 urllib3，因此继承了它的所有特性。Requests 支持 HTTP 连接保持和连接池，支持使用 cookie 保持会话，支持文件上传，支持自动确定响应内容的编码，支持国际化的 URL 和 POST 数据自动编码。现代、国际化、人性化。

最近在使用Requests的过程中发现一个问题，就是抓去某些中文网页的时候，出现乱码，打印encoding是ISO-8859-1。为什么会这样呢？通过查看源码，我发现默认的编码识别比较简单，直接从响应头文件的Content-Type里获取，如果存在charset，则可以正确识别，如果不存在charset但是存在text就认为是ISO-8859-1，见utils.py。

<pre class="lang:python decode:true " >def get_encoding_from_headers(headers):
    """Returns encodings from given HTTP Header Dict.

    :param headers: dictionary to extract encoding from.
    """
    content_type = headers.get('content-type')

    if not content_type:
        return None

    content_type, params = cgi.parse_header(content_type)

    if 'charset' in params:
        return params['charset'].strip("'\"")

    if 'text' in content_type:
        return 'ISO-8859-1'</pre> 

其实Requests提供了从内容获取编码，只是在默认中没有使用，见utils.py：

<pre class="lang:python decode:true " >def get_encodings_from_content(content):
    """Returns encodings from given content string.

    :param content: bytestring to extract encodings from.
    """
    charset_re = re.compile(r'&lt;meta.*?charset=["\']*(.+?)["\'&gt;]', flags=re.I)
    pragma_re = re.compile(r'&lt;meta.*?content=["\']*;?charset=(.+?)["\'&gt;]', flags=re.I)
    xml_re = re.compile(r'^&lt;\?xml.*?encoding=["\']*(.+?)["\'&gt;]')

    return (charset_re.findall(content) +
            pragma_re.findall(content) +
            xml_re.findall(content))</pre> 

还提供了使用chardet的编码检测，见models.py:

<pre class="lang:python decode:true " >@property
def apparent_encoding(self):
    """The apparent encoding, provided by the lovely Charade library
    (Thanks, Ian!)."""
    return chardet.detect(self.content)['encoding']</pre> 

如何修复这个问题呢？先来看一下示例：

<pre class="lang:python decode:true " >&gt;&gt;&gt; r = requests.get('http://cn.python-requests.org/en/latest/')
&gt;&gt;&gt; r.headers['content-type']
'text/html'
&gt;&gt;&gt; r.encoding
'ISO-8859-1'
&gt;&gt;&gt; r.apparent_encoding
'utf-8'
&gt;&gt;&gt; requests.utils.get_encodings_from_content(r.content)
['utf-8']

&gt;&gt;&gt; r = requests.get('http://reader.360duzhe.com/2013_24/index.html')
&gt;&gt;&gt; r.headers['content-type']
'text/html'
&gt;&gt;&gt; r.encoding
'ISO-8859-1'
&gt;&gt;&gt; r.apparent_encoding
'gb2312'
&gt;&gt;&gt; requests.utils.get_encodings_from_content(r.content)
['gb2312']</pre> 

通过了解，可以这么用一个monkey patch解决这个问题：

<pre class="lang:python decode:true " >import requests
def monkey_patch():
    prop = requests.models.Response.content
    def content(self):
        _content = prop.fget(self)
        if self.encoding == 'ISO-8859-1':
            encodings = requests.utils.get_encodings_from_content(_content)
            if encodings:
                self.encoding = encodings[0]
            else:
                self.encoding = self.apparent_encoding
            _content = _content.decode(self.encoding, 'replace').encode('utf8', 'replace')
            self._content = _content
        return _content
    requests.models.Response.content = property(content)
monkey_patch()</pre> 

原文：http://liguangming.com/python-requests-ge-encoding-from-headers