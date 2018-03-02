---
title: Linode VPS 安装 longview
tags:
  - linode
  - longview
id: 313697
categories:
  - Linux
date: 2014-01-13 05:08:04
---

安装教程可以参考官方的说明，你可以使用它提供的自动安装，我试了下没有成功，所以改为手工安装。按照它说的做一般就没有问题的，中间有可能会出现一点问题，仔细看文档就行了。
https://library.linode.com/longview#sph_installing-the-client

以 Fedora and CentOS 为例子。
1、首先通过ssh登陆你的VPS
2、创建一个文件，通过以下命令，如果是root用户无需sudo 命令。
sudo nano /etc/yum.repos.d/longview.repo
3、把以下内容粘贴到 longview.repo 文件中，你可以使用vi编辑器，也可以使用nano编辑器
[longview]
name=Longview Repo
baseurl=https://yum-longview.linode.com/DIST/REV/noarch/
enabled=1
gpgcheck=1

这里需要注意的就是baseurl=后面的网址，不能随便填，要根据你的系统选择合适的文件，比如centos 6 以上版本的，是 https://yum-longview.linode.com/centos/6/noarch/repodata/
具体的你可以打开 https://yum-longview.linode.com/ 根据里面的内容，寻找相应的目录。

查看系统版本可以通过 cat /etc/redhat-release

4、这一步就是保存你的文件了。nono 使用 Control-X, 然后输入 Y. vi 就使用:wq

下面的就没什么问题，你可以直接按照官方的提示操作

1.  使用以下命令下载linode.key文件到你的系统
<pre>sudo wget https://yum-longview.linode.com/linode.key</pre>

2.  使用以下命令导入key文件
<pre>sudo rpm --import linode.key</pre>

3.  创建存入api的目录
<pre>sudo mkdir -p /etc/linode/</pre>

4.  创建longview.key文件来保存你的api key。api在下面会告诉你怎么得到。
<pre>sudo nano /etc/linode/longview.key</pre>

5.  想得到api key得先登陆 [Linode Manager](https://manager.linode.com/).
6.  选择一个**Longview** .
7.  单击 **Add Client**. 然后出提示以下界面[![Manually adding a system to Linode Longview.](https://library.linode.com/assets/1383-lv_install.png)](https://library.linode.com/assets/1383-lv_install.png)
8.  点击 **go back** 按键返回到 Linode 管理面板.
9.  单击 **i** 按键, 图示如下.[![Manually adding a system to Linode Longview.](https://library.linode.com/assets/1391-lv_overview_swap_i_crop.png)](https://library.linode.com/assets/1391-lv_overview_swap_i_crop.png)
10.  复制 API key, 图标如下.[![Manually adding a system to Linode Longview.](https://library.linode.com/assets/1379-lv_api_sm.png)](https://library.linode.com/assets/1380-lv_api.png)
11.  再返回到终端命令界面, 向 <tt>longview.key</tt> 文件中粘贴你刚复制的API key.
12.  然后保存，通过命令 **Control-X**, 再按 **Y**.
13.  通过键入以下命令安装longview:
<pre>sudo yum install -y linode-longview</pre>
Congratulations! The Longview client is now installed on your Fedora or CentOS system.

如果不出问题，就可以成功安装上了。

安装完之后有一个系统配置。很简单创建一个数据库。然后把数据库的用户名和密码写入_/etc/linode/longview.d/MySQL.conf，然后再重启longview_
<pre>service longview restart</pre>

## [Manual Configuration (All Distributions)](https://library.linode.com/longview/longview-for-mysql#sph_id7)

To enable the MySQL Longview app manually, follow these steps on your Linode via SSH:

1.  Create a new MySQL user with minimal privileges for Longview. Run the following queries on your database as the root MySQL user to create the new user:
<pre>CREATE USER 'linode-longview'@'localhost' IDENTIFIED BY '***************';
flush privileges;</pre>

2.  Edit <tt>/etc/linode/longview.d/MySQL.conf</tt> to include the same username and password you just added. It should look like the following:**File:**_/etc/linode/longview.d/MySQL.conf_
<div>
<pre>#username root
#password example_password
username linode-longview
password ***************</pre>
</div>
3.  Restart Longview:
<pre>service longview restart</pre>

4.  Refresh the Longview MySQL tab in the Linode Manager.
You should now be able to see Longview data for MySQL. If that's not the case, proceed to the [Troubleshooting](https://library.linode.com/longview/longview-for-mysql#sph_id3) section at the end of this article.

安装成功后，如果后台提示你的时间有问题，按以下操作安装ntp时间同步服务：
<pre class="lang:sh decode:true">yum install ntp
service ntpd start
chkconfig ntpd on</pre>

关于lnmp的一些问题

因为我服务器使用的是lnmp.org上的 lnmp。 有些小问题需要解决，一个就是 apache状态获取不了，因为显示403.
解决办法可以看这个。
http://bbs.vpser.net/thread-2858-1-6.html
如果没有安装lynx 选安装它

<pre class="lang:default decode:true " >yum install lynx -y</pre> 

然后修改 vi /usr/local/apache/conf/extra/httpd-info.conf 把

<pre class="lang:default decode:true " >&lt;Location /server-status&gt;
    SetHandler server-status
    Order deny,allow
    Deny from all
    Allow from .example.com
&lt;/Location&gt;</pre> 
改为

<pre class="lang:default decode:true " >&lt;Location /server-status&gt;
    SetHandler server-status
    Order deny,allow
    Deny from all
    Allow from 127.0.0.1
&lt;/Location&gt;</pre> 
然后重启apache

<pre class="lang:default decode:true " >service httpd restart</pre> 

以上可以解决apache问题。
还有一个问题就是nginx状态获取不到。
修改 longview的一些配置即可， vi /etc/linode/longview.d/Nginx.conf 
把里面的nginx_status，改为 status即可。
然后重启你的longview.