---
title: php-修复未正常关闭的-html-标签（支持嵌套和就近闭合）
id: 313406
categories:
  - 转载
date: 2012-06-09 05:04:54
tags:
---

<pre class="lang:php decode:true ">&lt;?php

/**
 * fixHtmlTag
 *
 * HTML标签修复函数，此函数可以修复未正确闭合的 HTML 标签
 *
 * 由于不确定性因素太多，暂时提供两种模式“嵌套闭合模式”和
 * “就近闭合模式”，应该够用了。
 *
 * 这两种模式是我为了解释清楚此函数的实现而创造的两个名词，
 * 只需明白什么意思就行。
 * 1，嵌套闭合模式，NEST，为默认的闭合方式。即 "&lt;body&gt;&lt;div&gt;你好"
 * 这样的 html 代码会被修改为 "&lt;body&gt;&lt;div&gt;你好&lt;/div&gt;&lt;/body&gt;"
 * 2，就近闭合模式，CLOSE，这种模式会将形如 "&lt;p&gt;你好&lt;p&gt;为什么没有
 * 闭合呢" 的代码修改为 "&lt;p&gt;你好&lt;/p&gt;&lt;p&gt;为什么没有闭合呢&lt;/p&gt;"
 *
 * 在嵌套闭合模式（默认，无需特殊传参）下，可以传入需要就近闭合的
 * 标签名，通过这种方式将类似 "&lt;body&gt;&lt;p&gt;你好&lt;/p&gt;&lt;p&gt;我也好" 转换为
 * "&lt;body&gt;&lt;p&gt;你好&lt;/p&gt;&lt;p&gt;我也好&lt;/p&gt;&lt;/body&gt;"的形式。
 * 传参时索引需要按照如下方式写，不需要修改的设置可以省略
 * 
 * 					$param = array(
 * 						'html' =&gt; '',			//必填
 * 						'options' =&gt; array(
 * 							'tagArray' =&gt; array();
 * 							'type' =&gt; 'NEST',
 * 							'length' =&gt; null,
 * 							'lowerTag' =&gt; TRUE,
 * 							'XHtmlFix' =&gt; TRUE,
 * 							)
 * 						);
 * 					fixHtmlTag($param);
 * 
 * 上面索引对应的值含义如下
 * string 	$html	 需要修改的 html 代码
 * array  	$tagArray 当为嵌套模式时，需要就近闭合的标签数组
 * string 	$type	 模式名，目前支持 NEST 和 CLOSE 两种模式，如果设置为 CLOSE，将会忽略参数 $tagArray 的设置，而全部就近闭合所有标签
 * ini 		$length   如果希望截断一定长度，可以在此赋值，此长度指的是字符串长度
 * bool 	$lowerTag 是否将代码中的标签全部转换为小写，默认为 TRUE
 * bool 	$XHtmlFix 是否处理不符合 XHTML 规范的标签，即将 &lt;br&gt; 转换为 &lt;br /&gt;
 *
 * @author  IT不倒翁 &lt;itbudaoweng@gmail.com&gt;
 * @version 0.2
 * @link  	http://yungbo.com IT不倒翁
 * @link 	http://enenba.com/?post=19 某某
 * @param 	array 	$param 	  数组参数，需要赋予特定的索引
 * @return 	string 	$result	  经过处理后的 html 代码
 * @since 	2012-04-14
 */
