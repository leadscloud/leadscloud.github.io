<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>在线ZIP解压程序</title>
<style type="text/css">
<!--
body,td{
	font-size: 14px;
	color: #000000;
}
a {
	color: #000066;
	text-decoration: none;
}
a:hover {
	color: #FF6600;
	text-decoration: underline;
}
-->
</style>
</head>

<body>
  <form name="myform" method="post" action="<?=$_SERVER['PHP_SELF']?>" enctype="multipart/form-data">
<?php
	if(!isset($_REQUEST['myaction'])):
?>


<table width="100%" border="0" cellspacing="0" cellpadding="4">
    <tr>
      <td height="40" colspan="2" style="color:#FF9900"><p><font color="#FF0000">在线解压ZIP文件程序</font></p>
      <p>使用方法:把zip文件通过FTP上传到本文件相同的目录下,选择zip文件;或直接点击“浏览...”上传zip文件。</p>
      <p>解压的结果保留原来的目录结构。</p>
      <p>&nbsp;</p></td>
    </tr>
    <tr>
      <td width="11%">选择ZIP文件: </td>
      <td width="89%"><select name="zipfile">
        <option value="" selected>- 请选择 -</option>
<?php
  	$fdir = opendir('./');
	while($file=readdir($fdir)){
		if(!is_file($file)) continue;
		if(preg_match('/\.zip$/mis',$file)){
			echo "<option value='$file'>$file</option>\r\n";
		}
	}
?>
      </select></td>
    </tr>
    <tr>
      <td width="11%" nowrap>或上传文件: </td>
      <td width="89%"><input name="upfile" type="file" id="upfile" size="20"></td>
    </tr>
	<tr>
      <td>或在线文件: </td>
      <td><input name="customfile" type="text" id="customfile" value="http://leadscloud.github.io/soft/typecho.zip" size="45"> </td>
    </tr>
	<tr>
      <td>解压到目录: </td>
      <td><input name="todir" type="text" id="todir" value="./" size="15"> 
      (留空为本目录,必须有写入权限)</td>
    </tr>	
    <tr>
      <td><input name="myaction" type="hidden" id="myaction" value="dounzip"></td>
      <td><input type="submit" name="Submit" value=" 解 压 "><input type="checkbox" id="selfdel" name="selfdel" value="true" checked="checked" /><label for="selfdel">完成后删除本脚本（建议）</label></td>
    </tr>
  </table>

<?php

elseif($_REQUEST["myaction"]=="dounzip"):


