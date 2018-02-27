---
title: linode被注入恶意软件解决办法
id: 313709
categories:
  - Linux
date: 2014-02-14 02:49:56
tags:
---

今天接到linode通知，一个VPS中有恶意软件，让我删除，不过VPS无法开机了，以前也遇到过一次， 这次又遇到了，看来只有把VPS直接重新创建才行，linode也建议如此。
Hello,

You may want to audit the following log files and writable directories: 

- "/var/log/auth.log": You may have fallen victim to a SSH brute force attack.
- "last": You can cross reference recent account logins with the brute force attempts in "/var/log/auth.log".
- /tmp: This directory is often used by attackers to store their files in.
- Web server logs: You may have installed a vulnerable script or web application. 
- "ps aux": Check for foreign processes.

If you do find that your system has been compromised, I'd strongly suggest completely redeploying your Linode as it is often very difficult to determine the full scope of an attack. If downtime is a concern to you, the following guide will assist you with safely recovering your data and redeploying your Linode with minimal downtime: 

- http://library.linode.com/troubleshooting/compromise-recovery 

If you do not want to spin up a new Linode as advised in the above guide, you can simply deploy a new distribution and mount your old disk images within it to copy your data over. You will first need to free up some space to deploy the new distribution. You can do this by resizing your existing disk image: 

- http://library.linode.com/linode-platform/manager/managing-disk-images#resize_a_disk_image

You can then deploy your new distribution and attach your old disk images to it: 

- Select the "Deploy a Linux Distribution" link on your dashboard. 
- Choose your desired distribution, fill in the the required values, and then click on "Deploy". 
- Return to the dashboard and select your new configuration profile. 
- Attach your old disk image to the drive setup of your new deployment. 
- Boot into your new deployment and mount your old disk image. 
- Copy your data. 

Once you have redeployed your Linode, I'd also recommend implementing some of the security measures advised in our "Security Basics" guide to minimize the risks of a security breach in the future: 

- http://library.linode.com/using-linux/security-basics

I hope that you have found this information helpful. Please keep us updated on your progress and findings. 

Thanks,
Mark
Linode Support

=====
如果你不想rebuild，建议以下做法，可以删除掉恶意软件，然后正常重新启动。主要是通过lish连接VPS，如果你的VPS确定无法启动了，首先要做的是Rescue and Rebuild
具体操作在这儿：https://library.linode.com/rescue-and-rebuild
然后再通过lish连接你的VPS，进入VPS后，删除恶意软件即可。

连接到VPS后，先mount -o barrier=0 /dev/xvda
接着 cd /media/xvda
使用以下命令删除恶意软件
比如我的 find /media/xvda/home/ -name "*.rar" | xargs rm -rf

把这些恶意办的删掉，VPS便可以重新启动了。