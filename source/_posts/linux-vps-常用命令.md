---
title: Linux VPS 常用命令
id: 313312
categories:
  - Linux
date: 2012-04-20 08:15:23
tags: vps
---

 


    uname -a               # 查看内核/操作系统/CPU信息
    head -n 1 /etc/issue   # 查看操作系统版本
    hostname               # 查看计算机名
    du -sh <目录名>        # 查看指定目录的大小
    df -h                  # 查看各分区使用情况
    rpm -qa                # 查看所有安装的软件包
    usermod -a -G apache centos  #把用户centos 添加到apache组里
    chown -R :apache /home/wwwroot/  #设置wwwroot的所有用户组为apache
    chown -R apache /home/wwwroot/   #设置wwwroot的所有者为apache
    chmod -R g+rw /var/www       #设置网站根目录的权限为用户组有读写权限
    chmod XXX <文件名>        # r 4  w 2 x1  加一起就是7
    crontab -e    #添加定时任务
    rm  -rf  <文件或文件夹>   #强制删除所有文件或文件夹
    reboot      #重启系统
    mkdir      #创建文件夹
