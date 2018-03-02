---
title: Live Mesh和Dropbox免费网盘高级使用技巧
tags:
  - 网盘
id: 313251
categories:
  - 转载
date: 2012-02-09 06:18:46
---

[Dropbox](http://www.dropbox.com/)和[Live Mesh](http://www.mesh.com/)都是常用的网络存储服务，可以实现多台电脑上[文件共享](http://www.williamlong.info/archives/1385.html)和同步文件，微软的Live Mesh提供的空间是5GB空间，而Dropbox提供的初始免费空间是2GB，可以通过邀请增大到5GB，两个网络同步软件各有千秋，但我感觉Dropbox更为好用一些，这里，我就介绍一下我在使用Dropbox的过程中总结的几个小技巧。

**1、同步任意文件夹**

Dropbox安装完成之后，通常会在你电脑上建立一个My Dropbox文件夹，放到这个文件夹里的文件才进行同步。这点不如Live Mesh好用，至少Mesh可以同步例如“桌面”等指定的文件夹，而Dropbox只能同步固定文件夹，为了解决同步其他文件夹的问题，需要使用junction/mklink工具来解决。

对于Windows XP用户来说，微软就提供了一个小工具junction，可以在NTFS系统中创建和删除一个junction目录，该目录和原始目录的内容一模一样，如果你对其中任意一个文件夹里面的内容做修改，另一个也会相应的改变，junction目录是NTFS文件系统的一个特性，但Windows XP没有工具对其进行操作，需要[点这里下载](http://download.sysinternals.com/Files/Junction.zip)一个exe文件才能使用。在Windows 7系统下已经内部支持，其命令为mklink，使用方法和junction相同。

例如，我们可以执行junction "E:\My Documents" "E:\My Dropbox\My Documents" ，命令的意思是创建一个名为E:\My Documents的junction目录，指向E:\My Dropbox\My Documents，该命令瞬间执行完成，而两个目录则完全相同，这样我们就可以使用E:\My Dropbox\My Documents这个目录来替代“我的文档”中的目录。

对于Dropbox来说，只能按照如上的命令建立junction目录，而不能在My Dropbox目录里创建junction目录，经过我的测试，My Dropbox目录里面的junction目录只能同步一次，之后修改加文件都不同步，无法实现同步更新。

![Dropbox免费网盘](http://www.williamlong.info/upload/2044_1.jpg)

**2、同步MSN和QQ记录**

如果我们同时在家里和公司上MSN和QQ，就会遇到一个麻烦问题，就是聊天记录不同步，公司一处，家里一处，使用Dropbox可以实现两地的聊天记录同步。

首先按照上面的操作将My Documents我的文档目录设置为junction目录，实际文件放到My Dropbox目录中，接着，在QQ和MSN中设置默认保存文件和聊天记录的位置在“我的文档”中，这样，用户所有聊天记录都会自动被Dropbox同步，从而实现了家中和公司两处聊天记录的同步更新。

**3、同步文档**

“我的文档”里保存了用户很多重要文档，很多人都有同步“我的文档”的需要。同步的方法是，右点“我的文档”属性，修改“我的文档”的目标文件夹位置，将其修改到Dropbox目录下即可。

4**、同步桌面**

除了“我的文档”，很多人希望将多台电脑的桌面文件进行同步，有两种解决方案，一种是修改注册表中关于桌面的位置，将文件夹修改到Dropbox目录里，注册表修改的位置是： HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\User Shell Folders 和 HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\Shell Folders 中关于Desktop的路径；另一种方法，可以通过在桌面创建一个junction目录的方式实现同步，这样桌面上就会多一个实际为junction类型的“文件夹”，将工作文档或者其他文档复制到这个文件夹中，即可实现同步。

5**、同步IE收藏夹**

默认情况下IE的收藏夹路径为： C:\Documents and Settings\Administrator\Favorites ，我们可以通过修改注册表的方式来修改收藏夹的路径，打开注册表： HKEY_USERs\Software\Microsoft\Windows\CurrentVersion\Explorer\User Shell Folders ，而后把“Favorites”键值修改成My Dropbox目录下的一个文件夹路径即可。在多台电脑都进行这样的操作，就可以实现多台电脑自动同步IE收藏夹的功能。

6**、网站自动备份**

如果你也拥有一个类似“月光博客”的网站，你也会为数据的安全性而头疼，如何安全地自动备份网站数据呢？有了Dropbox，我们就有了一个网站自动备份的新方案。

对于使用SQL Server的网站来说，可以在SQL Server中设置一个自动执行任务，每天自动将数据库文件备份到My Dropbox目录里即可。

对于使用Access的网站来说，频繁读写的Access文件不宜直接放到Dropbox目录里，而采用定时复制的方法更好一些。具体操作是，建立一个BAT文件，内容是“xcopy "E:\website" "E:\My Dropbox\website" /s/e/y”，在“系统工具 - 任务计划”中新建一个计划任务，选择这个批处理文件，设置每天临晨自动执行，就可以定时自动把website目录下的网站文件（包括ACCESS文件）一起复制到Dropbox目录中的website文件夹。

这样，就实现了使用Dropbox可以自动将网站上的文件和数据库进行备份，无需手动操作。缺点是最多5G空间，不适合大网站的备份。

好了，以上就是我在使用Dropbox过程中总结的一些小技巧，总的来说，Dropbox是一个非常不错的网络同步工具，Live Mesh相比Dropbox来说有几个缺点，比如只支持Windows，不支持Linux、Mac，兼容性较差（例如在我公司的电脑上安装Live Mesh就报错，无法安装），另外Live Mesh的界面有待进一步优化。

Dropbox的默认空间是2G，如果你也想使用Dropbox，[点这里](https://www.dropbox.com/referrals/NTMzMTcxNjY5)注册Dropbox帐号，如果你邀请其他用户使用的话，每邀请一个用户注册也可获得250M空间，最大到5G空间封顶。

原文：[http://www.williamlong.info/archives/2044.html](http://www.williamlong.info/archives/2044.html)