---
title: 21个实用的php代码
tags:
  - PHP
id: 313011
categories:
  - [PHP学习]
  - [技术]
date: 2011-02-12 05:29:32
---

1\. PHP可阅读随机字符串

此代码将创建一个可阅读的字符串，使其更接近词典中的单词，实用且具有密码验证功能。
 <!--more--> 

```
/************** 
*@length - length of random string (must be a multiple of 2) 
**************/ 
function readable_random_string($length = 6){ 
    $conso=array(&quot;b&quot;,&quot;c&quot;,&quot;d&quot;,&quot;f&quot;,&quot;g&quot;,&quot;h&quot;,&quot;j&quot;,&quot;k&quot;,&quot;l&quot;, 
    &quot;m&quot;,&quot;n&quot;,&quot;p&quot;,&quot;r&quot;,&quot;s&quot;,&quot;t&quot;,&quot;v&quot;,&quot;w&quot;,&quot;x&quot;,&quot;y&quot;,&quot;z&quot;); 
    $vocal=array(&quot;a&quot;,&quot;e&quot;,&quot;i&quot;,&quot;o&quot;,&quot;u&quot;); 
    $password=&quot;&quot;; 
    srand ((double)microtime()*1000000); 
    $max = $length/2; 
    for($i=1; $i&lt;=$max; $i++) 
    { 
    $password.=$conso[rand(0,19)]; 
    $password.=$vocal[rand(0,4)]; 
    } 
    return $password; 
}
```

2\. PHP生成一个随机字符串

如果不需要可阅读的字符串，使用此函数替代，即可创建一个随机字符串，作为用户的随机密码等。

```
/************* 
*@l - length of random string 
*/ 
function generate_rand($l){ 
  $c= &quot;ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789&quot;; 
  srand((double)microtime()*1000000); 
  for($i=0; $i&lt;$l; $i++) { 
      $rand.= $c[rand()%strlen($c)]; 
  } 
  return $rand; 
}
```

3\. PHP编码电子邮件地址

使用此代码，可以将任何电子邮件地址编码为 html 字符实体，以防止被垃圾邮件程序收集。

```
function encode_email($email='info@domain.com', $linkText='Contact Us', $attrs ='class=&quot;emailencoder&quot;' )
{
    // remplazar aroba y puntos
    $email = str_replace('@', '@', $email);
    $email = str_replace('.', '.', $email);
    $email = str_split($email, 5); 

    $linkText = str_replace('@', '@', $linkText);
    $linkText = str_replace('.', '.', $linkText);
    $linkText = str_split($linkText, 5); 

    $part1 = '[';
    $part4 = '](ma)'; 

    $encoded = '<script type="text/javascript">';
    $encoded .= "document.write('$part1');";
    $encoded .= "document.write('$part2');";
    foreach($email as $e)
    {
            $encoded .= "document.write('$e');";
    }
    $encoded .= "document.write('$part3');";
    foreach($linkText as $l)
    {
            $encoded .= "document.write('$l');";
    }
    $encoded .= "document.write('$part4');";
    $encoded .= '</script>'; 

    return $encoded;
}
```

4\. PHP验证邮件地址

电子邮件验证也许是中最常用的网页表单验证，此代码除了验证电子邮件地址，也可以选择检查邮件域所属 DNS 中的 MX 记录，使邮件验证功能更加强大。

```
function is_valid_email($email, $test_mx = false)
{
    if(eregi(&quot;^([_a-z0-9-]+)(.[_a-z0-9-]+)*@([a-z0-9-]+)(.[a-z0-9-]+)*(.[a-z]{2,4})$&quot;, $email))
        if($test_mx)
        {
            list($username, $domain) = split(&quot;@&quot;, $email);
            return getmxrr($domain, $mxrecords);
        }
        else
            return true;
    else
        return false;
}
```

5\. PHP列出目录内容

```
function list_files($dir)
{
    if(is_dir($dir))
    {
        if($handle = opendir($dir))
        {
            while(($file = readdir($handle)) !== false)
            {
                if($file != &quot;.&quot; &amp;&amp; $file != &quot;..&quot; &amp;&amp; $file != &quot;Thumbs.db&quot;)
                {
                    echo '['.$file.']()
'.&quot;n&quot;;
                }
            }
            closedir($handle);
        }
    }
}
```

