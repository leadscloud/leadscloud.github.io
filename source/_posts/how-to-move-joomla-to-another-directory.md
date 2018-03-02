---
title: How to move Joomla to another directory?
tags:
  - CMS
  - Joomla
id: 66002
categories:
  - 个人日志
date: 2010-10-11 12:32:52
---

Many web designers prefer to build their websites in test
folders and when their development is over to move their Joomla
applications to the root folder of their hosting accounts.

For the purpose of this article let us presume that we have a Joomla 1.5 installed in the _public_html/**test**_ folder in our account and we want to move it to the _public_html_ directory so that it will be directly accessible through _www.yourdomain.com_.

This change consists of the following steps:

1\. Move all of the files and folders from your Joomla folder to the new directory. In our case from _public_html/test_ to _public_html_

2\. Reconfigure your application. You should edit your **configuration.php** file and make the following changes in it:

Change: _var $log_path = '/home/user/public_html/test/logs';_

To: _var $log_path = '/home/user/public_html/logs';_

Change: _var $tmp_path = '/home/user/public_html/test/tmp';_

To: _var $tmp_path = '/home/user/public_html/tmp';_

Change: _var $ftp_root = '/public_html/test';_

To:_ var $ftp_root = '/public_html';_

Change: _var $live_site = '[http://www.yourdomain.com/test](http://www.yourdomain.com/testing)';_

To: _var $live_site = '[http://www.yourdomain.com](http://www.yourdomain.com/)';_

3\. Remove the content of your cache folder (_public_html/cache_ in our case)

Now when you reload your website it should be working flawlessly from its new location.