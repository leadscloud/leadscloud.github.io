---
title: 使用-shell-脚本对-linux-系统和进程资源进行监控
id: 313661
categories:
  - 转载
date: 2013-11-03 09:38:31
tags:
---

## Shell 简介

Shell 语言对于接触 LINUX 的人来说都比较熟悉，它是系统的用户界面，提供了用户与内核进行交互操作的一种接口。它接收用户输入的命令并把它送入内核去执行。实际上 Shell 是一个命令解释器，它解释由用户输入的命令并且把它们送到内核。它没有一般编程语言的“编译 - 链接 - 运行”过程。不仅如此，Shell 有自己的编程语言用于对命令的编辑，它允许用户编写由 shell 命令组成的程序。Shell 编程语言具有普通编程语言的很多特点，比如它也有循环结构和分支控制结构等，用这种编程语言编写的 Shell 程序与其他应用程序具有同样的效果。当然，Shell 功能也是很强大的。Shell 有多种类型，其中最常用的几种是 Bourne shell（sh）、C shell（csh）和 Korn shell（ksh）。三种 shell 各有优缺点，Linux 操作系统缺省的 shell 一般是 Bourne Again shell，它是 Bourne shell 的扩展，简称 Bash，bash 的命令语法是 Bourne shell 命令语法的超集，并且在 Bourne shell 的基础上增加、增强了很多特性。在这里，我们以 Bash 做为实例总结了使用 Shell 对系统和进程资源进行监控的一些内容，希望对您能有帮助。
<div></div>
[回页首](http://www.ibm.com/developerworks/cn/linux/l-cn-shell-monitoring/#ibm-pcon)

## 使用 Shell 对进程资源进行监控

### 检查进程是否存在

在对进程进行监控时，我们一般需要得到该进程的 ID，进程 ID 是进程的唯一标识，但是有时可能在服务器上不同用户下运行着多个相同进程名的进程，下面的函数 GetPID 给出了获取指定用户下指定进程名的进程 ID 功能（目前只考虑这个用户下启动一个此进程名的进程），它有两个参数为用户名和进程名，它首先使用 ps 查找进程信息，同时通过 grep 过滤出需要的进程，最后通过 sed 和 awk 查找需要进程的 ID 值（此函数可根据实际情况修改，比如需要过滤其它信息等）。

##### 清单 1\. 对进程进行监控

<div>
<pre> function GetPID #User #Name 
 { 
    PsUser=$1 
    PsName=$2 
    pid=`ps -u $PsUser|grep $PsName|grep -v grep|grep -v vi|grep -v dbx\n 
    |grep -v tail|grep -v start|grep -v stop |sed -n 1p |awk '{print $1}'` 
    echo $pid 
 }</pre>
</div>
示例演示：

1）源程序（例如查找用户为 root，进程名为 CFTestApp 的进程 ID）
<div>
<pre>    PID=`GetPID root CFTestApp` 

    echo $PID</pre>
</div>
2）结果输出
<div>
<pre>    11426 
    [dyu@xilinuxbldsrv shell]$</pre>
</div>
3）结果分析

从上面的输出可见：11426 为 root 用户下的 CFTestApp 程序的进程 ID。

4）命令介绍
<div>1\. ps: 查看系统中瞬间进程信息。 参数：-u&lt; 用户识别码 &gt; 列出属于该用户的程序的状况，也可使用用户名称来指定。 -p&lt; 进程识别码 &gt; 指定进程识别码，并列出该进程的状况。 -o 指定输出格式 2\. grep: 用于查找文件中符合字符串的当前行。 参数：-v 反向选择，亦即显示出没有 '搜寻字符串' 内容的那一行。 3\. sed: 一个非交互性文本编辑器，它编辑文件或标准输入导出的文件，一次只能处理一行内容。 参数：-n 读取下一个输入行，用下一个命令处理新的行而不是用第一个命令。 p 标志 打印匹配行 4\. awk：一种编程语言，用于在 linux/unix 下对文本和数据进行处理。数据可以来自标准输入、一个或多个文件，或其它命令的输出。它支持用户自定义函数和动态正则表达式等先进功能，是 linux/unix 下的一个强大编程工具。它在命令行中使用，但更多是作为脚本来使用。awk 的处理文本和数据的方式：它逐行扫描文件，从第一行到最后一行，寻找匹配的特定模式的行，并在这些行上进行你想要的操作。如果没有指定处理动作，则把匹配的行显示到标准输出 ( 屏幕 )，如果没有指定模式，则所有被操作所指定的行都被处理。 参数：-F fs or --field-separator fs ：指定输入文件折分隔符，fs 是一个字符串或者是一个正则表达式，如 -F:。</div>
有时有可能进程没有启动，下面的功能是检查进程 ID 是否存在，如果此进程没有运行输出：
<div>
<pre>    The process does not exist. 
    # 检查进程是否存在
    if [ "-$PID" == "-" ] 
    then 
    { 
        echo "The process does not exist."
    } 
    fi</pre>
</div>

### 检测进程 CPU 利用率

在对应用服务进行维护时，我们经常遇到由于 CPU 过高导致业务阻塞，造成业务中断的情况。CPU 过高可能由于业务量过负荷或者出现死循环等异常情况，通过脚本对业务进程 CPU 进行时时监控，可以在 CPU 利用率异常时及时通知维护人员，便于维护人员及时分析，定位，以及避免业务中断等。下面的函数可获得指定进程 ID 的进程 CPU 利用率。它有一个参数为进程 ID，它首先使用 ps 查找进程信息，同时通过 grep -v 过滤掉 %CPU 行，最后通过 awk 查找 CPU 利用百分比的整数部分（如果系统中有多个 CPU，CPU 利用率可以超过 100%）。

##### 清单 2\. 对业务进程 CPU 进行实时监控

<div>
<pre>function GetCpu 
  { 
   CpuValue=`ps -p $1 -o pcpu |grep -v CPU | awk '{print $1}' | awk -  F. '{print $1}'` 
        echo $CpuValue 
    }</pre>
</div>
下面的功能是通过上面的函数 GetCpu 获得此进程的 CPU 利用率，然后通过条件语句判断 CPU 利用率是否超过限制，如果超过 80%（可以根据实际情况进行调整），则输出告警，否则输出正常信息。

##### 清单 3\. 判断 CPU 利用率是否超过限制

<div>
<pre> function CheckCpu 
 { 
    PID=$1 
    cpu=`GetCpu $PID` 
    if [ $cpu -gt 80 ] 
    then 
    { 
 echo “The usage of cpu is larger than 80%”
    } 
    else 
    { 
 echo “The usage of cpu is normal”
    } 
    fi 
 }</pre>
</div>
示例演示：

1）源程序（假设上面已经查询出 CFTestApp 的进程 ID 为 11426）
<div>
<pre> CheckCpu 11426</pre>
</div>
2）结果输出
<div>
<pre>    The usage of cpu is 75 
    The usage of cpu is normal 
    [dyu@xilinuxbldsrv shell]$</pre>
</div>
3）结果分析

从上面的输出可见：CFTestApp 程序当前的 CPU 使用为 75%，是正常的，没有超过 80% 的告警限制。

### 检测进程内存使用量

在对应用服务进行维护时，也经常遇到由于内存使用过大导致进程崩溃，造成业务中断的情况（例如 32 位程序可寻址的最大内存空间为 4G，如果超出将申请内存失败，同时物理内存也是有限的）。内存使用过高可能由于内存泄露，消息堆积等情况，通过脚本对业务进程内存使用量进行时时监控，可以在内存使用量异常时及时发送告警（例如通过短信），便于维护人员及时处理。下面的函数可获得指定进程 ID 的进程内存使用情况。它有一个参数为进程 ID，它首先使用 ps 查找进程信息，同时通过 grep -v 过滤掉 VSZ 行 , 然后通过除 1000 取以兆为单位的内存使用量。

##### 清单 4\. 对业务进程内存使用量进行监控

<div>
<pre>    function GetMem 
    { 
        MEMUsage=`ps -o vsz -p $1|grep -v VSZ` 
        (( MEMUsage /= 1000)) 
        echo $MEMUsage 
    }</pre>
</div>
下面的功能是通过上面的函数 `GetMem`获得此进程的内存使用，然后通过条件语句判断内存使用是否超过限制，如果超过 1.6G（可以根据实际情况进行调整），则输出告警，否则输出正常信息。

##### 清单 5\. 判断内存使用是否超过限制

<div>
<pre> mem=`GetMem $PID`                
 if [ $mem -gt 1600 ] 
 then 
 { 
     echo “The usage of memory is larger than 1.6G”
 } 
 else 
 { 
    echo “The usage of memory is normal”
 } 
 fi</pre>
</div>
示例演示：

1）源程序（假设上面已经查询出 CFTestApp 的进程 ID 为 11426）
<div>
<pre>    mem=`GetMem 11426` 

    echo "The usage of memory is $mem M"

    if [ $mem -gt 1600 ] 
    then 
    { 
         echo "The usage of memory is larger than 1.6G"
    } 
    else 
    { 
        echo "The usage of memory is normal"
    } 
    fi</pre>
</div>
2）结果输出
<div>
<pre>    The usage of memory is 248 M 
    The usage of memory is normal 
    [dyu@xilinuxbldsrv shell]$</pre>
</div>
3）结果分析

从上面的输出可见：CFTestApp 程序当前的内存使用为 248M，是正常的，没有超过 1.6G 的告警限制。

### 检测进程句柄使用量

在对应用服务进行维护时，也经常遇到由于句柄使用 过量导致业务中断的情况。每个平台对进程的句柄使用都是有限的，例如在 Linux 平台，我们可以使用 ulimit – n 命令（open files (-n) 1024）或者对 /etc/security/limits.conf 的内容进行查看，得到进程句柄限制。句柄使用过高可能由于负载过高，句柄泄露等情况，通过脚本对业务进程句柄使用量进行时时监控，可以在异常时及时发送告警（例如通过短信），便于维护人员及时处理。下面的函数可获得指定进程 ID 的进程句柄使用情况。它有一个参数为进程 ID，它首先使用 ls 输出进程句柄信息，然后通过 wc -l 统计输出句柄个数。
<div>
<pre>    function GetDes 
    { 
        DES=`ls /proc/$1/fd | wc -l` 
        echo $DES 
    }</pre>
</div>
下面功能是通过上面的函数 `GetDes`获得此进程的句柄使用量，然后通过条件语句判断句柄使用是否超过限制，如果超过 900（可以根据实际情况进行调整）个，则输出告警，否则输出正常信息。
<div>
<pre> des=` GetDes $PID` 
 if [ $des -gt 900 ] 
 then 
 { 
     echo “The number of des is larger than 900”
 } 
 else 
 { 
    echo “The number of des is normal”
 } 
 fi</pre>
</div>
示例演示：

1）源程序（假设上面查询出 CFTestApp 的进程 ID 为 11426）
<div>
<pre>    des=`GetDes 11426` 

    echo "The number of des is $des"

    if [ $des -gt 900 ] 
    then 
    { 
         echo "The number of des is larger than 900"
    } 
    else 
    { 
        echo "The number of des is normal"
    } 
    fi</pre>
</div>
2）结果输出
<div>
<pre>    The number of des is 528 
    The number of des is normal 
    [dyu@xilinuxbldsrv shell]$</pre>
</div>
3）结果分析

从上面的输出可见：CFTestApp 程序当前的句柄使用为 528 个，是正常的，没有超过 900 个的告警限制。

4）命令介绍
<div>wc: 统计指定文件中的字节数、字数、行数 , 并将统计结果显示输出。 参数：-l 统计行数。 -c 统计字节数。 -w 统计字数。</div>
<div></div>
[回页首](http://www.ibm.com/developerworks/cn/linux/l-cn-shell-monitoring/#ibm-pcon)

## 使用 Shell 对系统资源进行监控

### 查看某个 TCP 或 UDP 端口是否在监听

端口检测是系统资源检测经常遇到的，特别是在网络通讯情况下，端口状态的检测往往是很重要的。有时可能进程，CPU，内存等处于正常状态，但是端口处于异常状态，业务也是没有正常运行。下面函数可判断指定端口是否在监听。它有一个参数为待检测端口，它首先使用 netstat 输出端口占用信息，然后通过 grep, awk,wc 过滤输出监听 TCP 端口的个数，第二条语句为输出 UDP 端口的监听个数，如果 TCP 与 UDP 端口监听都为 0，返回 0，否则返回 1.

##### 清单 6\. 端口检测

<div>
<pre> function Listening 
 { 
    TCPListeningnum=`netstat -an | grep ":$1 " | \n
    awk '$1 == "tcp" &amp;&amp; $NF == "LISTEN" {print $0}' | wc -l` 
    UDPListeningnum=`netstat -an|grep ":$1 " \n
    |awk '$1 == "udp" &amp;&amp; $NF == "0.0.0.0:*" {print $0}' | wc -l` 
    (( Listeningnum = TCPListeningnum + UDPListeningnum )) 
    if [ $Listeningnum == 0 ] 
    then 
    { 
        echo "0"
    } 
    else 
    { 
       echo "1"
    } 
    fi 
 }</pre>
</div>
示例演示：

1）源程序（例如查询 8080 端口的状态是否在监听）
<div>
<pre>    isListen=`Listening 8080` 
    if [ $isListen -eq 1 ] 
    then 
    { 
        echo "The port is listening"
    } 
    else 
    { 
        echo "The port is not listening"
    } 
    fi</pre>
</div>
2）结果输出
<div>
<pre>    The port is listening 
    [dyu@xilinuxbldsrv shell]$</pre>
</div>
3）结果分析

从上面的输出可见：这个 Linux 服务器的 8080 端口处在监听状态。

4）命令介绍
<div>netstat: 用于显示与 IP、TCP、UDP 和 ICMP 协议相关的统计数据，一般用于检验本机各端口的网络连接情况。 参数：-a 显示所有连线中的 Socket。 -n 直接使用 IP 地址，而不通过域名服务器。</div>
下面的功能也是检测某个 TCP 或者 UDP 端口是否处在正常状态。
<div>
<pre> tcp: netstat -an|egrep $1 |awk '$6 == "LISTEN" &amp;&amp; $1 == "tcp" {print $0}'
 udp: netstat -an|egrep $1 |awk '$1 == "udp" &amp;&amp; $5 == "0.0.0.0:*" {print $0}'</pre>
</div>
命令介绍
<div>egrep: 在文件内查找指定的字符串。egrep 执行效果如 grep -E，使用的语法及参数可参照 grep 指令，与 grep 不同点在于解读字符串的方法，egrep 是用扩展的正则表达式语法来解读，而 grep 则用基本的正则表达式语法，扩展的正则表达式比基本的正则表达式有更完整的表达规范。</div>

### 查看某个进程名正在运行的个数

有时我们可能需要得到服务器上某个进程的启动个数，下面的功能是检测某个进程正在运行的个数，例如进程名为 `CFTestApp。`
<div>
<pre> Runnum=`ps -ef | grep -v vi | grep -v tail | grep "[ /]CFTestApp" | grep -v grep | wc -l</pre>
</div>

### 检测系统 CPU 负载

在对服务器进行维护时，有时也遇到由于系统 CPU（利用率）负载 过量导致业务中断的情况。服务器上可能运行多个进程，查看单个进程的 CPU 都是正常的，但是整个系统的 CPU 负载可能是异常的。通过脚本对系统 CPU 负载进行时时监控，可以在异常时及时发送告警，便于维护人员及时处理，预防事故发生。下面的函数可以检测系统 CPU 使用情况 . 使用 vmstat 取 5 次系统 CPU 的 idle 值，取平均值，然后通过与 100 取差得到当前 CPU 的实际占用值。
<div>
<pre> function GetSysCPU 
 { 
   CpuIdle=`vmstat 1 5 |sed -n '3,$p' \n
   |awk '{x = x + $15} END {print x/5}' |awk -F. '{print $1}'
   CpuNum=`echo "100-$CpuIdle" | bc` 
   echo $CpuNum 
 }</pre>
</div>
示例演示：

1）源程序
<div>
<pre> cpu=`GetSysCPU` 

 echo "The system CPU is $cpu"

 if [ $cpu -gt 90 ] 
 then 
 { 
    echo "The usage of system cpu is larger than 90%"
 } 
 else 
 { 
    echo "The usage of system cpu is normal"
 } 
 fi</pre>
</div>
2）结果输出
<div>
<pre> The system CPU is 87 
 The usage of system cpu is normal 
 [dyu@xilinuxbldsrv shell]$</pre>
</div>
3）结果分析

从上面的输出可见：当前 Linux 服务器系统 CPU 利用率为 87%，是正常的，没有超过 90% 的告警限制。

4）命令介绍
<div>vmstat：Virtual Meomory Statistics（虚拟内存统计）的缩写，可对操作系统的虚拟内存、进程、CPU 活动进行监视。
参数： -n 表示在周期性循环输出时，输出的头部信息仅显示一次。</div>

### 检测系统磁盘空间

系统磁盘空间检测是系统资源检测的重要部分，在系统维护维护中，我们经常需要查看服务器磁盘空间使用情况。因为有些业务要时时写话单，日志，或者临时文件等，如果磁盘空间用尽，也可能会导致业务中断，下面的函数可以检测当前系统磁盘空间中某个目录的磁盘空间使用情况 . 输入参数为需要检测的目录名，使用 df 输出系统磁盘空间使用信息，然后通过 grep 和 awk 过滤得到某个目录的磁盘空间使用百分比。
<div>
<pre> function GetDiskSpc 
 { 
    if [ $# -ne 1 ] 
    then 
        return 1 
    fi 

    Folder="$1$"
    DiskSpace=`df -k |grep $Folder |awk '{print $5}' |awk -F% '{print $1}'
    echo $DiskSpace 
 }</pre>
</div>
示例演示：

1）源程序（检测目录为 /boot）
<div>
<pre> Folder="/boot"

 DiskSpace=`GetDiskSpc $Folder` 

 echo "The system $Folder disk space is $DiskSpace%"

 if [ $DiskSpace -gt 90 ] 
 then 
 { 
    echo "The usage of system disk($Folder) is larger than 90%"
 } 
 else 
 { 
    echo "The usage of system disk($Folder)  is normal"
 } 
 fi</pre>
</div>
2）结果输出
<div>
<pre> The system /boot disk space is 14% 
 The usage of system disk(/boot)  is normal 
 [dyu@xilinuxbldsrv shell]$</pre>
</div>
3）结果分析

从上面的输出可见：当前此 Linux 服务器系统上 /boot 目录的磁盘空间已经使用了 14%，是正常的，没有超过使用 90% 的告警限制。

4）命令介绍
<div>df：检查文件系统的磁盘空间占用情况。可以利用该命令来获取硬盘被占用了多少空间，目前还剩下多少空间等信息。 参数：-k 以 k 字节为单位显示。</div>
<div></div>
[回页首](http://www.ibm.com/developerworks/cn/linux/l-cn-shell-monitoring/#ibm-pcon)

## 总结

在 Linux 平台下，shell 脚本监控是一个非常简单，方便，有效的对服务器，进程进行监控的方法，对系统开发以及进程维护人员非常有帮助。它不仅可以对上面的信息进行监控，发送告警，同时也可以监控进程的日志等等的信息，希望本文对大家有帮助。

[test](http://www.love4026.org/wp-content/uploads/2013/11/test.zip)源码下载