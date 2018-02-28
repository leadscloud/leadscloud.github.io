---
title: 通过ssh使用rsync简单备份你的网站
tags:
  - rsync
  - 备份
id: 313734
categories:
  - 个人日志
date: 2014-03-08 01:42:22
---

如果你想要从一台电脑上备份一个目录，但你仅仅想要复制改变的文件到它的备份而不是复制所有的东西到各自的备份，你可以使用工具rsync来实现它。你需要在这个远程的源备份计算机上有一个账户。下面是这条命令：

`rsync -vare ssh root@192.168.1.10:/home/wwwroot/love4026.org/* /home/wwwroot/love4026.org/`

**Rsync 参数选项说明**

-v, --verbose 详细模式输出
-q, --quiet 精简输出模式
-c, --checksum 打开校验开关，强制对文件传输进行校验
-a, --archive 归档模式，表示以递归方式传输文件，并保持所有文件属性，等于-rlptgoD
-r, --recursive 对子目录以递归模式处理
-R, --relative 使用相对路径信息
-e, --rsh=COMMAND 指定使用rsh、ssh方式进行数据同步

-l, --links 保留软链结
-p, --perms 保持文件权限
-t, --times 保持文件时间信息
-g, --group 保持文件属组信息
-o, --owner 保持文件属主信息
-D, --devices 保持设备文件信息
-z, --compress 对备份的文件在传输时进行压缩处理

rsync使大型目录结构保持同步。通过SSH使用tar远程复制一个文件系统的一部分是非常理想的，sync甚至更适合保持两台机器之间的文件系统的同步。为了使用SSH运行一个rsyns，传递给它一个-e转换：

`rsync -ave ssh greendome:/home/ftp/pub/ /home/ftp/pub/`

注意从源端（在greendome上）来的文件说明后面的 / ，在源说明中，一个尾部的 / 告诉rsync这个目录的内容，但不是目录本身。为了将目录放入正在复制的内容的最高等级丢掉这个 /：

`rsync -ave ssh bcnu:/home/six .`

这将在 ~/six/目录下保持一个与bcnu:/home/six/上的任何东西同步的复制品。rsync默认只拷贝文件和目录，但是当源端移除了文件时并不会在目的端移除它们的拷贝。为了保持复制的精确性，包含–delete这个标志：

现在当老的报表从greendome上的~one/reports/中移除了，在同步版本中，每次这个命令运行时，它们也将会从~six/public_html/reports/中移除。如果你在corn中像这样运行一条命令，记得丢掉v。这将会使输出稳定（除非rsync在运行中出现问题，在这种情况下你将会收到一封有错误输出的邮件）。使用SSH作为你的rsync运输方式，这样做的好处是使数据在网络传输过程中加密，并可以方便使用任何你已经用SSH客户端密钥建立的信任关系。

`rsync -ave ssh--delete greendome:~one/reports .`

更新：备份远程数据库还有一个方法，此方法不要求两边的电脑上都必须安装rsync,就是使用tar命令。一边tar一边通过ssh传到服务器并且自动解压缩，最后会得到远程服务器上文件夹的一份完美备份，并且在目标服务器上不会写入任何文件。方法如下：


`tar zcf - /some/localfolder | ssh remotehost.domain.com "cd /some/path/name; tar zxpf -" `