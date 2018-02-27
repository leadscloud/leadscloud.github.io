---
title: vps-监控性能方面命令大总结
id: 313429
categories:
  - 转载
date: 2012-06-16 13:41:18
tags:
---

一、last 命令
last    显示系统开机以来获是从每月初登入者的讯息
-R  省略 hostname 的栏位
-num 展示前 num 个  如：last -3  展示前三行
username 展示 username 的登入讯息
tty 限制登入讯息包含终端机代号
范例：
[root@elain ~]# last -R -2
root     pts/0        Fri Oct 22 14:23   still logged in
root     pts/0        Fri Oct 22 12:10 - 14:23  (02:13)
wtmp begins Sat Sep  4 00:38:05 2010

[root@elain ~]# last -2 root
root     pts/0        192.168.8.87     Fri Oct 22 14:23   still logged in
root     pts/0        192.168.8.87     Fri Oct 22 12:10 - 14:23  (02:13)
wtmp begins Sat Sep  4 00:38:05 2010

二、top 命令
top    是Linux下常用的性能分析工具，能够实时显示系统中各个进程的资源占用状况，类似于Windows的任务管理器。

top - 14:34:14 up 4 days, 16:20,  2 users,  load average: 0.56, 0.23, 0.32
Tasks:  75 total,   1 running,  74 sleeping,   0 stopped,   0 zombie
Cpu(s):  0.0%us,  0.0%sy,  0.0%ni, 99.8%id,  0.2%wa,  0.0%hi,  0.0%si,  0.0%st
Mem:   1026824k total,   917580k used,   109244k free,   124708k buffers
Swap:  2096472k total,        0k used,  2096472k free,   664320k cached
PID USER      PR  NI  VIRT  RES  SHR S %CPU %MEM    TIME+  COMMAND
3078 root      15   0 12720 1032  800 R  0.7  0.1   0:00.02 top
2463 root      16   0 10232  676  584 S  0.3  0.1   1:33.69 hald-addon-stor
1 root      15   0 10352  692  584 S  0.0  0.1   0:00.61 init
2 root      RT  -5     0    0    0 S  0.0  0.0   0:00.35 migration/0
3 root      34  19     0    0    0 S  0.0  0.0   0:00.00 ksoftirqd/0

