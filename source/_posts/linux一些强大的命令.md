---
title: linux一些强大的命令
id: 313516
categories:
  - Linux
date: 2012-11-24 01:02:06
tags:
---

 
<pre class="lang:sh decode:true " ># 时间截转时间
date -d@1234567890

# 创建一个空文件，比touch短
&gt; file.txt

# 列出当前目录里最大的10个文件
du -s * | sort -n | tail

# 列出头十个最耗内存的进程
ps aux | sort -nk +4 | tail

# 比较一个远程文件和一个本地文件
ssh user@host cat /path/to/remotefile | diff /path/to/localfile -

# 重复执行上一条命令
!!

# !$是一个特殊的环境变量，它代表了上一个命令的最后一个字符串
$mkdir mydir
$mv mydir yourdir
$cd yourdir
可以改成：
$mkdir mydir
$mv !$ yourdir
$cd !$

# 回到上一层目录
cd -

# 回到自己的Home目录
cd ~

# 把上次命令行的参数给重复出来
esc+.

# linux查找特定文件里面包含特定字符的文件
find /home/htdocs/ -name ‘*.php’ -exec grep -i “answerPostTime!=0″ {} \; -print

# Linux查看目录大小
du -b –max-depth 1 | sort -nr | perl -pe ‘s{([0-9]+)}{sprintf “%.1f%s”, $1&gt;=2**30? ($1/2**30, “G”): $1&gt;=2**20? ($1/2**20, “M”): $1&gt;=2**10? ($1/2**10, “K”): ($1, “”)}e’
du -sbh *
ls -lh

# 自动刷新指令
watch -n 1 “(echo status; sleep 0.1) | nc 127.0.0.1 4730″</pre> 