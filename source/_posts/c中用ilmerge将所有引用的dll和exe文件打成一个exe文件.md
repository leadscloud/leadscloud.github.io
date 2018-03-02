---
title: c中用ilmerge将所有引用的dll和exe文件打成一个exe文件
id: 313508
categories:
  - 转载
date: 2012-11-03 14:53:44
tags:
---

今天做了一个软件,想发布的时候才发现调用的类没几个,就像把它们都跟EXE文件打包在一起,以后复制去别的地方用也方便,于是上网搜了一下,发现网上大部分都是用ILMerge实现的,于是也自己试了一下,不过网上都没有详细的步骤演示,我就花点时间做了个教程,方便以后再有人想打包自己的程序,有篇文章可以参考,好了废话少说,马上开始:

1. 先到[http://www.microsoft.com/downloads/details.aspx?FamilyID=22914587-B4AD-4EAE-87CF-B14AE6A939B0&amp;displaylang=en](http://www.microsoft.com/downloads/details.aspx?FamilyID=22914587-B4AD-4EAE-87CF-B14AE6A939B0&amp;displaylang=en)下载ILMerge,才600多K,一下子就下好了.

 ![](http://pic002.cnblogs.com/img/sd7087003/201003/2010032818242331.png)

2. 下载后是安装:

 ![](http://pic002.cnblogs.com/img/sd7087003/201003/2010032818244746.png)

3. 不到一分钟就可以安装完毕:

![](http://pic002.cnblogs.com/img/sd7087003/201003/2010032818245844.png)

4. 我是安装在I盘下ILMerge目录下,以下是安装后的文件,就一个ILMerge.exe文件而已,我们等会就是用它打包程序的.

![](http://pic002.cnblogs.com/img/sd7087003/201003/2010032818250797.png)

5. 为了演示,我重新建了个工程,最后生成的是 Main.exe 和 newDll文件,其中newDll是Main.exe 中要引用的Dll文件,为了演示方便,我将它们都复制到了ILMerge的目录下,现在我们就试着用ILMerge将newDll和Main.exe文件打包起来吧.

![](http://pic002.cnblogs.com/img/sd7087003/201003/2010032818251767.png)

6. 然后进入dos窗口，进入ILMerge目录,然后执行下面代码:

I:\ILMerge\ILMerge.exe /ndebug /target:winexe  /out:newclient.exe MainExe.exe  /log newDll.dll

![](http://pic002.cnblogs.com/img/sd7087003/201003/2010032818252948.png)

7. ILMerge运行时的窗口,此时它正在努力的将Main.exe和newDll文件捆绑在一起:

![](http://pic002.cnblogs.com/img/sd7087003/201003/2010032818254761.png)

8. DOS窗口关闭后,我们在去ILMerge目录下看看,此时已经生成好了我们想要的newclient.exe文件,它就是Main.exe和newDll.dll的结合体啦:

 ![](http://pic002.cnblogs.com/img/sd7087003/201003/2010032818253873.png)

以上实验在WIN7下.net framework3.5 平台，vs2008环境中测试通过

原文：[http://www.cnblogs.com/huangcong/archive/2010/03/28/1698973.html](http://www.cnblogs.com/huangcong/archive/2010/03/28/1698973.html)