function fixHtmlTag($param = array()) {
	//参数的默认值
	$html = '';
	$tagArray = array();
	$type = 'NEST';
	$length = null;
	$lowerTag = TRUE;
	$XHtmlFix = TRUE;

	//首先获取一维数组，即 $html 和 $options （如果提供了参数）
	extract($param);

	//如果存在 options，提取相关变量
	if (isset($options)) {
		extract($options);
	}

	$result   = ''; //最终要返回的 html 代码
	$tagStack = array(); //标签栈，用 array_push() 和 array_pop() 模拟实现
	$contents = array(); //用来存放 html 标签
	$len	  = 0; //字符串的初始长度

	//设置闭合标记 $isClosed，默认为 TRUE, 如果需要就近闭合，成功匹配开始标签后其值为 false,成功闭合后为 true
	$isClosed = true;

	//将要处理的标签全部转为小写
	$tagArray = array_map('strtolower', $tagArray);

	//“合法”的单闭合标签
	$singleTagArray = array(
		'&lt;meta',
		'&lt;link',
		'&lt;base',
		'&lt;br',
		'&lt;hr',
		'&lt;input',
		'&lt;img'
	);

	//校验匹配模式 $type，默认为 NEST 模式
	$type = strtoupper($type);
	if (!in_array($type, array('NEST', 'CLOSE'))) {
		$type = 'NEST';
	}

	//以一对 &lt; 和 &gt; 为分隔符，将原 html 标签和标签内的字符串放到数组中
	$contents = preg_split("/(&lt;[^&gt;]+?&gt;)/si", $html, -1, PREG_SPLIT_NO_EMPTY | PREG_SPLIT_DELIM_CAPTURE);

	foreach ($contents as $tag) {
		if ('' == trim($tag)) {
			$result .= $tag;
			continue;
		}

		//匹配标准的单闭合标签，如&lt;br /&gt;
		if (preg_match("/&lt;(\w+)[^\/&gt;]*?\/&gt;/si", $tag)) {
			$result .= $tag;
			continue;
		}

		//匹配开始标签，如果是单标签则出栈
		else if (preg_match("/&lt;(\w+)[^\/&gt;]*?&gt;/si", $tag, $match)) {
			//如果上一个标签没有闭合，并且上一个标签属于就近闭合类型
			//则闭合之，上一个标签出栈

			//如果标签未闭合
			if (false === $isClosed) {
				//就近闭合模式，直接就近闭合所有的标签
				if ('CLOSE' == $type) {
					$result .= '&lt;/' . end($tagStack) . '&gt;';
					array_pop($tagStack);
				}
				//默认的嵌套模式，就近闭合参数提供的标签
				else {
					if (in_array(end($tagStack), $tagArray)) {
						$result .= '&lt;/' . end($tagStack) . '&gt;';
						array_pop($tagStack);
					}
				}
			}

			//如果参数 $lowerTag 为 TRUE 则将标签名转为小写
			$matchLower = $lowerTag == TRUE ? strtolower($match[1]) : $match[1];

			$tag = str_replace('&lt;' . $match[1], '&lt;' . $matchLower, $tag);
			//开始新的标签组合
			$result .= $tag;
			array_push($tagStack, $matchLower);

			//如果属于约定的的单标签，则闭合之并出栈
			foreach ($singleTagArray as $singleTag) {
				if (stripos($tag, $singleTag) !== false) {
					if ($XHtmlFix == TRUE) {
						$tag = str_replace('&gt;', ' /&gt;', $tag);
					}
					array_pop($tagStack);
				}
			}

			//就近闭合模式，状态变为未闭合
			if ('CLOSE' == $type) {
				$isClosed = false;
			}
			//默认的嵌套模式，如果标签位于提供的 $tagArray 里，状态改为未闭合
			else {
				if (in_array($matchLower, $tagArray)) {
					$isClosed = false;
				}
			}
			unset($matchLower);
		}

		//匹配闭合标签，如果合适则出栈
		else if (preg_match("/&lt;\/(\w+)[^\/&gt;]*?&gt;/si", $tag, $match)) {

			//如果参数 $lowerTag 为 TRUE 则将标签名转为小写
			$matchLower = $lowerTag == TRUE ? strtolower($match[1]) : $match[1];

			if (end($tagStack) == $matchLower) {
				$isClosed = true; //匹配完成，标签闭合
				$tag = str_replace('&lt;/' . $match[1], '&lt;/' . $matchLower, $tag);
				$result .= $tag;
				array_pop($tagStack);
			}
			unset($matchLower);
		}

		//匹配注释，直接连接 $result
		else if (preg_match("/&lt;!--.*?--&gt;/si", $tag)) {
			$result .= $tag;
		}

		//将字符串放入 $result ，顺便做下截断操作
		else {
			if (is_null($length) || $len + mb_strlen($tag) &lt; $length) {
				$result .= $tag;
				$len += mb_strlen($tag);
			} else {
				$str = mb_substr($tag, 0, $length - $len + 1);
				$result .= $str;
				break;
			}
		}
	}

	//如果还有将栈内的未闭合的标签连接到 $result
	while (!empty($tagStack)) {
		$result .= '&lt;/' . array_pop($tagStack) . '&gt;';
	}
	return $result;
}</pre>
&nbsp;

&nbsp;

[http://yungbo.com/php/php-fix-unmachted-html-tags-no-phptidy-extension.html](http://yungbo.com/php/php-fix-unmachted-html-tags-no-phptidy-extension.html)

[http://blog.csdn.net/iseagold/article/details/5484904](http://blog.csdn.net/iseagold/article/details/5484904)