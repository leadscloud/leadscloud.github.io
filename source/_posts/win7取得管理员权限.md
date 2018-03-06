---
title: win7取得管理员权限
id: 313403
categories:
  - 个人日志
date: 2012-06-08 13:11:27
tags:
---


把下面文件保存为文本文件，然后把扩展名txt改为reg . 双击文件导入即可，如果装了360会提示你，允许就行了。

```
Windows Registry Editor Version 5.00

[HKEY_CLASSES_ROOT\*\shell\runas]
@="管理员取得所有权"
"NoWorkingDirectory"=""

[HKEY_CLASSES_ROOT\*\shell\runas\command]
@="cmd.exe /c takeown /f \"%1\" &amp;&amp; icacls \"%1\" /grant administrators:F"
"IsolatedCommand"="cmd.exe /c takeown /f \"%1\" &amp;&amp; icacls \"%1\" /grant administrators:F"

[HKEY_CLASSES_ROOT\exefile\shell\runas2]
@="管理员取得所有权"
"NoWorkingDirectory"=""

[HKEY_CLASSES_ROOT\exefile\shell\runas2\command]
@="cmd.exe /c takeown /f \"%1\" &amp;&amp; icacls \"%1\" /grant administrators:F"
"IsolatedCommand"="cmd.exe /c takeown /f \"%1\" &amp;&amp; icacls \"%1\" /grant administrators:F"

[HKEY_CLASSES_ROOT\Directory\shell\runas]
@="管理员取得所有权"
"NoWorkingDirectory"=""

[HKEY_CLASSES_ROOT\Directory\shell\runas\command]
@="cmd.exe /c takeown /f \"%1\" /r /d y &amp;&amp; icacls \"%1\" /grant administrators:F /t"
"IsolatedCommand"="cmd.exe /c takeown /f \"%1\" /r /d y &amp;&amp; icacls \"%1\" /grant administrators:F /t"
```
