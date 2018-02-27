---
title: mysql中修改密码及访问权限设置
tags:
  - MySQL
id: 313250
categories:
  - Linux
date: 2012-01-09 02:50:14
---

处于安全方面的考虑，需要为每一用户赋于对不同数据库的访问限制，以满足不同用户的要求。下面就分别讨论，供大家参考。

一、MySQL修改密码方法总结
首先要说明一点的是：一般情况下，修改MySQL密码是需要有mysql里的root权限的，这样一般用户是无法更改密码的，除非请求管理员帮助修改。

方法一

使用phpMyAdmin (图形化管理MySql数据库的工具)，这是最简单的，直接用SQL语句修改mysql数据库库的user表，不过别忘了使用PASSWORD函数，插入 用户用Insert命令，修改用户用Update命令，删除用Delete命令。在本节后面有数据表user字段的详细介绍。

方法二

使用mysqladmin。输入

mysqladmin -u root -p oldpassword newpasswd

执行这个命令后，需要输入root的原密码，这样root的密码将改为newpasswd。同样，把命令里的root改为你的用户名，你就可以改你 自己的密码了。 当然如果你的mysqladmin连接不上mysql server，或者你没有办法执行mysqladmin，那么这种方法就是无效的，而且mysqladmin无法把密码清空。

下面的方法都在mysql提示符下使用，且必须有mysql的root权限：

方法三

mysql”gt; INSERT INTO mysql.user (Host,User,Password) valueS (‘%’,'system’, PASSWORD(‘manager’));
mysql”gt; FLUSH PRIVILEGES

确切地说这是在增加一个用户，用户名为system，密码为manager。注意要使用PASSWORD函数，然后还要使用FLUSH PRIVILEGES来执行确认。

方法四

和方法三一样，只是使用了REPLACE语句

mysql”gt; REPLACE INTO mysql.user (Host,User,Password)
valueS(‘%’,'system’,PASSWORD(‘manager’));
mysql”gt; FLUSH PRIVILEGES

方法五

使用SET PASSWORD语句

mysql”gt; SET PASSWORD FOR system@”quot;%”quot; = PASSWORD(‘manager’);

你也必须使用PASSWORD()函数，但是不需要使用FLUSH PRIVILEGES来执行确认。

方法六

使用GRANT … IDENTIFIED BY语句，来进行授权。

mysql”gt; GRANT USAGE ON *.* TO system@”quot;%”quot; IDENTIFIED BY ‘manager’;

这里PASSWORD()函数是不必要的，也不需要使用FLUSH PRIVILEGES来执行确认。

注：PASSWORD()函数作用是为口令字加密，在程序中MySql自动解释。

二、MySql中访问限制的设置方法
我们采用两种方法来设置用户。

进入到Mysql执行目录下（通常是c:\mysql\bin）。输入mysqld-shareware.exe，输入mysql –user=root mysql ,不然不能添加新用户。进入到mysql”gt;提示符下进行操作。

假设我们要建立一个超级用户，用户名为system，用户口令为manager。

方法一

用Grant 命令授权，输入的代码如下：

mysql”gt;GRANT ALL PRIVILEGES ON *.* TO system@localhost IDENTIFIED BY ‘manager’ WITH GRANT OPTION;

应显示:Query OK, 0 rows affected (0.38 sec)

方法二

对用户的每一项权限进行设置：

mysql”gt;INSERT INTO user valueS(‘localhost’,'system’,PASSWORD(‘manager’), ‘Y’,'Y’,'Y’,'Y’,'Y’,'Y’,'Y’,'Y’,'Y’,'Y’,'Y’,'Y’,'Y’,'Y’);

对于3.22.34版本的MySQL,这里共14个”quot;Y”quot;,其相应的权限如下(按字段顺序排列):

权限 表列名称 相应解释 使用范围
select Select_priv 只有在真正从一个表中检索时才需要select权限 表
insert Insert_priv 允许您把新行插入到一个存在的表中 表
update Update_priv 允许你用新值更新现存表中行的列 表
delete Delete_priv 允许你删除满足条件的行 表
create Create_priv 允许你创建新的数据库和表 数据库、表或索引
drop Drop_priv 抛弃(删除)现存的数据库和表 数据库或表
reload Reload_priv 允许您告诉服务器再读入授权表 服务器管理
shutdown Shutdown_priv 可能被滥用(通过终止服务器拒绝为其他用户服务) 服务器管理
process Process_priv 允许您察看当前执行的查询的普通文本,包括设定或改变口令查询 服务器管理
file File_priv 权限可以被滥用在服务器上读取任何可读的文件到数据库表 服务器上的文件存取
grant Grant_priv 允许你把你自己拥有的那些权限授给其他的用户 数据库或表
references References_priv 允许你打开和关闭记录文件 数据库或表
index Index_priv 允许你创建或抛弃(删除)索引 表
alter Alter_priv 允许您改变表格,可以用于通过重新命名表来**权限系统 表

如果创建用户时只有select、insert、update和delete权限,则允许用户只能在一个数据库现有的表上实施操作.

下面就可以创建我们要用到的数据库了,我们直接输入. 例如：我们要创建数据库名为XinXiKu，可用如下代码：

mysql”gt;create database XinXiKu;

应显示:Query OK, 1 row affected (0.00 sec)
---------------------------------------------------

创建普通用户的MySQL账号：（普通用户只能操作他自己的那个数据库，不能具有全局权限）

（1）用root账户登入phpmyadmin，点击“数据库”–输入普通用户数据库名–“整理”那里勾选“utf8_general_ci”–点击“创建”
（2）点击刚才创建的那个数据库–点击“权限”–点击“ 添加新用户”–“用户名”那里输入普通用户的用户名–“主机”那里选择“本地”–“密码那里输入用户的密码(下面重新输入一遍)”–点击“执行”