统计信息区前五行是系统整体的统计信息。
第一行是任务队列信息，同 uptime 命令的执行结果。其内容如下：
14:34:14      当前时间
up 4 days      系统已运行时间
2 users              当前登录用户数
0.56, 0.23, 0.32  系统负载，即任务队列的平均长度。三个数值分别为1分钟、5分钟、15分钟前到现在的平均值。
第二行为进程信息，内容如下：
Tasks:  75 total    进程总数
1 running            正在运行的进程数
74 sleeping            睡眠的进程数
0 stopped            停止的进程数
0 zombie            僵尸进程数
第三行为CPU信息，当有多个CPU时，这些内容可能会超过两行。内容如下：
Cpu(s):  0.0%us            用户空间占用CPU百分比
0.0% sy                    内核空间占用CPU百分比
0.0% ni                    用户进程空间内改变过优先级的进程占用CPU百分比
98.8% id            空闲CPU百分比
0.2% wa                    等待输入输出(IO)的CPU时间百分比
0.0% hi                    cpu处理硬件中断的时间；
0.0% si                 cpu处理软中断的时间；
第四行为内存信息，内容如下：
Mem: 1026824k total      物理内存总量
917580k used              使用的物理内存总量
109244k free               空闲内存总量
124708k buffers            用作内核缓存的内存量
第五行为SWAP信息
Swap: 2096472k total    交换区总量
2096472k free              空闲交换区总量
664320k cached            缓冲的交换区总量。
第六行往后是进程列表，常见的这几列的意义分别为：
PID(进程号)， USER（运行用户），PR（优先级），NI（任务nice值），VIRT（虚拟内存用量），RES（物理内存用量），
SHR（共享内存用量），S（进程状态），%CPU（CPU占用比），%MEM（内存占用比），TIME+（累计CPU占用时间)。
除了这些信息之外，top还提供了很多命令能帮我们更好的解读这些信息，例如按”M”键可以按内存用量进行排序;
按”P”可以按CPU使用量进行排序，这样一来对于分析系统瓶颈很有帮助；此外，按“f”可以进入交互页面，选择指定的列显示，
例如可以按“b”选择显示PPID，再按一次“b”即可取消显示。”r”可以改变一个进程的nice值；”k”可以向一个进程发信号；
”z”可以使用彩色显示。进程信息区统计信息区域的下方显示了各个进程的详细信息。首先来认识一下各列的含义。
序号    列名    含义
a    PID    进程id
b    PPID    父进程id
c    RUSER    Real user name
d    UID    进程所有者的用户id
e    USER    进程所有者的用户名
f    GROUP    进程所有者的组名
g    TTY    启动进程的终端名。不是从终端启动的进程则显示为 ?
h    PR    优先级
i    NI    nice值。负值表示高优先级，正值表示低优先级
j    P    最后使用的CPU，仅在多CPU环境下有意义
k    %CPU    上次更新到现在的CPU时间占用百分比
l    TIME    进程使用的CPU时间总计，单位秒
m    TIME+    进程使用的CPU时间总计，单位1/100秒
n    %MEM    进程使用的物理内存百分比
o    VIRT    进程使用的虚拟内存总量，单位kb。VIRT=SWAP+RES
p    SWAP    进程使用的虚拟内存中，被换出的大小，单位kb。
q    RES    进程使用的、未被换出的物理内存大小，单位kb。RES=CODE+DATA
r    CODE    可执行代码占用的物理内存大小，单位kb
s    DATA    可执行代码以外的部分(数据段+栈)占用的物理内存大小，单位kb
t    SHR    共享内存大小，单位kb
u    nFLT    页面错误次数
v    nDRT    最后一次写入到现在，被修改过的页面数。
w    S    进程状态。
x    COMMAND    命令名/命令行
y    WCHAN    若该进程在睡眠，则显示睡眠中的系统函数名
z    Flags    任务标志，参考 sched.h
D=不可中断的睡眠状态
R=运行
S=睡眠
T=跟踪/停止
Z=僵尸进程

默认情况下仅显示比较重要的  PID、USER、PR、NI、VIRT、RES、SHR、S、%CPU、%MEM、TIME+、COMMAND  列。可以通过下面的快捷键来更改显示内容。
更改显示内容通过 f 键可以选择显示的内容。按 f 键之后会显示列的列表，按 a-z  即可显示或隐藏对应的列，最后按回车键确定。
按 o 键可以改变列的显示顺序。按小写的 a-z 可以将相应的列向右移动，而大写的 A-Z  可以将相应的列向左移动。最后按回车键确定。
按大写的 F 或 O 键，然后按 a-z 可以将进程按照相应的列进行排序。而大写的  R 键可以将当前的排序倒转。

三、free 命令
free
[root@elain ~]# free
total       used       free     shared    buffers     cached
Mem:       1026824     917764     109060          0     124908     664328
-/+ buffers/cache:     128528     898296
Swap:      2096472          0    2096472

第1行
total 内存总数: 1026824
used 已经使用的内存数: 917764
free 空闲的内存数: 109060
shared 当前已经废弃不用，总是0
buffers Buffer Cache内存数: 124908
cached Page Cache内存数:  664328
第2行：
-/+ buffers/cache的意思相当于：
-buffers/cache 的内存数：1128528 (等于第1行的 used - buffers - cached)
+buffers/cache 的内存数: 2752124 (等于第1行的 free + buffers + cached)
第3行：
total 交换分区总数: 2096472
used 已经使用的: 0
free 空闲的数: 2096472
free -m    大小以M来显示
四、dstat 命令
yum install -y dstat
dstat
-c     显示CPU情况
-d     显示磁盘情况
-g     显示通信情况
-m     显示内存情况
-n     显示网络情况
-p     显示进程情况
-s     显示swap情况
-t     显示系统时钟
-y     显示系统统计
-f     使用 -C, -D, -I, -N and -S 显示
-v     使用-pmgdsc -D 显示
--ipc   报告IPC消息队列和信号量的使用情况
--lock  enable lock stats
--raw   enable raw stats
--tcp  enable tcp stats
--udp   enable udp stats
--unix   enable unix stats
--mods   stat1,stat2
--integer  show integer values Bbs.Svn8.Com
--nocolor  disable colors (implies --noupdate) Bbs.Svn8.Com
--noheaders 只显示一次表头以后就不显示了,使用重定向写入文件时很有用 Bbs.Svn8.Com
--noupdate  disable intermediate updates Svn中文网
--output file 写入到CVS文件中
推荐使用 date &amp;&amp; dstat -tclmdny 60 一分钟监视一次（注意调节显示的宽度，或去掉-t选项）。

