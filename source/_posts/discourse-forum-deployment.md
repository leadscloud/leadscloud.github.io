---
title: Discourse论坛程序部署
date: 2017-08-01 13:21:49
tags: [discourse,论坛]
id: 315010
categories: 技术
---


## 安装discourse

```
    mkdir /var/discourse
    git clone https://github.com/discourse/discourse_docker.git /var/discourse
    cd /var/discourse
    cp samples/standalone.yml containers/app.yml
```

## 修改app.yml文件

文件修改如果错了，再重新编绎非常花时间，所以最好一次搞定，还是就是邮箱非常重要，填写真实的。

```   
    templates:
    – "templates/postgres.template.yml"
    – "templates/redis.template.yml"
    – "templates/sshd.template.yml"
    – "templates/web.template.yml"
    – "templates/web.china.template.yml"
```

配置文件的这个部分，需要添加- "templates/web.china.template.yml";否则在`./launcher bootstrap app`初始化时会报错RuntimeError: …，原因得问GWF。

```
    ## on initial signup example'user1@example.com,user2@example.com'
    DISCOURSE_DEVELOPER_EMAILS: 'henry@outlook.com'
```

这里是开发者邮箱的设置，用于接收discoures论坛的官方邮件，只针对开发运营这个论坛的开发者。

```
    ## TODO: The domain name this Discourse instance will respond to
    DISCOURSE_HOSTNAME: 'weifuwu.ren'
```

域名设置没设么可说的，没有的话，用绑定的外网IP地址访问discourse也可以，购买了域名可以按照指南到域名管理界面，进行设置；

```
    DISCOURSE_SMTP_ADDRESS:smtp.mxchina.com
    DISCOURSE_SMTP_PORT:25
    DISCOURSE_SMTP_USER_NAME: info@weifuwu.ren
    DISCOURSE_SMTP_PASSWORD: xxxxxxx
    DISCOURSE_SMTP_ENABLE_START_TLS: true
    DISCOURSE_SMTP_AUTHENTICATION: login
    DISCOURSE_SMTP_OPENSSL_VERIFY_MODE: none
```

重点是在邮箱设置，我申请的阿里云邮箱

```
    – DISCOURSE_SMTP_PASSWORD: xxxxxxx设置的就是邮箱密码；
    – DISCOURSE_SMTP_PORT:端口设置25，
    – DISCOURSE_SMTP_ADDRESS:Host是smtp.mxchina.com,
```

DISCOURSE_SMTP_USER_NAME: 这里的设置最最重要的，这个邮箱又叫notification email 被用于发送所有重要系统邮件的邮箱地址。指定的域名必须正确设置 SPF、DKIM 和反向 PTR 记录以发送邮件。一般和域名绑定在一起，比如info@weifuwu.com 或者 admin@weifuwu.com 都行，这样收到邮件的发帖人或回复人感觉比较正式，使用这个邮箱也是最频繁的。关于SPF、DKIM设置有篇文章可参考1
如果您使用的阿里云的企业邮箱，域名解析后可以不用设置 SPF、DKIM 了已经设置好了，注意阿里云这里设置`DISCOURSE_SMTP_ADDRESS:smtp.mxhichina.com`

### 使用代理

因为国内网络环境的问题，`./launcher rebuild app` 操作经常卡壳，这时就需要配置个代理：discourse服务器上使用代理

编辑`app.yml`在env:下添加代理地址：

```
HTTP_PROXY: http://example.org:12345
HTTPS_PROXY: http://example.org:12345
```

## 加入国内镜像

```
    echo "DOCKER_OPTS=\"\$DOCKER_OPTS –registry-mirror=https://docker.mirrors.ustc.edu.cn\"" | sudo tee -a /etc/default/docker

    sudo service docker restart
```


## 初始化discourse

```
./launcher bootstrap app
# 启动discourse服务，就OK了！
./launcher start app
```

## 手动创建管理员账户