6\. PHP销毁目录

删除一个目录，包括它的内容。

```
/*****
*@dir - Directory to destroy
*@virtual[optional]- whether a virtual directory
*/
function destroyDir($dir, $virtual = false)
{
    $ds = DIRECTORY_SEPARATOR;
    $dir = $virtual ? realpath($dir) : $dir;
    $dir = substr($dir, -1) == $ds ? substr($dir, 0, -1) : $dir;
    if (is_dir($dir) &amp;&amp; $handle = opendir($dir))
    {
        while ($file = readdir($handle))
        {
            if ($file == '.' || $file == '..')
            {
                continue;
            }
            elseif (is_dir($dir.$ds.$file))
            {
                destroyDir($dir.$ds.$file);
            }
            else
            {
                unlink($dir.$ds.$file);
            }
        }
        closedir($handle);
        rmdir($dir);
        return true;
    }
    else
    {
        return false;
    }
}
```

7\. PHP解析 JSON 数据

与大多数流行的 Web 服务如 twitter 通过开放 API 来提供数据一样，它总是能够知道如何解析 API 数据的各种传送格式，包括 JSON，XML 等等。

```
$json_string='{&quot;id&quot;:1,&quot;name&quot;:&quot;foo&quot;,&quot;email&quot;:&quot;foo@foobar.com&quot;,&quot;interest&quot;:[&quot;wordpress&quot;,&quot;php&quot;]} ';
$obj=json_decode($json_string);
echo $obj-&gt;name; //prints foo
echo $obj-&gt;interest[1]; //prints php
```

8\. PHP解析 XML 数据

```
//xml string
$xml_string=&quot;&lt;?xml version='1.0'?&gt;
<users>
   <user id="398">
      <name>Foo</name>
      <email>foo@bar.com</name>
   </user>
   <user id="867">
      <name>Foobar</name>
      <email>foobar@foo.com</name>
   </user>
</users>&quot;; 

//load the xml string using simplexml
$xml = simplexml_load_string($xml_string); 

//loop through the each node of user
foreach ($xml-&gt;user as $user)
{
   //access attribute
   echo $user['id'], '  ';
   //subnodes are accessed by -&gt; operator
   echo $user-&gt;name, '  ';
   echo $user-&gt;email, '
';
}
```

9\. PHP创建日志缩略名

创建用户友好的日志缩略名。

```
function create_slug($string){
    $slug=preg_replace('/[^A-Za-z0-9-]+/', '-', $string);
    return $slug;
}
```

10\. PHP获取客户端真实 IP 地址

该函数将获取用户的真实 IP 地址，即便他使用代理服务器。

```
function getRealIpAddr()
{
    if (!emptyempty($_SERVER['HTTP_CLIENT_IP']))
    {
        $ip=$_SERVER['HTTP_CLIENT_IP'];
    }
    elseif (!emptyempty($_SERVER['HTTP_X_FORWARDED_FOR']))
    //to check ip is pass from proxy
    {
        $ip=$_SERVER['HTTP_X_FORWARDED_FOR'];
    }
    else
    {
        $ip=$_SERVER['REMOTE_ADDR'];
    }
    return $ip;
}
```

11\. PHP强制性文件下载

为用户提供强制性的文件下载功能。

```
/********************
*@file - path to file
*/
function force_download($file)
{
    if ((isset($file))&amp;&amp;(file_exists($file))) {
       header(&quot;Content-length: &quot;.filesize($file));
       header('Content-Type: application/octet-stream');
       header('Content-Disposition: attachment; filename=&quot;' . $file . '&quot;');
       readfile(&quot;$file&quot;);
    } else {
       echo &quot;No file selected&quot;;
    }
}
```

12\. PHP创建标签云