五、iostat 命令

# cat /proc/partitions
[root@elain ~]# cat /proc/partitions
major minor  #blocks  name
8     0      20971520 sda
8     1        200781 sda1
8     2       8193150 sda2
8     3       2096482 sda3
8     4             1 sda4
8     5      10474348 sda5
major: 主设备号。8 代表 sda。
minor: 次设备号。5 代表 No.5 分区。
#blocks: 设备总块数
name: 设备名称。如 sda3。

[root@elain ~]# iostat -x
Linux 2.6.18-194.11.3.el5 (elain)      2010年10月22日
avg-cpu:  %user   %nice %system %iowait  %steal   %idle
0.17    0.10    0.12    0.05    0.00   99.55
Device:         rrqm/s   wrqm/s   r/s   w/s   rsec/s   wsec/s avgrq-sz avgqu-sz   await  svctm  %util
sda               0.17     1.14  0.07  0.35     3.38    11.80    35.72     0.03   59.56   3.64   0.15
sda1              0.00     0.00  0.00  0.00     0.00     0.00    18.96     0.00    8.47   6.65   0.00
sda2              0.05     1.11  0.06  0.35     3.19    11.68    36.24     0.02   60.31   3.64   0.15
sda3              0.00     0.00  0.00  0.00     0.00     0.00    31.65     0.00    8.21   6.47   0.00
sda4              0.00     0.00  0.00  0.00     0.00     0.00     2.00     0.00    6.00   6.00   0.00
sda5              0.11     0.04  0.01  0.01     0.18     0.12    21.11     0.00   39.66   4.71   0.01

rrqm/s: 每秒进行 merge 的读操作数目。即 delta(rmerge)/s
wrqm/s: 每秒进行 merge 的写操作数目。即 delta(wmerge)/s
r/s: 每秒完成的读 I/O 设备次数。即 delta(rio)/s
w/s: 每秒完成的写 I/O 设备次数。即 delta(wio)/s
rsec/s: 每秒读扇区数。即 delta(rsect)/s
wsec/s: 每秒写扇区数。即 delta(wsect)/s
avgrq-sz: 平均每次设备I/O操作的数据大小 (扇区)。即 delta(rsect+wsect)/delta(rio+wio)
avgqu-sz: 平均I/O队列长度。即 delta(aveq)/s/1000 (因为aveq的单位为毫秒)。
await: 平均每次设备I/O操作的等待时间 (毫秒)。即 delta(ruse+wuse)/delta(rio+wio)
svctm: 平均每次设备I/O操作的服务时间 (毫秒)。即 delta(use)/delta(rio+wio)
％util: 一秒中有百分之多少的时间用于 I/O 操作，或者说一秒中有多少时间 I/O 队列是非空的。
即 delta(use)/s/1000 (因为use的单位为毫秒)

如果 ％util 接近 100％，说明产生的I/O请求太多，I/O系统已经满负荷，该磁盘可能存在瓶颈。

svctm 一般要小于 await (因为同时等待的请求的等待时间被重复计算了)，
svctm 的大小一般和磁盘性能有关，CPU/内存的负荷也会对其有影响，请求过多
也会间接导致 svctm 的增加。await 的大小一般取决于服务时间(svctm) 以及
I/O 队列的长度和 I/O 请求的发出模式。如果 svctm 比较接近 await，说明
I/O 几乎没有等待时间；如果 await 远大于 svctm，说明 I/O 队列太长，应用
得到的响应时间变慢，如果响应时间超过了用户可以容许的范围，这时可以考虑
更换更快的磁盘，调整内核 elevator 算法，优化应用，或者升级 CPU。

