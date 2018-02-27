---
title: fix-nginx-increase-server_names_hash_bucket_size-error
id: 313947
categories:
  - Linux
date: 2015-04-29 13:22:11
tags:
---

When adding new virtual hosts in your nginx configuration file, you can experience this error message:
<pre># nginx -t
2008/11/13 09:37:03 [emerg] 12299#0: could not build the server_names_hash, you should increase server_names_hash_bucket_size: 32
2008/11/13 09:37:03 [emerg] 12299#0: the configuration file /etc/nginx/nginx.conf test failed</pre>
_[server_names_hash_bucket_size](http://wiki.codemongers.com/NginxHttpCoreModule#server_names_hash_bucket_size)_ controls the maximum length of a virtual host entry (ie the length of the domain name).

In other words, if your domain names are long, increase this parameter.

You need to add this flag in the _http_ context:
<pre>http {
    server_names_hash_bucket_size 64;
    ...
}</pre>
After increasing the value, test your configuration file and reload nginx:
<pre class=""># nginx -t
2008/11/13 09:48:06 [info] 12315#0: the configuration file /etc/nginx/nginx.conf syntax is ok
2008/11/13 09:48:06 [info] 12315#0: the configuration file /etc/nginx/nginx.conf was tested successfully
# kill -HUP `  /var/run/nginx.pid`</pre>