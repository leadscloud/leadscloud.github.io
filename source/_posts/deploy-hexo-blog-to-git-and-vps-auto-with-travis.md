---
title: 使用 TRAVIS 自动部署 HEXO 到 GITHUB 与 自己的VPS服务器
id: 316000
date: 2018-02-28 12:15:47
tags: 
  - hexo
  - github
  - travis
---

使用 TRAVIS 自动部署 HEXO 到 GITHUB 与 自己的服务器


## 前期准备

请尽可能用比较新的 RubyGems 版本，建议 2.6.x 以上。

```
$ gem update --system # 这里请翻墙一下
$ gem -v
2.6.3
```

使用国内镜像

```
$ gem sources --add https://gems.ruby-china.org/ --remove https://rubygems.org/
$ gem sources -l
https://gems.ruby-china.org
# 确保只有 gems.ruby-china.org
```

参考： https://gems.ruby-china.org/

## 安装travis

`sudo gem install travis`


## 配置github

我的github之前已经配置好GitHub Pages，现在需要变成下面这样，之前只有master一个分支。

- master 存放 Hexo 生成好的静态文件，所有 commit 信息格式均为 `Site updated: %Y-%m-%d %H:%M:%S`；
- source 存放 scaffolds（脚手架）、source（文章 Markdown 源码）、_config.yml（Hexo 配置）等文件，并设置为 repo 的默认分支。


## 配置 Travis CI

- 使用github帐号登录Travis，右上方按钮点击同步项目，下方打开需要集成的项目，最后点击齿轮进入项目配置页面
- 打开Build only if .travis.yml is present

参考这篇文章 https://segmentfault.com/a/1190000009054888


## 通过命令行登录 Travis 并加密文件：

在hexo blog项目根目录下创建一个文件 `.travis.yml`

```
cd 博客根目录
touch .travis.yml

#创建一个文件夹.travis
mkdir .travis
```

生成一个 ssh 密钥对（不要嫌麻烦直接把你机器上的秘钥拿去用了，太危险）：

```
cd 博客根目录
cd .travis/
# 会生成traivs.key 和travis.key.pub
$ ssh-keygen -f travis.key
```

然后把生成的公钥文件（e.g. travis.key.pub）分别添加到 GitHub Deploy Keys、VPS 上的 ~/.ssh/authorized_keys 中，这样 Travis CI 的机器就可以直接访问这些服务器了。

```
cd 博客根目录
cd .travis/
# 交互式操作，使用 GitHub 账号密码登录
# 如果是私有项目要加个 --pro 参数
$ travis login --auto
# 加密完成后会在当前目录下生成一个 travis.key.enc 文件
# 还会在你的 .travis.yml 文件里自动加上用于解密的 shell 语句
$ travis encrypt-file travis.key -add
```

以上步骤完成后你会得到一个 travis.key.enc

## 编辑 .travis.yml

```
cd 博客根目录
vi .travis.yml
```

这是我的配置文件

```
language: node_js
node_js: stable

# 只监听 source 分支的改动
branches:
  only:
  - source

# 缓存依赖，节省持续集成时间
cache:
  yarn: true
  directories:
    - node_modules
    # - themes

before_install:
# 解密 RSA 私钥并设置为本机 ssh 私钥
- openssl aes-256-cbc -K $encrypted_9aab6d74e2ca_key -iv $encrypted_9aab6d74e2ca_iv 
  -in .travis/travis.key.enc -out ~/.ssh/id_rsa -d
- chmod 600 ~/.ssh/id_rsa
# 修改本机 ssh 配置，防止秘钥认证过程影响自动部署
#- mv -fv .travis/ssh-config ~/.ssh/config #这一步不需要，如果添加了ssh_know_hosts
- git config --global user.name "leadscloud"
- git config --global user.email "sbmzhcn@gmail.com"
# 赋予自动部署脚本可执行权限
- chmod +x .travis/deploy.sh

install:
# 安装 Hexo 及其依赖
- yarn
# 当 Travis 文件缓存不存在时，从 Gitee 私有仓库 clone 主题
#- if [ ! -d "themes/next" ]; then git clone git@github.com:leadscloud/hexo-theme-next.git themes/next; fi

script:
# 生成静态页面
- node_modules/.bin/hexo clean
- node_modules/.bin/hexo generate

after_success:
# 部署到 GitHub Pages 和 VPS
- .travis/deploy.sh

addons:
  ssh_know_hosts:
  - github.com
  - love4026.org
```

`vi .travis/deploy.sh`

```
#!/bin/bash
set -ev
export TZ='Asia/Shanghai'

# 使用 rsync同步到 VPS
rsync -rv --delete -e 'ssh -o stricthostkeychecking=no -p 22' public/ root@182.92.100.67:/home/wwwroot/love4026.org

# 先 clone 再 commit，避免直接 force commit
git clone -b master git@github.com:leadscloud/leadscloud.github.io.git .deploy_git

cd .deploy_git
git checkout master
mv .git/ ../public/
cd ../public

git add .
git commit -m "Site updated: `date +"%Y-%m-%d %H:%M:%S"`"

# 同时 push 一份到自己的服务器上
#git remote add vps git@love4026.org:hexo.git

#git push vps master:master --force --quiet
git push origin master:master --force --quiet
```

## 删除一些文件

```
cd 博客根目录/.travis/
rm travis.key
rm travis.key.pub
```

由于我之前有github pages内容了，我需要把之前的内容与现有的hexo博客内容合并下

```
git init
git remote add origin git@github.com:leadscloud/leadscloud.github.io.git
git fetch origin master:temp
git merge temp
```

编辑下.gitignore 忽略一些文件

```
.DS_Store
Thumbs.db
db.json
*.log
node_modules/
public/
.deploy*/
package-lock.json
wordpress.xml
public/
```

## 最终测试

每次 push 新 commit 到 source 分支后，Travis CI 就会自动帮你构建最新的静态博客，并部署至 Github Pages 和你自己的 VPS 上。

```
git checkout --orphan source
git add .
git commit -m "Travis CI"
git push origin source:source
```

关于 --orphan 请参考 [如何建立一个没有 Parent 的独立 Git branch](https://ihower.tw/blog/archives/5691)
 
## 我的博客项目配置文件

    https://github.com/leadscloud/leadscloud.github.io/tree/source


## 参考链接

[使用 Travis CI 自动部署 Hexo 博客](https://blessing.studio/deploy-hexo-blog-automatically-with-travis-ci/)  
[使用 Travis 自动部署 Hexo 到 Github 与 自己的服务器](https://segmentfault.com/a/1190000009054888)  
[优化Hexo博客 - 压缩 HTML、CSS、JS、IMG 等](https://www.karlzhou.com/articles/compress-minify-hexo/)