队列长度(avgqu-sz)也可作为衡量系统 I/O 负荷的指标，但由于 avgqu-sz 是
按照单位时间的平均值，所以不能反映瞬间的 I/O 洪水。

六、vmstat 命令
vmstat 命令报告虚拟内存统计信息和CPU负荷：页面调度，交换，任务交换，CPU利用率。命令的语法是：
vmstat
-swap    现时可用的交换内存（k表示）
-free    空闲的内存（k表示）
-disk    显示每秒的磁盘操作。 s表示scsi盘，0表示盘号
[root@elain ~]# vmstat 1 3 [一秒刷新一次 总共3次]
procs -----------memory---------- ---swap-- -----io---- --system-- -----cpu------
r  b   swpd   free   buff  cache   si   so    bi    bo   in   cs us sy id wa st
0  0      0 109036 123156 664444    0    0     1     3   37   12  0  0 100  0  0
0  0      0 109036 123156 664444    0    0     0     0 1022   28  0  0 100  0  0
0  0      0 109036 123156 664444    0    0     0     0 1003   17  0  0 100  0  0

如果 r经常大于 4 ，且id经常少于40[空闲CPU]，表示cpu的负荷很重。

目前说来，对于服务器监控有用处的度量主要有：
r（运行队列）
us（用户CPU）
sy（系统CPU）
id（空闲）

通过VMSTAT识别CPU瓶颈
r（运行队列）展示了正在执行和等待CPU资源的任务个数。当这个值超过了CPU数目，就会出现CPU瓶颈了。
获得CPU个数的命令(LINUX环境)：
cat /proc/cpuinfo|grep processor|wc -l
当r值超过了CPU个数，就会出现CPU瓶颈，解决办法大体几种：
1\. 最简单的就是增加CPU个数
2\. 通过调整任务执行时间，如大任务放到系统不繁忙的情况下进行执行，进尔平衡系统任务
3\. 调整已有任务的优先级

通过VMSTAT识别CPU满负荷
首先需要声明一点的是，vmstat中CPU的度量是百分比的。当us＋sy的值接近100的时候，表示CPU正在接近满负荷工作。
但要注意的是，CPU 满负荷工作并不能说明什么，UNIX总是试图要CPU尽可能的繁忙，使得任务的吞吐量最大化。唯一能够确定CPU瓶颈的还是r（运行队列）的值。
通过VMSTAT识别RAM瓶颈

数据库服务器都只有有限的RAM，出现内存争用现象是Oracle的常见问题。
首先察看RAM的数量，命令如下（LINUX环境）：
[root@elain ~]# free
total       used       free     shared    buffers     cached
Mem:       1026824     918284     108540          0     123180     664448
-/+ buffers/cache:     130656     896168
Swap:      2096472          0    2096472

当然可以使用top等其他命令来显示RAM。
当内存的需求大于RAM的数量，服务器启动了虚拟内存机制，通过虚拟内存，可以将RAM段移到SWAP DISK的特殊磁盘段上，
这样会出现虚拟内存的页导出和页导入现象，页导出并不能说明RAM瓶颈，虚拟内存系统经常会对内存段进行页导出，
但页导入操作就表明了服务器需要更多的内存了，页导入需要从SWAP DISK上将内存段复制回RAM，导致服务器速度变慢。
解决的办法有几种：
1\. 最简单的，加大RAM
2\. 改小SGA，使得对RAM需求减少
3\. 减少RAM的需求（如：减少PGA）

vmstat各项：
procs:
r--&gt;在运行队列中等待的进程数
b--&gt;在等待io的进程数
w--&gt;可以进入运行队列但被替换的进程
memoy
swap--&gt;现时可用的交换内存（k表示）
free--&gt;空闲的内存（k表示）
pages
re－－》回收的页面
mf－－》非严重错误的页面
pi－－》进入页面数（k表示）
po－－》出页面数（k表示）
fr－－》空余的页面数（k表示）
de－－》提前读入的页面中的未命中数
sr－－》通过时钟算法扫描的页面
disk 显示每秒的磁盘操作。 s表示scsi盘，0表示盘号
fault 显示每秒的中断数
in－－》设备中断
sy－－》系统中断
cy－－》cpu交换
cpu 表示cpu的使用状态
cs－－》用户进程使用的时间
sy－－》系统进程使用的时间
id－－》cpu空闲的时间
如果 r经常大于 4 ，且id经常少于40，表示cpu的负荷很重。
如果pi，po 长期不等于0，表示内存不足。
如果disk 经常不等于0， 且在 b中的队列 大于3， 表示 io性能不好。

