---
title: Curl封闭类Curl.class.php
id: 313455
categories:
  - PHP学习
date: 2012-07-07 06:39:50
tags: php
---


转载的，里面有些内容可以借用。

```php
<?php
//curl类
class Curl
{
    function Curl(){
        return true;
    }

    function execute($method, $url, $fields='', $userAgent='', $httpHeaders='', $username='', $password=''){
        $ch = Curl::create();
        if(false === $ch){
            return false;
        }
        if(is_string($url) && strlen($url)){
            $ret = curl_setopt($ch, CURLOPT_URL, $url);
        }else{
            return false;
        }
        //是否显示头部信息
        curl_setopt($ch, CURLOPT_HEADER, false);

        curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);
        if($username != ''){
            curl_setopt($ch, CURLOPT_USERPWD, $username . ':' . $password);
        }
        $method = strtolower($method);
        if('post' == $method){
            curl_setopt($ch, CURLOPT_POST, true);
            if(is_array($fields)){
                $sets = array();
                foreach ($fields AS $key => $val){
                    $sets[] = $key . '=' . urlencode($val);
                }
                $fields = implode('&',$sets);
            }
            curl_setopt($ch, CURLOPT_POSTFIELDS, $fields);
        }else if('put' == $method){
            curl_setopt($ch, CURLOPT_PUT, true);
        }
        //curl_setopt($ch, CURLOPT_PROGRESS, true);
        //curl_setopt($ch, CURLOPT_VERBOSE, true);
        //curl_setopt($ch, CURLOPT_MUTE, false);
        curl_setopt($ch, CURLOPT_TIMEOUT, 10);//设置curl超时秒数
        if(strlen($userAgent)){
            curl_setopt($ch, CURLOPT_USERAGENT, $userAgent);
        }
        if(is_array($httpHeaders)){
            curl_setopt($ch, CURLOPT_HTTPHEADER, $httpHeaders);
        }
        $ret = curl_exec($ch);
        if(curl_errno($ch)){
            curl_close($ch);
            return array(curl_error($ch), curl_errno($ch));
        }else{
            curl_close($ch);
            if(!is_string($ret) || !strlen($ret)){
                return false;
            }
            return $ret;
        }
    }

    function post($url, $fields, $userAgent = '', $httpHeaders = '', $username = '', $password = ''){
        $ret = Curl::execute('POST', $url, $fields, $userAgent, $httpHeaders, $username, $password);
        if(false === $ret){
            return false;
        }
        if(is_array($ret)){
            return false;
        }
        return $ret;
    }

    function get($url, $userAgent = '', $httpHeaders = '', $username = '', $password = ''){
        $ret = Curl::execute('GET', $url, '', $userAgent, $httpHeaders, $username, $password);
        if(false === $ret){
            return false;
        }
        if(is_array($ret)){
            return false;
        }
        return $ret;
    }

    function create(){
        $ch = null;
        if(!function_exists('curl_init')){
            return false;
        }
        $ch = curl_init();
        if(!is_resource($ch)){
            return false;
        }
        return $ch;
    }
}
?>
```

GET用法：

```
$curl = new Curl();
$curl->get('http://www.hdj.me/');
```

POST用法

```
$curl = new Curl();
$curl->get('http://www.hdj.me/', 'p=1&time=0');
```

原文：http://www.hdj.me/curl-class-php