```
function getCloud( $data = array(), $minFontSize = 12, $maxFontSize = 30 )
{
    $minimumCount = min( array_values( $data ) );
    $maximumCount = max( array_values( $data ) );
    $spread       = $maximumCount - $minimumCount;
    $cloudHTML    = '';
    $cloudTags    = array(); 

    $spread == 0 &amp;&amp; $spread = 1; 

    foreach( $data as $tag =&gt; $count )
    {
        $size = $minFontSize + ( $count - $minimumCount )
            * ( $maxFontSize - $minFontSize ) / $spread;
        $cloudTags[] = '['
        . htmlspecialchars( stripslashes( $tag ) ) . '](# "&#39;&#39; . $tag  .&#13;&#10;        &#39;&#39; returned a count of &#39; . $count . &#39;")';
    } 

    return join( &quot;n&quot;, $cloudTags ) . &quot;n&quot;;
}
/**************************
****   Sample usage    ***/
$arr = Array('Actionscript' =&gt; 35, 'Adobe' =&gt; 22, 'Array' =&gt; 44, 'Background' =&gt; 43,
    'Blur' =&gt; 18, 'Canvas' =&gt; 33, 'Class' =&gt; 15, 'Color Palette' =&gt; 11, 'Crop' =&gt; 42,
    'Delimiter' =&gt; 13, 'Depth' =&gt; 34, 'Design' =&gt; 8, 'Encode' =&gt; 12, 'Encryption' =&gt; 30,
    'Extract' =&gt; 28, 'Filters' =&gt; 42);
echo getCloud($arr, 12, 36);

```

13\. PHP寻找两个字符串的相似性

PHP 提供了一个极少使用的 similar_text 函数，但此函数非常有用，用于比较两个字符串并返回相似程度的百分比。

```
similar_text($string1, $string2, $percent);
//$percent will have the percentage of similarity

```

14\. PHP在应用程序中使用 Gravatar 通用头像

随着 WordPress 越来越普及，Gravatar 也随之流行。由于 Gravatar 提供了易于使用的 API，将其纳入应用程序也变得十分方便。

```
/******************
*@email - Email address to show gravatar for
*@size - size of gravatar
*@default - URL of default gravatar to use
*@rating - rating of Gravatar(G, PG, R, X)
*/
function show_gravatar($email, $size, $default, $rating)
{
    echo '![](http://www.gravatar.com/avatar.php?gravatar_id=)';
}

```

15\. PHP在字符断点处截断文字

所谓断字 (word break)，即一个单词可在转行时断开的地方。这一函数将在断字处截断字符串。

```
// Original PHP code by Chirp Internet: www.chirp.com.au
// Please acknowledge use of this code by including this header.
function myTruncate($string, $limit, $break=&quot;.&quot;, $pad=&quot;...&quot;) {
    // return with no change if string is shorter than $limit
    if(strlen($string) &lt;= $limit)
        return $string;  

    // is $break present between $limit and the end of the string?
    if(false !== ($breakpoint = strpos($string, $break, $limit))) {
        if($breakpoint &lt; strlen($string) - 1) {
            $string = substr($string, 0, $breakpoint) . $pad;
        }
    }
    return $string;
}
/***** Example ****/
$short_string=myTruncate($long_string, 100, ' ');

```

16\. PHP文件 Zip 压缩

```
/* creates a compressed zip file */
function create_zip($files = array(),$destination = '',$overwrite = false) {
    //if the zip file already exists and overwrite is false, return false
    if(file_exists($destination) &amp;&amp; !$overwrite) { return false; }
    //vars
    $valid_files = array();
    //if files were passed in...
    if(is_array($files)) {
        //cycle through each file
        foreach($files as $file) {
            //make sure the file exists
            if(file_exists($file)) {
                $valid_files[] = $file;
            }
        }
    }
    //if we have good files...
    if(count($valid_files)) {
        //create the archive
        $zip = new ZipArchive();
        if($zip-&gt;open($destination,$overwrite ? ZIPARCHIVE::OVERWRITE : ZIPARCHIVE::CREATE) !== true) {
            return false;
        }
        //add the files
        foreach($valid_files as $file) {
            $zip-&gt;addFile($file,$file);
        }
        //debug
        //echo 'The zip archive contains ',$zip-&gt;numFiles,' files with a status of ',$zip-&gt;status; 

        //close the zip -- done!
        $zip-&gt;close(); 

        //check to make sure the file exists
        return file_exists($destination);
    }
    else
    {
        return false;
    }
}
/***** Example Usage ***/
$files=array('file1.jpg', 'file2.jpg', 'file3.gif');
create_zip($files, 'myzipfile.zip', true);

```