class zip
{
   var $total_files = 0;
function extract_detect($method)
{
	static $status = array();
	if (isset($status[$method])) return $status[$method];
	switch ($method)
	{
		case 'zip':
			$status[$method] = extension_loaded('zip') ? true : false;
			break;
		default:
			return false;
	}
	return $status[$method];
}
function extract_file($filename, $extractPath='./', $errtxt)
{
	if ($this->extract_detect('zip')) {
		$zip = new ZipArchive;
		$success = $zip->open($filename);
		$this->total_files = $zip->numFiles;
		if ($success === true) $success = $zip->extractTo($extractPath);
		$zip->close();
		if ($success === true) {
			return true;
		} else {
			if ($success === false) {
				$errtxt = "解压缩出错（zip库报告）";
			} else {
				$errtxt = "打开压缩包出错：Error code ".$success;
			}
			return false;
		}
	} else {
		$errtxt = "您的PHP不支持zip组件。";
	}
}

// end class
}
function http_request_detect($method)
{
	static $status = array();
	if (isset($status[$method])) return $status[$method];
	switch ($method)
	{
		case 'curl':
			$status[$method] = extension_loaded('curl') ? true : false;
			break;
		case 'fopen':
			$status[$method] = get_cfg_var('allow_url_fopen') ? true : false;
			break;
		/*case 'fsockopen':
			$status[$method] = function_exists('fsockopen') ? true : false;
			break;*/
		default:
			return false;
	}
	return $status[$method];
}
function http_request($url, &$errtxt, $filename=false)
{
	if (empty($url)) return false;
	if (empty($filename)) $filename = false;
	
	if (http_request_detect('curl')) {
		$ch = curl_init($url);
		curl_setopt($ch, CURLOPT_HEADER, 0);
		if ($filename) {
			$fp = fopen($filename, "w");
			curl_setopt($ch, CURLOPT_FILE, $fp);
		} else {
			curl_setopt($ch, CURLOPT_RETURNTRANSFER, 1);
		}
		$cdata = curl_exec($ch);
		curl_close($ch); if ($filename) fclose($fp);
		if ($cdata) {
			if ($filename) return true; else return $cdata;
		} else {
			$errtxt = "cURL报告错误：".curl_error($ch);
			return false;
		}
	} else if (http_request_detect('fopen')) {
		@$fp_remote = fopen($url, "rb");
		if ($fp_remote) {
			$file_contents = '';
			while (!feof($fp_remote)) {
				$file_contents .= fread($fp_remote, 8192);
			}
			fclose($fp_remote);
			if ($filename) {
				@$fp_local = fopen($filename, 'w');
				if ($fp_local) {
					fwrite($fp_local, $file_contents);
					fclose($fp_local);
					return true;
				} else {
					$errtxt = "写入本地文件错误 ";
					$errtxt .= "No. ".$lasterr['type'].": ".$lasterr['message'];
					return false;
				}
			} else {
				return $file_contents;
			}
		} else {
			$lasterr = error_get_last();
			$errtxt = "fopen抓取URL错误 ";
			$errtxt .= "No. ".$lasterr['type'].": ".$lasterr['message'];
			return false;
		}
	/*} else if (http_request_detect('fsockopen')) {
		// 必要性论证中*/
	} else {
		$errtxt = "您的PHP不支持cURL、fopen任何一种主动发起HTTP请求的方式。";
		return false;
	}
}

	set_time_limit(0);

	if(!$_POST["todir"]) $_POST["todir"] = "./";
	$z = new Zip;
	$have_zip_file = 0;
	function start_unzip($tmp_name,$new_name,$checked){
		global $_POST,$z,$have_zip_file,$errorInfo;
		$upfile = array("tmp_name"=>$tmp_name,"name"=>$new_name);
		if(is_file($upfile['tmp_name'])){
			$have_zip_file = 1;
			echo "<br>正在解压: <input name='dfile[]' type='checkbox' value='$upfile[name]' ".($checked?"checked":"")."> $upfile[name]<br><br>";
			if(preg_match('/\.zip$/mis',$upfile['name'])){
				$result=$z->extract_file($upfile['tmp_name'],$_POST["todir"],$errorInfo);
				if(!$result){
					echo "<br>文件 $upfile[name] 错误.<br>".$errorInfo;
				}
				echo "<br>完成,共建立 $z->total_files 个文件.<br><br><br>";
			}else{
				echo "<br>$upfile[name] 不是 zip 文件.<br><br>";			
			}
			if(realpath($upfile['name'])!=realpath($upfile['tmp_name'])){
				@unlink($upfile['name']);
				rename($upfile['tmp_name'],$upfile['name']);
			}
		}
	}
	clearstatcache();
	if($_POST["customfile"]!=null){
		$filename = 'typecho.zip';
		$success = http_request($_POST["customfile"], $errtxt, $filename);
		if($success)
			start_unzip($filename,$filename,0);
		else
			echo "在线解压出错：下载失败！";
		global $filename;
		echo "移除typecho子目录... ";
		$dir = "./typecho/";
		if (is_dir($dir)) {
			if ($dh = opendir($dir)) {
				while (($currfile = readdir($dh)) !== false) {
					if ($currfile!="." && $currfile!="..") {
						if (!file_exists("./".$currfile)) {
							rename($dir.$currfile, "./".$currfile);
						} else {
							echo("文件 ".$currfile." 已存在！ 请检查您的目录中是否已经安装过了Typecho。\n（建议您在空目录中运行本程序）");
						}
					}
				}
				closedir($dh);
			}
			rmdir($dir);
		} else {
			echo("解开的zip包中不含typecho子目录！(可能不是正确的typecho安装包)");
		}
	}
	
	if($_POST["zipfile"]!=null){
		start_unzip($_POST["zipfile"],$_POST["zipfile"],0);
	}
	
	if($_FILES["upfile"]['tmp_name']!=null){
		start_unzip($_FILES["upfile"]['tmp_name'],$_FILES["upfile"]['name'],1);
	}

	if($_POST["customfile"]==null && $_POST["zipfile"]==null && $_FILES["upfile"]['tmp_name']==null){
		echo "没有任何文件可以解压!<br />";
	}
	
	$script_filename = basename($_SERVER['PHP_SELF']);
	if (isset($_POST["selfdel"]) && $_POST["selfdel"] == "true") {
		echo "脚本自我销毁... ";
		unlink($_SERVER['SCRIPT_FILENAME']);
		unlink($filename);
		echo "完成. ";
	} else {
		echo '<span class="error">'.'警告：'.'</span>';
		echo ("\n根据您的指令，这个脚本并未自我销毁。\n 任何其他人都可以通过这个脚本上传、解压ZIP文件。\n
		安全起见，建议您尽快手工删除。");
	}

	if(!$have_zip_file){
		echo "<br>请选择或上传文件.<br>";
	}
?>
<input name="password" type="hidden" id="password" value="<?=$_POST['password'];?>">
<input name="myaction" type="hidden" id="myaction" value="dodelete">
<input name="按钮" type="button" value="返回" onClick="window.location='<?=$_SERVER[PHP_SELF];?>';">

<input type='button' value='反选' onclick='selrev();'> <input type='submit' onclick='return confirm("删除选定文件?");' value='删除选定'>

<script language='javascript'>
function selrev() {
	with(document.myform) {
		for(i=0;i<elements.length;i++) {
			thiselm = elements[i];
			if(thiselm.name.match(/dfile\[]/))	thiselm.checked = !thiselm.checked;
		}
	}
}
alert('完成.');
</script>
<?php

elseif($_REQUEST["myaction"]=="dodelete"):
	set_time_limit(0);
	
	$dfile = $_POST["dfile"]; 
	echo "正在删除文件...<br><br>";
	if(is_array($dfile)){
		for($i=count($dfile)-1;$i>=0;$i--){
			if(is_file($dfile[$i])){
				if(@unlink($dfile[$i])){
					echo "已删除文件: $dfile[$i]<br>";
				}else{
					echo "删除文件失败: $dfile[$i]<br>";
				}
			}else{
				if(@rmdir($dfile[$i])){
					echo "已删除目录: $dfile[$i]<br>";
				}else{
					echo "删除目录失败: $dfile[$i]<br>";
				}				
			}
			
		}
	}
	echo "<br>完成.<br><br><input type='button' value='返回' onclick=\"window.location='$_SERVER[PHP_SELF]';\"><br><br>
		 <script language='javascript'>('完成.');</script>";

endif;

?>
  </form>
</body>
</html>