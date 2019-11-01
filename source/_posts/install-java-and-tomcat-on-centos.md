---
title: 在centos7上安装java和tomcat
id: 20191029
categories:
  - 技术
date: 2019-10-29 16:36:07
tags: linux
---

## 安装Java11

```shell
yum install java-11-openjdk -y
```

```shell
java -version

openjdk version "11.0.5" 2019-10-15 LTS
OpenJDK Runtime Environment 18.9 (build 11.0.5+10-LTS)
OpenJDK 64-Bit Server VM 18.9 (build 11.0.5+10-LTS, mixed mode, sharing)
```

## 安装Tomcat

```shell
wget http://mirrors.tuna.tsinghua.edu.cn/apache/tomcat/tomcat-9/v9.0.27/bin/apache-tomcat-9.0.27.tar.gz
tar xzf apache-tomcat-9.0.27.tar.gz
mv apache-tomcat-9.0.27 /usr/local/tomcat9

```

### 启动tomcat

```
cd /usr/local/tomcat9/
./bin/startup.sh
```

**输出示例**

```
Using CATALINA_BASE:   /usr/local/tomcat9
Using CATALINA_HOME:   /usr/local/tomcat9
Using CATALINA_TMPDIR: /usr/local/tomcat9/temp
Using JRE_HOME:        /usr
Using CLASSPATH:       /usr/local/tomcat9/bin/bootstrap.jar:/usr/local/tomcat9/bin/tomcat-juli.jar
Tomcat started.
```

最后浏览器中输入 `http://localhost:8080 ` 即可访问tomcat服务器了。

### war文件部署

#### 打war包

项目名称为`mygoodcache`

`eclipse`中项目上右键 `export-->war file -->Browse(指定打完的包存放路径)-->finish mygood.war`包已经完成

#### 部署到tomcat

- 找到tomcat的安装路径（如：`/usr/local/tomcat9/`）
- webapps文件夹中如果有war包及**文件夹**都删除
- `/usr/local/tomcat9/webapps` 中上传新的war包
- `/usr/local/tomcat9/bin/startup.bat` 启动`tomcat`

### 安装lnmp

https://lnmp.org/install.html

### 创建数据库

`CREATE DATABASE crawler_pool CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;`

### 导入数据库

`mysql -p crawler_pool < mygood.sql`