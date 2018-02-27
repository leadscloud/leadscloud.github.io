---
title: gae本地无法运行解决方法
tags:
  - GAE
id: 22001
categories:
  - 个人日志
date: 2010-08-30 11:54:11
---

今天在本地运行micolog出现错误regex invalid: unbalanced parenthesis上网搜了下，终于在一篇英文里找到解决方法。

Change lines 2369-70 in &lt;installdir&gt;\google\appengine\tools 
\dev_appserver.py from: 

&nbsp; &nbsp; &nbsp; regex = os.path.join(re.escape(regex), '(.*)') 
&nbsp; &nbsp; &nbsp; path = os.path.join(path, '\\1') 

to: 

&nbsp; &nbsp; &nbsp; regex = re.escape(regex) + '/(.*)' 
&nbsp; &nbsp; &nbsp; path = path + '/\\1' 

这个问题决之后竟然又出现错误

2010-08-30 20:05:53 Running command: "['C:\\Python25\\python.exe', 'C:\\Program Files\\Google\\google_appengine\\dev_appserver.py', '--admin_console_server=', '--port=8081', 'C:\\Program Files\\Google\\google_appengine\\micolog0']"
WARNING&nbsp; 2010-08-30 20:05:54,559 datastore_file_stub.py] Could not read datastore data from c:\users\admini~1\appdata\local\temp\dev_appserver.datastore.history
INFO&nbsp;&nbsp;&nbsp;&nbsp; 2010-08-30 20:05:54,573 dev_appserver_main.py] Running application seogroupshare on port 8081: [http://localhost:8081](http://localhost:8081)
INFO&nbsp;&nbsp;&nbsp;&nbsp; 2010-08-30 20:05:58,381 model.py] module base reloaded
INFO&nbsp;&nbsp;&nbsp;&nbsp; 2010-08-30 20:05:58,552 base.py] module base reloaded
ERROR&nbsp;&nbsp;&nbsp; 2010-08-30 20:05:58,739 dev_appserver.py] Exception encountered handling request
Traceback (most recent call last):
&nbsp; File "C:\Program Files\Google\google_appengine\google\appengine\tools\dev_appserver.py", line 2245, in _HandleRequest
&nbsp;&nbsp;&nbsp; base_env_dict=env_dict)
&nbsp; File "C:\Program Files\Google\google_appengine\google\appengine\tools\dev_appserver.py", line 334, in Dispatch
&nbsp;&nbsp;&nbsp; base_env_dict=base_env_dict)
&nbsp; File "C:\Program Files\Google\google_appengine\google\appengine\tools\dev_appserver.py", line 1743, in Dispatch
&nbsp;&nbsp;&nbsp; self._module_dict)
&nbsp; File "C:\Program Files\Google\google_appengine\google\appengine\tools\dev_appserver.py", line 1654, in ExecuteCGI
&nbsp;&nbsp;&nbsp; reset_modules = exec_script(handler_path, cgi_path, hook)
&nbsp; File "C:\Program Files\Google\google_appengine\google\appengine\tools\dev_appserver.py", line 1555, in ExecuteOrImportScript
&nbsp;&nbsp;&nbsp; exec module_code in script_module.__dict__
&nbsp; File "C:\Program Files\Google\google_appengine\micolog0\blog.py", line 720, in &lt;module&gt;
&nbsp;&nbsp;&nbsp; main()
&nbsp; File "C:\Program Files\Google\google_appengine\micolog0\blog.py", line 715, in main
&nbsp;&nbsp;&nbsp; g_blog.application=application
AttributeError: 'NoneType' object has no attribute 'application'
INFO&nbsp;&nbsp;&nbsp;&nbsp; 2010-08-30 20:05:58,739 dev_appserver.py] "GET / HTTP/1.1" 500 -

这次是怎么也搞不定了，google一下竟然就只有十几个页面，而且都和这没关系。期待谁能帮我解决下啊。