```
./launcher enter app

rake admin:create

exit
```

访问网站地址，成功打开就完成了

## 扩展安装

用 Let's Encrypt 添加 https 证书

### 添加模板

添加 `web.ssl.template.yml` 和 `web.letsencrypt.ssl.template.yml` 模板

> 注意：如果你正在使用 `web.socketed.template.yml` ，不用继续看这篇了。
> 你应该在主机上设置 Let's Encrypt 的客户端。客户端无法在 unix socket 上进行验证。

在app.yml文件中添加

```
templates:
  - "templates/web.template.yml"
  - "templates/web.ssl.template.yml"
  - "templates/web.letsencrypt.ssl.template.yml" 
```

### 暴露 443 端口

```
expose:
  - "80:80"
  - "443:443"
```

### 给 Let's Encrypt 添加个注册用邮箱账号

```
env:
  LETSENCRYPT_ACCOUNT_EMAIL: email@awesomedomain.com
```

### 运行rebuild命令

```
    ./launcher rebuild app
```


## 修改文章的永久链接

Replace all instances of the old name with the new name in posts

All the existing posts will still refer to the old domain. Let's fix that:

```
    ./launcher enter app
    discourse remap talk.foo.com talk.bar.com
    rake posts:rebake
```

This remaps text in posts from the old URL to the new URL, then regenerates all posts just in case.

## 我的app.yml配置

```
## this is the all-in-one, standalone Discourse Docker container template
##
## After making changes to this file, you MUST rebuild
## /var/discourse/launcher rebuild app
##
## BE *VERY* CAREFUL WHEN EDITING!
## YAML FILES ARE SUPER SUPER SENSITIVE TO MISTAKES IN WHITESPACE OR ALIGNMENT!
## visit http://www.yamllint.com/ to validate this file as needed

templates:
  - "templates/postgres.template.yml"
  - "templates/redis.template.yml"
  - "templates/web.template.yml"
  - "templates/web.ratelimited.template.yml"
## Uncomment these two lines if you wish to add Lets Encrypt (https)
  #- "templates/web.ssl.template.yml"
  #- "templates/web.letsencrypt.ssl.template.yml"

## which TCP/IP ports should this container expose?
## If you want Discourse to share a port with another webserver like Apache or nginx,
## see https://meta.discourse.org/t/17247 for details
expose:
  - "801:80"   # http
#  - "4443:443" # https

params:
  db_default_text_search_config: "pg_catalog.english"

  ## Set db_shared_buffers to a max of 25% of the total memory.
  ## will be set automatically by bootstrap based on detected RAM, or you can override
  #db_shared_buffers: "256MB"

  ## can improve sorting performance, but adds memory usage per-connection
  #db_work_mem: "40MB"

  ## Which Git revision should this container use? (default: tests-passed)
  #version: tests-passed
  version: stable

env:
  LANG: en_US.UTF-8
  DISCOURSE_DEFAULT_LOCALE: zh_CN
  # DISCOURSE_DEFAULT_LOCALE: en

  ## How many concurrent web requests are supported? Depends on memory and CPU cores.
  ## will be set automatically by bootstrap based on detected CPUs, or you can override
  #UNICORN_WORKERS: 3

  ## TODO: The domain name this Discourse instance will respond to
  DISCOURSE_HOSTNAME: 'bbs.lanthy.com'

  ## Uncomment if you want the container to be started with the same
  ## hostname (-h option) as specified above (default "$hostname-$config")
  #DOCKER_USE_HOSTNAME: true

  ## TODO: List of comma delimited emails that will be made admin and developer
  ## on initial signup example 'user1@example.com,user2@example.com'
  DISCOURSE_DEVELOPER_EMAILS: 'yourname@lanthy.com,test@qq.com'

  ## TODO: The SMTP mail server used to validate new accounts and send notifications
  DISCOURSE_SMTP_ADDRESS: smtp.exmail.qq.com         # required
  DISCOURSE_SMTP_PORT: 587                        # (optional, default 587)
  DISCOURSE_SMTP_USER_NAME: yourusername@lanthy.com      # 这儿填写你的邮箱地址
  DISCOURSE_SMTP_PASSWORD: yourpassword               # 邮箱密码 required, WARNING the char '#' in pw can cause problems!
  DISCOURSE_SMTP_ENABLE_START_TLS: true           # (optional, default true)
  DISCOURSE_SMTP_AUTHENTICATION: login
  DISCOURSE_SMTP_OPENSSL_VERIFY_MODE: none
  #DISCOURSE_SMTP_PASSWORD

  ## If you added the Lets Encrypt template, uncomment below to get a free SSL certificate
  #LETSENCRYPT_ACCOUNT_EMAIL: me@example.com

  ## The CDN address for this Discourse instance (configured to pull)
  ## see https://meta.discourse.org/t/14857 for details
  #DISCOURSE_CDN_URL: //discourse-cdn.example.com

## The Docker container is stateless; all data is stored in /shared
volumes:
  - volume:
      host: /var/discourse/shared/standalone
      guest: /shared
  - volume:
      host: /var/discourse/shared/standalone/log/var-log
      guest: /var/log

## Plugins go here
## see https://meta.discourse.org/t/19157 for details
hooks:
  after_code:
    - exec:
        cd: $home/plugins
        cmd:
          - git clone https://github.com/discourse/docker_manager.git
          - git clone https://github.com/angusmcleod/discourse-topic-previews.git
          - git clone https://github.com/discourse/discourse-staff-notes.git
          - git clone https://github.com/discourse/discourse-solved.git
          - git clone https://github.com/discourse/discourse-push-notifications.git
          - git clone https://github.com/discourse/discourse-voting.git
          - git clone https://github.com/ekkans/lrqdo-editor-plugin-discourse.git
          - git clone https://github.com/discourse/discourse-translator.git

## Any custom commands to run after building
run:
  - exec: echo "Beginning of custom commands"
  ## If you want to set the 'From' email address for your first registration, uncomment and change:
  ## After getting the first signup email, re-comment the line. It only needs to run once.
  - exec: rails r "SiteSetting.notification_email='zhanglei@lanthy.com'"
  - exec: echo "End of custom commands"
```

