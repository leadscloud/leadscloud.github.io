---
title: Python requests 如何使用 oauth2client.service_account
id: 20220914
categories:
  - 技术
date: 2022-09-14 11:50:00
tags: ['python', 'oauth2client']
---

Google的API一般是下面这种使用方法，使用的是oauth2client

```
from oauth2client.service_account import ServiceAccountCredentials
import httplib2
credentials = ServiceAccountCredentials.from_json_keyfile_name(JSON_KEY_FILE, scopes=SCOPES)
http = credentials.authorize(httplib2.Http())

response, content = http.request(ENDPOINT, method="POST", body=json_ctn)
```

众所周知的原因，在国内你这样使用，必须得用代理，使用requests包非常方便，但是如果是上面的代码，使用代理有点小麻烦

你需要在代码前面加上

```
import socket
socket.socket = socks.socksocket
socks.setdefaultproxy(socks.PROXY_TYPE_SOCKS5, "127.0.0.1", 1080)
```

比较麻烦。


可以用requests代替上面的操作，一般如下

```
http = httplib2.Http(proxy_info=httplib2.ProxyInfo(httplib2.socks.PROXY_TYPE_SOCKS5, '127.0.0.1', 1080))

credentials = ServiceAccountCredentials.from_json_keyfile_name(JSON_KEY_FILE, scopes=SCOPES)
access_token_info = credentials.get_access_token(http)

requests.get(url, params={
    "url": "http://foo.com"
}, proxies={
    'http': "socks5://127.0.0.1:1080",
    'https': "socks5://127.0.0.1:1080",
}, headers={
    "Authorization": 'Bearer ' + access_token_info.access_token
})
```

参考代码： https://github.com/googleapis/oauth2client/blob/master/oauth2client/transport.py