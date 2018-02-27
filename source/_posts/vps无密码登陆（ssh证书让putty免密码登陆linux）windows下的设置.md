---
title: vps无密码登陆（ssh证书让putty免密码登陆linux）windows下的设置
tags:
  - Putty
id: 313714
categories:
  - Linux
date: 2014-02-21 12:16:20
---

SSH证书让Putty免密码登陆Linux的方法，此方法是针对windows端下的。
1.第一步，下载putty，建议下载这个中文版。http://code.google.com/p/puttycn/
主要是下载到puttygen.exe

2、用PuTTY SSH 密钥生成工具puttygen.exe生成密钥
生成的密钥类型和位数按照默认的就行，SSH-2 RSA，2048位
生成密钥时你需要在空白区域移动鼠标,以便产生随机数据
点击保存私钥(可以不设置密码保护)

保存下你的私钥到文件中（ppk后缀的），这个文件很重要，一定要放好，公钥文件是放到linux端的，你也可以保存下，等会需要生成的公钥。
密码不需要填写。

3、SSH密码方式登入远端Linux服务器/VPS,创建.ssh/authorized_keys.
vim ~/.ssh/authorized_keys
将puttygen.exe生成的公钥内容粘贴至~/.ssh/authorized_keys.
比如我生成的内容为：
ssh-rsa AAAAB3NzaC1yc2EAAAABJQAAAQsdfEA0TkpyA25QTupNR/CALYVjDmpgPWE2oiRzMs8CLIX8IAiTbYPsdfooT7cdGsdf75ipTCV8+fV8Fdfyq5SfkTqA8aninNjDfw2y5fkaPwvoQhK3qFqxQkBBO2tgj4K90pXAdlub2OPsd135dcj9b2bSvv9KssdfdggfhNsV/NkDAojpYmK1YWhZsUj4EuVdvvgeIFIAYo9OPzFCtARctCEDLVmsI8/M9UOTMPdvOkr7KAzvDcQ7dZwQWWDDeUAQtN+NBdOj5bn8YasXS4X01cU4krBOs5nUrnsxD+kciz0kROLiAn1Hv4G1osd8pvXTRup5w== rsa-key-20140221

注:公钥内容就在显示的公钥(P)由OpenSSH认可: 这行字符下面.
至于为什么文件名是authorized_keys,可以在/etc/ssh/sshd_config中找到下面两行
#PubkeyAuthentication yes
#AuthorizedKeysFile .ssh/authorized_keys

4.用SSH证书登陆你的Linux服务器/VPS
Putty→会话:将服务器IP填好
Putty→连接→数据:填好自动登陆用户名
Putty→连接→SSH→认证:选择认证私钥文件
回到Putty→会话:保存的会话,填个名称保存下吧,下次直接双击名称就可以登录了,赶紧登录吧.

选择你的私钥文件即可，上一步要保存你的私钥文件的，这个文件一定要保存好。

5.为了安全你需要取消SSH的密码认证方式.（可选操作，添加后你将不能使用密码方式登陆）
vim /etc/ssh/sshd_config
添加下面这行
PasswordAuthentication no
重启SSH服务
service sshd restart