## 论坛域名配置 使用Nginx


> 域名 bbs.lanthy.com 的配置文件

```
lanthy@ubuntu:/var/discourse$ cat /usr/local/nginx/conf/vhost/bbs.lanthy.com.conf 
server
{
    listen 80;
    #listen [::]:80;
    server_name bbs.lanthy.com ;
    index index.html index.htm index.php default.html default.htm default.php;
    root  /home/wwwroot/bbs.lanthy.com;

    include none.conf;
    #error_page   404   /404.html;

    # Deny access to PHP files in specific directory
    #location ~ /(wp-content|uploads|wp-includes|images)/.*\.php$ { deny all; }

    location / {
        proxy_set_header X-Real-IP $remote_addr;
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
        proxy_set_header Host $http_host;
        proxy_set_header X-NginX-Proxy true;
        proxy_set_header X-Forwarded-Proto $scheme;

        proxy_pass http://127.0.0.1:801/;
        #proxy_redirect http://bbs.lanthy.com:801 http://bbs.lanthy.com:80;

        # Socket.IO Support
        #proxy_http_version 1.1;
        #proxy_set_header Upgrade $http_upgrade;
        #proxy_set_header Connection "upgrade";
    }

    #include enable-php.conf;

    #location ~ .*\.(gif|jpg|jpeg|png|bmp|swf)$
    #{
    #    expires      30d;
    #}

    #location ~ .*\.(js|css)?$
    #{
    #    expires      12h;
    #}

    #location ~ /.well-known {
    #    allow all;
    #}

    location ~ /\.
    {
        deny all;
    }

    access_log off;
}
```