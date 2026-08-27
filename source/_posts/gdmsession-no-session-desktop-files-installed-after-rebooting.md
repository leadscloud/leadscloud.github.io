---
title: GdmSession no session desktop files installed after rebooting
tags:
  - Ubuntu
id: 20250506
categories:
  - Linux
date: 2025-05-06 18:32:16
---


`gdm3[1382]: Gdm: GdmSession: no session desktop files installed, aborting...`


先说解决方案


```
sudo apt install ubuntu-session
sudo systemctl restart gdm.service
```

之后就能重新显示GUI界面登录了。


某重启ubuntu后，突然就卡到登录界面，`Failed to start gdm.servide - GNOME Display manager`

开机进入recovery模式 -> 选择root Drop to root shell prompt选项 -> 然后回车，系统会提示你输入root用户的密码

查看系统最近一次的启动日志 

```
journalctl -b -1
```


`sudo apt install --reinstall ubuntu-desktop` 无法解决
`apt autoremove --purge snapd` 也无法解决



最后找在这找到正确答案： https://askubuntu.com/questions/1515996/gdmsession-no-session-desktop-files-installed-after-rebooting




`journalctl --unit gdm.service --no-pager` 会显示具体错误内容

```
gdm-launch-environment][1640]: pam_unix(gdm-launch-environment:session): session opened for user gdm(uid=120) by (uid=0)
gdm3[1632]: Gdm: GdmSession: no session desktop files installed, aborting...
systemd[1]: gdm.service: Main process exited, code=dumped, status=5/TRAP
systemd[1]: gdm.service: Failed with result 'core-dump'.
systemd[1]: gdm.service: Triggering OnFailure= dependencies.
systemd[1]: gdm.service: Scheduled restart job, restart counter is at 4.
systemd[1]: Starting gdm.service - GNOME Display Manager...
systemd[1]: Started gdm.service - GNOME Display Manager.
gdm3[1713]: accountsservice: ActUserManager: user (null) has no username (uid: -1)
gdm-launch-environment][1719]: pam_unix(gdm-launch-environment:session): session opened for user gdm(uid=120) by (uid=0)
gdm3[1713]: Gdm: GdmSession: no session desktop files installed, aborting...
systemd[1]: gdm.service: Main process exited, code=dumped, status=5/TRAP
systemd[1]: gdm.service: Failed with result 'core-dump'.
systemd[1]: gdm.service: Triggering OnFailure= dependencies.
systemd[1]: gdm.service: Scheduled restart job, restart counter is at 5.
systemd[1]: gdm.service: Start request repeated too quickly.
systemd[1]: gdm.service: Failed with result 'core-dump'.
systemd[1]: Failed to start gdm.service - GNOME Display Manager.
systemd[1]: gdm.service: Triggering OnFailure= dependencies.
systemd[1]: Starting gdm.service - GNOME Display Manager...
systemd[1]: Started gdm.service - GNOME Display Manager.
gdm3[28263]: accountsservice: ActUserManager: user (null) has no username (uid: -1)
gdm-launch-environment][28269]: pam_unix(gdm-launch-environment:session): session opened for user gdm(uid=120) by (uid=0)
gdm-password][28703]: gkr-pam: unable to locate daemon control file
gdm-password][28703]: gkr-pam: stashed password to try later in open session
gdm-password][28703]: pam_unix(gdm-password:session): session opened for user zhanglei(uid=1000) by zhanglei(uid=0)
gdm-password][28703]: gkr-pam: unlocked login keyring
gdm3[28263]: Gdm: on_display_added: assertion 'GDM_IS_REMOTE_DISPLAY (display)' failed
gdm3[28263]: Gdm: Child process -28274 was already dead.
gdm3[28263]: Gdm: on_display_removed: assertion 'GDM_IS_REMOTE_DISPLAY (display)' failed

```