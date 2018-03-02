---
title: selenium python自动化测试环境搭建
tags:
  - python
  - selenium
id: 313778
categories:
  - 技术
date: 2014-03-17 08:03:29
---

selenium 是一个web的自动化测试工具，不少学习功能自动化的同学开始首选selenium ，相因为它相比QTP有诸多有点：

*  免费，也不用再为破解QTP而大伤脑筋

*  小巧，对于不同的语言它只是一个包而已，而QTP需要下载安装1个多G 的程序。

*  这也是最重要的一点，不管你以前更熟悉C、 java、ruby、python、或都是C# ，你都可以通过selenium完成自动化测试，而QTP只支持VBS

*  支持多平台：windows、linux、MAC ，支持多浏览器：ie、ff、safari、opera、chrome

*  支持分布式测试用例的执行，可以把测试用例分布到不同的测试机器的执行，相当于分发机的功能。


关于selenium的基础知识与java平台的结合，我之前写过一个《菜鸟学习自动化测试》系列，最近学python，所以想尝试一下selenium的在python平台如何搭建；还好这方法的文章很容易，在此将搭建步骤整理分享。


搭建平台windows

准备工具如下：

-------------------------------------------------------------

## 下载python

[http://python.org/getit/](http://python.org/getit/)

下载setuptools 【python的基础包工具】

[http://pypi.python.org/pypi/setuptools](http://pypi.python.org/pypi/setuptools)

[https://pypi.python.org/packages/2.7/s/setuptools/](https://pypi.python.org/packages/2.7/s/setuptools/)

下载pip 【python的安装包管理工具】

[https://pypi.python.org/pypi/pip](https://pypi.python.org/pypi/pip)

-------------------------------------------------------------

因为版本都在更新，pyhton选择2.7.xx ，setuptools 选择你平台对应的版本，pip 不要担心tar.gz 在windows下一样可用。


## window安装步骤


1、python的安装 ，这个不解释，exe文件运行安装即可，既然你选择python，相信你是熟悉python的，我安装目录C:\Python27

2、setuptools 的安装也非常简单，同样是exe文件，默认会找到python的安装路径，将安装到C:\Python27\Lib\site-packages 目录下。

通过上面提供的setuptools的连接，拖动页面到底部找到，[setuptools-1.3.2.tar.gz](https://pypi.python.org/packages/source/s/setuptools/setuptools-1.3.2.tar.gz#md5=441f2e58c0599d31597622a7b9eb605f) 文件（版本随着时间版本会有更新），对文件进行解压，找到ez_install.py文件，进入windows命令提示下执行ez_install.py：

**C:\setuptools-1.3>python ez_install.py** 没有报错表示安装成功。

（如果提示python不是内部或外部命令！别急，去配置一下环境变量吧）


修改我的电脑->属性->高级->环境变量->系统变量中的PATH为:

变量名：`PATH`

变量值：`;C:\Python27`


3、安装pip ，我默认解压在了C:\pip-1.3.1 目录下

4、打开命令提示符（开始---cmd回车）进入`C:\pip-1.3.1`目录下输入：

`C:\pip-1.3.1 > python setup.py install`

5、再切换到`C:\Python27\Scripts` 目录下输入：

```
C:\Python27\Scripts > easy_install pip
```

6、安装selenium，（下载地址： [https://pypi.python.org/pypi/selenium](https://pypi.python.org/pypi/selenium)    ）

如果是联网状态的话，可以直接在C:\Python27\Scripts  下输入命令安装：

```
C:\Python27\Scripts > pip install -U selenium
```

如果没联网（这个一般不太可能），下载selenium 2.33.0 （目前的最新版本）

并解压把整个目录放到C:\Python27\Lib\site-packages 目录下。

=======如果你不分析wedriver 原理的话，下面两步可以省略=============

7、下载并安装（http://www.java.com/zh_CN/download/chrome.jsp?locale=zh_CN）什么？你没整过java，参考其它文档吧！这不难。

8、 下载selenium 的服务端（https://code.google.com/p/selenium/）在页面的左侧列表中找到

selenium-server-standalone-XXX.jar

对！就是这个东西，把它下载下来并解压；

在selenium-server-standalone-xxx.jar目录下使用命令 java -jar selenium-server-standalone-xxx.jar启动（如果打不开，查看是否端口被占 用：netstat -aon|findstr 4444）。

===============================================

## ubuntu 下安装方式：

### 1、安装：setuptools

```
root@fnngj-H24X:~# apt-get install python-setuptools
```

### 2、安装pip

```
root@fnngj-H24X:/home/fnngj/python# tar -zxvf pip-1.4.1.tar.gz

root@fnngj-H24X:/home/fnngj/python# cd pip-1.4.1/

root@fnngj-H24X:/home/fnngj/python# python setup.py install
```

### 3、安装selenium

```
root@fnngj-H24X:/home/fnngj/python/pip-1.4.1# pip install -U selenium
```

恭喜~！ 你前期工作已经做了，上面的步骤确实有些繁琐，但是并不难，不过我们已经完成成了，下面体验一下成果吧！ 拿python网站上的例子：


```
from selenium import webdriver
from selenium.common.exceptions import NoSuchElementException
from selenium.webdriver.common.keys import Keys
import time

browser = webdriver.Firefox() # Get local session of firefox
browser.get("http://www.yahoo.com") # Load page
assert "Yahoo!" in browser.title
elem = browser.find_element_by_name("p") # Find the query box
elem.send_keys("seleniumhq" + Keys.RETURN)
time.sleep(0.2) # Let the page load, will be added to the API
try:
    browser.find_element_by_xpath("//a[contains(@href,'http://seleniumhq.org')]")
except NoSuchElementException:
    assert 0, "can't find seleniumhq"
browser.close()
```

（运行过程中如果出现错误：

    WebDriverException: Message: u'Unexpected error launching Internet Explorer.

    Protected Mode settings are not the same for all zones. Enable Protected Mo

    de must be set to the same value (enabled or disabled) for all zones.'

更改IE的internet选项->安全，将Internet/本地Internet/受信任的站定/受限制的站点中的启用保护模式全部去 掉勾，或者全部勾上。）

-----------------------------------------

selenium + python的一份不错文档

[http://selenium.googlecode.com/git/docs/api/py/index.html](http://selenium.googlecode.com/git/docs/api/py/index.html)


===========================如果想通过其它浏览器（IE Chrome）运行脚本=================================


## **安装Chrome driver**

chrome driver的下载地址在[这里](https://code.google.com/p/chromedriver/downloads/list)。

1. 下载解压，你会得到一个chromedriver.exe文件（我点开，运行提示started no prot 9515 ，这是干嘛的？端口9515被占了？中间折腾了半天），后来才知道需要把这家伙放到chrome的安装目录下...\Google\Chrome\Application\ ,然后设置path环境变量，把chrome的安装目录（我的：C:\Program Files\Google\Chrome\Application），然后再调用运行：

```
# coding = utf-8

from selenium import webdriver

driver = webdriver.Chrome()

driver.get('http://radar.kuaibo.com')

print driver.title

driver.quit()
```

又报了个错：

    Chrome version must be >= 27.0.1453.0\n  (Driver info: chromedriver=2.0,platform=Windows NT 5.1 SP3 x86)

说我chrome的版本没有大于27.0.1453.0 ，这个好办，更新到最新版本即可。

## **安装IE driver**

在新版本的webdriver中，只有安装了ie driver使用ie进行测试工作。

ie driver的下载地址在[这里](https://code.google.com/p/selenium/downloads/list)，记得根据自己机器的操作系统版本来下载相应的driver。

暂时还没尝试，应该和chrome的安装方式类似。


**记得配置IE的保护模式**

如果要使用webdriver启动IE的话，那么就需要配置IE的保护模式了。

把IE里的保护模式都选上或都勾掉就可以了。

乙醇的安装方式：

[http://easonhan007.github.io/python/2013/05/07/setup-env/](http://easonhan007.github.io/python/2013/05/07/setup-env/)

5分钟安装好selenium webdriver + python 环境：

[http://v.youku.com/v_show/id_XNjQ1MDI5Nzc2.html?qq-pf-to=pcqq.group](http://v.youku.com/v_show/id_XNjQ1MDI5Nzc2.html?qq-pf-to=pcqq.group)