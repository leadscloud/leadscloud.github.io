---
title: lftp的用法
tags:
  - lftp
id: 313385
categories:
  - Linux
date: 2012-05-29 05:33:57
---

lftp支持tab自动补全

登陆方法

```
lftp username:password@ftpaddr:port(defalut:21)
lftp ftphost -u username
```

!
可执行本地端 shell 中的命令, 如 !ls /usr/local/bin/
由於 lftp 并没有 lls(显示本地端档案列表的指令), 故可用 !ls 来替代。

下载：

  mget -C *.jpg  (把所有pdf文件以允许断点续传的方式下载，m代表multi)
  mirror aaa/  (把aaa目录整个下载下来，子目录也会自动复制)
  pget -c -n 10 file.dat  (以最多10个线程并允许断点续传的方式下载file.dat，可以通过设置pget:default-n的值而使用默认值)

mirror OPTS remote [local]
下载整个目录(楼上的 get 只能用来抓档案)
-c 续传
-e 这个要小心一些, 比较远端和本地端的档案, 假如远端没有的, 就将本地端的档案删除, 也就是将本地端和远端资料同步。
-R 上传整个目录
-n 只下载较新的档案
-r 不用递回到目录中
--parallel=n 同时下载 n 个档案(预设一次只下载一个)

上传：

  put,mput,都是对文件的上传操作，和get,mget类似。
  mirror -R local_dirname (把本地目录以迭代(包括子目录)方式上传到ftp site)

mv
将远端的 file1 改名为 file2

mrm
用 wildcard expansion 方式来删除远端档案

------
lftp登陆
lftp登陆常用格式：
lftp [-d] [-e cmd] [-p port] [-u user[,pass]] [site]

[-d]
在debug mode运行。

[-e cmd]
执行指定的命令。

[-p port]
指定连接端口。

[-u user[,pass]]
登陆的用户名和密码。

[site]
FTP服务器地址。

例如：
lftp -p 21 -u admin,123456 ftp.aaa.com
表示使用用户名admin、密码123456登陆ftp.aaa.com这个站点，端口为21。

简便格式：
lftp user:password@site:port

例如：
lftp admin:123456@ftp.aaa.com:21
同样可以登陆。

随后就和其它命令行的ftp工具一样使用ftp内部命令进行控制。登陆后输入help可以查看支持的命令。

2、lftp的mirror命令
lftp登陆成功后，使用mirror命令用来备份文件。

将远程服务器上的文件备份到本地：
mirror [选项] [远程目录] [本地目录]

将本地文件备份到远程服务器上：
mirror -R [其它选项] [本地目录] [远程目录]

常用选项：
-c, --continue :如果镜像过程中连接中断，重新开始。
-e, --delete :删除不在远程服务器上的本地文件。
-n, --only-newer :下载远程服务器上的新文件，不能和-c一起用。
-R, --reverse :将本地文件镜像传输到远程服务器上。
-v, --verbose[=level] :设置监视级别，范围0-3，0表示不输出，3表示输出全部。

举例：
    mirror -R --delete --only-newer --verbose /home/aaa.com /public_html/web/aaa.com
    
将本地/home/aaa.com目录下的文件备份到远程服务器/public_html/web/aaa.com目录。

    mirror --delete --only-newer --verbose /public_html/web /tmp

将远程服务器上/public_html/web目录下的文件备份到本地/tmp目录下。

3、一条命令实现lftp登陆和mirror
使用lftp的-e选项，例如：

```
lftp -e "mirror -R --delete --only-newer --verbose /home/aaa.com /public_html/web/aaa.com" -p 21 -u admin,123456 ftp.aaa.com
```

登陆后自动执行-e选项中的命令。

注意：如果远程FTP服务器是Pure-FTPd [privsep] [TLS]，执行命令会报错
WARNING: Certificate verification: Not trusted
WARNING: Certificate verification: The certificate's owner does not match hostname 'www.xxx.com'
并且停留在[Making data connection...]，连接不上。

需要编辑lftp的/etc/lftp.conf：

`vim /etc/lftp.conf`

在最后加入：

    debug 3
    set ftp:ssl-auth TLS-P
    set ftp:use-feat no

再次尝试查看详情是否有报错。

PS：lftp默认使用PASV模式，如要使用PORT模式，登陆后执行set ftp:passive off，或者直接将其加入到/etc/lftp.conf中。

4、lftp多线程下载

lftp还可以做为一个多线程下载工具。

常用选项：
pget -n :设置使用线程数。
-c :断点续传。

举例：

```
lftp -c "pget -n 10 http://sourceforge.net/projects/kvm/files/qemu-kvm/1.2.0/qemu-kvm-1.2.0.tar.gz"
```

5、lftp使用问题
1）使用lftp的mirror命令备份时报550错
`rm: Access failed: 550 dirname: Directory not empty`

在lftp命令开头添加：
`set ftp:list-options -a`
是因为该文件夹下有隐藏文件，服务器默认不显示，所以删不掉。

2）设置lftp超时时间和重试次数
在lftp命令开头添加：

```
set net:timeout 10;set net:max-retries 2;set net:reconnect-interval-base 5;set net:reconnect-interval-multiplier 1;
```

使用示例：

    lftp -e "set net:timeout 10;set net:max-retries 2;set net:reconnect-interval-base 5;set net:reconnect-interval-multiplier 1;set ftp:list-options -a;mirror -R --delete --only-newer --verbose /home/aaa.com /public_html/web/aaa.com" -p 21 -u admin,123456 ftp.demo.com