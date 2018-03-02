---
title: lnmpa 502 重启脚本
id: 313316
categories:
  - 个人日志
date: 2012-04-20 08:29:48
tags:
---

安装lnmpa后，经常会有502错误。按vpser上的检查问题也无法解决，只好用以下脚本解决问题。顺便说下，我重新安装了VPS,首先更新了我的系统，然后再装lnmpa便极少出现502错误 了，看来再安装的时候还是尽量避免出现问题，否则很容易出现502。 下面是脚本内容，保存为502fix.sh,然后

`chmod +x /root/502fix.sh`

脚本内容：
<pre class="font:tahoma lang:sh decode:true">#!/usr/bin/php
&lt;?
$url = 'http://76.163.25.39';
$cmd = '/etc/init.d/httpd restart';

for($i = 0; $i &lt; 5; $i ++){
$exec = "curl --connect-timeout 3 -I $url 2&gt;/dev/null";
$res = shell_exec($exec);

if(stripos($res,'502 Bad Gateway') !== false){
shell_exec($cmd);
exit();
}
}
?&gt;</pre>

记得把IP或网址改为你自己VPS的。
原理就是用curl获取HTTP头,一旦502 就重启apache。

然后添加下定时任务

<pre class="lang:sh decode:true " >crontab -e

*/1 * * * * /root/502fix.sh</pre> 

定时内容为，每一分钟检查一次。