七、mpstat 命令
mpstat是MultiProcessor Statistics的缩写，是实时系统监控工具。其报告与CPU的一些统计信息，这些信息存放在/proc/stat文件中。
在多CPUs系统里，其不但能查看所有CPU的平均状况信息，而且能够查看特定CPU的信息。mpstat的语法如下：
[root@elain ~]# mpstat
Linux 2.6.18-194.11.3.el5 (elain)      2010年10月22日
16时13分59秒  CPU   %user   %nice    %sys %iowait    %irq   %soft  %steal   %idle    intr/s
16时13分59秒  all    0.17    0.10    0.07    0.05    0.02    0.03    0.00   99.56   1018.86

%user 在internal时间段里，用户态的CPU时间（%），不包含 nice值为负 进程 (usr/total)*100
%nice 在internal时间段里，nice值为负进程的CPU时间（%）   (nice/total)*100
%sys  在internal时间段里，核心时间（%）   (system/total)*100
%iowait 在internal时间段里，硬盘IO等待时间（%） (iowait/total)*100
%irq 在internal时间段里，硬中断时间（%）      (irq/total)*100
%soft 在internal时间段里，软中断时间（%）    (softirq/total)*100
%idle 在internal时间段里，CPU除去等待磁盘IO操作外的因为任何原因而空闲的时间闲置时间（%）(idle/total)*100
%intr/s 在internal时间段里，每秒CPU接收的中断的次数intr/total)*100

total_cur=user+system+nice+idle+iowait+irq+softirq
total_pre=pre_user+ pre_system+ pre_nice+ pre_idle+ pre_iowait+ pre_irq+ pre_softirq
user=user_cur – user_pre
total=total_cur-total_pre

其中_cur 表示当前值，_pre表示interval时间前的值。上表中的所有值可取到两位小数点。

实例: 每2秒产生了2个处理器的统计数据报告
下面的命令可以每2秒产生了2个处理器的统计数据报告，一共产生三个interval 的信息，然后再给出这三个interval的平
均信息。默认时，输出是按照CPU 号排序。第一个行给出了从系统引导以来的所有活跃数据。接下来每行对应一个处理器的
活跃状态。。
[root@elain ~]# mpstat -P ALL 2 3
Linux 2.6.18-194.11.3.el5 (elain)      2010年10月22日

16时17分43秒  CPU   %user   %nice    %sys %iowait    %irq   %soft  %steal   %idle    intr/s
16时17分45秒  all    0.00    0.00    0.00    0.00    0.00    0.00    0.00  100.00   1036.36
16时17分45秒    0    0.00    0.00    0.00    0.00    0.00    0.00    0.00  100.00   1036.36
16时17分45秒    1    0.00    0.00    0.00    0.00    0.00    0.00    0.00  100.00      0.00

16时17分45秒  CPU   %user   %nice    %sys %iowait    %irq   %soft  %steal   %idle    intr/s
16时17分47秒  all    0.00    0.00    0.00    0.00    0.00    0.25    0.00   99.75   1045.27
16时17分47秒    0    0.00    0.00    0.00    0.00    0.50    0.00    0.00   99.50   1045.27
16时17分47秒    1    0.50    0.00    0.00    0.00    0.00    0.00    0.00   99.50      0.00

16时17分47秒  CPU   %user   %nice    %sys %iowait    %irq   %soft  %steal   %idle    intr/s
16时17分49秒  all    0.00    0.00    0.25    0.50    0.00    0.00    0.00   99.25   1031.84
16时17分49秒    0    0.00    0.00    0.50    1.49    0.00    0.00    0.00   98.01   1031.84
16时17分49秒    1    0.00    0.00    0.00    0.00    0.00    0.00    0.00  100.00      0.00

