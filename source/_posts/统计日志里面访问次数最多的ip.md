---
title: 统计日志里面访问次数最多的ip
id: 313552
categories:
  - Linux
date: 2013-01-11 15:57:11
tags:
---

<table style="border-collapse: collapse;" width="95%" border="1" cellspacing="0" cellpadding="0" bgcolor="#f1f1f1">
<tbody>
<tr>
<td>

[root@server2 ~]# netstat -ntu

<span style="color: #ff0000;">Active Internet connections (w/o servers) </span>

<span style="color: #ff0000;">Proto Recv-Q Send-Q Local Address Foreign Address State</span>

tcp 0 0 127.0.0.1:8652 <span style="color: #0000ff;">127.0.0.1:40193</span> TIME_WAIT

tcp 0 0 127.0.0.1:8652 <span style="color: #0000ff;">127.0.0.1:40192</span> TIME_WAIT

tcp 0 0 127.0.0.1:8652 <span style="color: #0000ff;">127.0.0.1:40196</span> TIME_WAIT

tcp 0 0 127.0.0.1:8652 <span style="color: #0000ff;">127.0.0.1:40199</span> TIME_WAIT

tcp 0 0 127.0.0.1:8652 <span style="color: #0000ff;">127.0.0.1:40201</span> TIME_WAIT

tcp 0 0 127.0.0.1:8652 <span style="color: #0000ff;">127.0.0.1:40204</span> TIME_WAIT

tcp 0 0 127.0.0.1:8652 <span style="color: #0000ff;">127.0.0.1:40207</span> TIME_WAIT

tcp 0 0 127.0.0.1:8652 <span style="color: #0000ff;">127.0.0.1:40210</span> TIME_WAIT

tcp 0 0 192.168.32.62:41682 <span style="color: #0000ff;">192.168.47.207:5432</span> TIME_WAIT

tcp 0 0 192.168.32.62:41685 <span style="color: #0000ff;">192.168.47.207:5432</span> TIME_WAIT

</td>
</tr>
</tbody>
</table>
netstat -ntu | tail -n +3 | awk '{ print $5}' | cut -d : -f 1 | sort | uniq -c| sort -n -r | head -n 5
tail -n +3 :去掉上面用红色标明的两行。
awk '{ print $5}'：取数据的低5域（第5列），上面蓝色标明。
cut -d : -f 1 ：取蓝色部分前面的IP部分。
sort：对IP部分进行排序。
uniq -c：打印每一重复行出现的次数。（并去掉重复行）
sort -n -r：按照重复行出现的次序倒序排列。
head -n 5：取排在前5位的IP 。