17\. PHP解压缩 Zip 文件

```
/**********************
*@file - path to zip file
*@destination - destination directory for unzipped files
*/
function unzip_file($file, $destination){
    // create object
    $zip = new ZipArchive() ;
    // open archive
    if ($zip-&gt;open($file) !== TRUE) {
        die (’Could not open archive’);
    }
    // extract contents to destination directory
    $zip-&gt;extractTo($destination);
    // close archive
    $zip-&gt;close();
    echo 'Archive extracted to directory';
}

```

18\. PHP为 URL 地址预设 http 字符串

有时需要接受一些表单中的网址输入，但用户很少添加 http:// 字段，此代码将为网址添加该字段。

```
if (!preg_match(&quot;/^(http|ftp):/&quot;, $_POST['url'])) {
   $_POST['url'] = 'http://'.$_POST['url'];
}

```

19\. PHP将网址字符串转换成超级链接

该函数将 URL 和 E-mail 地址字符串转换为可点击的超级链接。

```
function makeClickableLinks($text) {
 $text = eregi_replace('(((f|ht){1}tp://)[-a-zA-Z0-9@:%_+.~#?&amp;//=]+)',
 '[1](1)', $text);
 $text = eregi_replace('([[:space:]()[{}])(www.[-a-zA-Z0-9@:%_+.~#?&amp;//=]+)',
 '1[2](http://2)', $text);
 $text = eregi_replace('([_.0-9a-z-]+@([0-9a-z][0-9a-z-]+.)+[a-z]{2,3})',
 '[1](mailto:1)', $text); 

return $text;
}

```

20\. PHP调整图像尺寸

创建图像缩略图需要许多时间，此代码将有助于了解缩略图的逻辑。

```
/**********************
*@filename - path to the image
*@tmpname - temporary path to thumbnail
*@xmax - max width
*@ymax - max height
*/
function resize_image($filename, $tmpname, $xmax, $ymax)
{
    $ext = explode(&quot;.&quot;, $filename);
    $ext = $ext[count($ext)-1]; 

    if($ext == &quot;jpg&quot; || $ext == &quot;jpeg&quot;)
        $im = imagecreatefromjpeg($tmpname);
    elseif($ext == &quot;png&quot;)
        $im = imagecreatefrompng($tmpname);
    elseif($ext == &quot;gif&quot;)
        $im = imagecreatefromgif($tmpname); 

    $x = imagesx($im);
    $y = imagesy($im); 

    if($x &lt;= $xmax &amp;&amp; $y &lt;= $ymax)
        return $im; 

    if($x &gt;= $y) {
        $newx = $xmax;
        $newy = $newx * $y / $x;
    }
    else {
        $newy = $ymax;
        $newx = $x / $y * $newy;
    } 

    $im2 = imagecreatetruecolor($newx, $newy);
    imagecopyresized($im2, $im, 0, 0, 0, 0, floor($newx), floor($newy), $x, $y);
    return $im2;
}

```

21\. PHP检测 ajax 请求

大多数的 JavaScript 框架如 jquery，Mootools 等，在发出 Ajax 请求时，都会发送额外的 HTTP_X_REQUESTED_WITH 头部信息，头当他们一个ajax请求，因此你可以在服务器端侦测到 Ajax 请求。

```
if(!emptyempty($_SERVER['HTTP_X_REQUESTED_WITH']) &amp;&amp; strtolower($_SERVER['HTTP_X_REQUESTED_WITH']) == 'xmlhttprequest'){
    //If AJAX Request Then
}else{
//something else
}

```

英文原稿：[21 Really Useful &amp; Handy PHP Code Snippets | Web Developer Plus](http://webdeveloperplus.com/php/21-really-useful-handy-php-code-snippets/)