Average:     CPU   %user   %nice    %sys %iowait    %irq   %soft  %steal   %idle    intr/s
Average:     all    0.00    0.00    0.08    0.17    0.00    0.08    0.00   99.67   1037.83
Average:       0    0.00    0.00    0.17    0.50    0.17    0.00    0.00   99.17   1037.83
Average:       1    0.17    0.00    0.00    0.00    0.00    0.00    0.00   99.83      0.00

八、sar 命令
该命令是系统维护 的重要工具，主要帮助我们掌握系统资源的使用情况，特别是内存和CPU 的使用情况， 是UNIX系统使用者应该掌握的工具之 一。
sar
-A：所有报告的总和。
-u：CPU利用率
-v：进程、I节点、文件和锁表状态。
-d：硬盘使用报告。
-r：没有使用的内存页面和硬盘块。
-g：串口I/O的情况。
-b：缓冲区使用情况。
-a：文件读写情况。
-c：系统调用情况。
-R：进程的活动情况。
-y：终端设备活动情况。
-w：系统交换活动。

实例1：每60秒采样一次，连续采样5次，观察CPU的使用情况，并将采样结果以二进制形式存入当前目录下的文件/sar中，需键入如下命令：
[root@elain ~]# sar -u -o sar 60 5
Linux 2.6.18-194.11.3.el5 (elain)      2010年10月22日
16时28分47秒       CPU     %user     %nice   %system   %iowait    %steal     %idle
16时29分47秒       all      0.00      0.00      0.00      1.00      0.00     99.00
16时30分47秒       all      0.00      0.00      0.00      1.00      0.00     99.00
16时31分47秒       all      0.00      0.00      0.00      1.50      0.00     98.50
16时32分47秒       all      0.00      0.00      0.00      1.00      0.00     99.00
16时33分57秒       all      0.00      0.00      0.00      1.00      0.00     99.00
Average:          all      0.00      0.00      0.00      1.10      0.00     98.90

在显示内容包括：
%usr：   CPU处在用户模式下的时间百分比。
%sys：   CPU处在系统模式下的时间百分比。
%iowait：CPU等待输入输出完成时间的百分比。
%idle：  CPU空闲时间百分比。
我们应主要注意%wio和%idle，%wio的值过高，表示硬盘存在I/O瓶颈，%idle值高，表示CPU较空闲，如果%idle值高 但系统响应慢时，有可能是CPU等待分配内存，
此时应加大内存容量。%idle值如果持续低于10，那么系统的CPU处理能力相对较低，表明系统中最需要 解决的资源是CPU。
查看二进制文件sar中的内容，则需键入如下sar命令：
sar -u -f sar

实例2：每30秒采样一次，连续采样5次，观察核心表的状态，需键入如下命令：
[root@elain ~]# sar -v 30 5
Linux 2.6.18-194.11.3.el5 (elain)      2010年10月22日
16时32分54秒 dentunusd   file-sz  inode-sz  super-sz %super-sz  dquot-sz %dquot-sz  rtsig-sz %rtsig-sz
16时33分54秒     60602       510     50659         0      0.00         0      0.00         0      0.00
16时34分54秒     60602       510     50659         0      0.00         0      0.00         0      0.00
16时35分54秒     60602       510     50659         0      0.00         0      0.00         0      0.00
16时36分54秒     60602       510     50659         0      0.00         0      0.00         0      0.00
16时37分54秒     60602       510     50659         0      0.00         0      0.00         0      0.00
Average:        60602       510     50659         0      0.00         0      0.00         0      0.00

显示内容表示，核心使用完全正常，三个表没有出现溢出现象，核心参数不需调整，如果出现溢出时，要调整相应的核心参数，将对应的表项数加大。
小提示：
怀疑CPU存在瓶颈，可用sar -u 和sar -q来看，怀疑I/O存在 瓶颈，可用sar -b、sar -u和sar-d来看。

原文：[http://blog.csdn.net/adparking/article/details/7440245](http://blog.csdn.net/adparking/article/details/7440245)