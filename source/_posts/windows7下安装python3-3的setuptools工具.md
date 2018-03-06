---
title: windows7下安装python3.3的setuptools工具
tags:
  - python
id: 313752
categories:
  - 个人日志
date: 2014-03-12 06:08:14
---

安装方法见： https://pypi.python.org/pypi/setuptools/0.9.8#windows

安装过程：

```
copying setuptools.egg-info\top_level.txt -> build\bdist.win-amd64\egg\EGG-INFO
copying setuptools.egg-info\zip-safe -> build\bdist.win-amd64\egg\EGG-INFO
creating dist
creating 'dist\setuptools-3.1-py3.3.egg' and adding 'build\bdist.win-amd64\egg'
to it
removing 'build\bdist.win-amd64\egg' (and everything under it)
Processing setuptools-3.1-py3.3.egg
Copying setuptools-3.1-py3.3.egg to c:\python33\lib\site-packages
Adding setuptools 3.1 to easy-install.pth file
Installing easy_install-script.py script to C:\Python33\Scripts
Installing easy_install.exe script to C:\Python33\Scripts
Installing easy_install-3.3-script.py script to C:\Python33\Scripts
Installing easy_install-3.3.exe script to C:\Python33\Scripts

Installed c:\python33\lib\site-packages\setuptools-3.1-py3.3.egg
Processing dependencies for setuptools==3.1
Finished processing dependencies for setuptools==3.1
```

运行python程序时出现 


    No module named 'requests'
    You can install missing modules with `pip3 install [modulename]`


安装好setuptools后，使用以下命令即可安装 `requests`

```
C:\Python33\Scripts>easy_install.exe requests
Searching for requests
Reading https://pypi.python.org/simple/requests/
Best match: requests 2.2.1
Downloading https://pypi.python.org/packages/source/r/requests/requests-2.2.1.ta
r.gz#md5=ac27081135f58d1a43e4fb38258d6f4e
Processing requests-2.2.1.tar.gz
Writing c:\users\admini~1\appdata\local\temp\easy_install-4bjzke\requests-2.2.1\
setup.cfg
Running requests-2.2.1\setup.py -q bdist_egg --dist-dir c:\users\admini~1\appdat
a\local\temp\easy_install-4bjzke\requests-2.2.1\egg-dist-tmp-9woril
Adding requests 2.2.1 to easy-install.pth file

Installed c:\python33\lib\site-packages\requests-2.2.1-py3.3.egg
Processing dependencies for requests
Finished processing dependencies for requests
```