---
title: 忠仕商务通URL参数及其它自定义配置
date: 2017-09-01 12:03:54
tags: 商务通
id: 315020
categories: 技术
---

[忠仕](http://www.zoosnet.net/)的商务通是我们公司一直使用的产品，虽然产品多少年不更新，最近更新了代码适应了移动端也不太友好，但奈何人员已经用习惯了，还是一直用它。每年300元一个席位还是很便宜的。

**它的主要劣势是：**

- 代码不支持异步
- 对移动端支持不好（目前访问50%以上是移动端过来的）
- 服务器在国内，速度方面不太好
- 无法内嵌google统计代码包括无法跟踪事件和转化

如果是做国际业务的，在预算充足的情况下，还是建议使用 https://www.livechatinc.com/

默认的忠仕商务通聊天界面url

```
http://kht.zoosnet.net/LR/Chatpre.aspx?id=KHT57158997&lng=en
```

自定义网址，如果想在其它未验证网页中使用商务，并且希望商务通的来源网址更改为特定的，可以按下面方式使用

```
http://kht.zoosnet.net/LR/Chatpre.aspx?id=KHT57158997&lng=en&r=refer.com&p=baidu.com
```

## url参数说明

```
lng: en # 语言类型
id: KHT57158997 # 站点ID
p: www.lanthy.com # 当前网页的网址，用于向客服人员提供访客轨迹
r: www.google.com # 上一访问网页的网址，用于向客服人员提供访问来源
oname: anan  # 直接和选择的客服进行对话
e: "test" # 对话入口说明，可以不填写，客服在“信息”选项卡里会看到以下内容，支持html代码
```

> 
> 以上的url适合自定义按钮弹出聊天窗口的设置，默认的商务通点击弹出，还是会是默认的，但我们也有办法修改，商务通代码中提供了一个自定义函数 `openZoosUrl_UserDefine` , 我们只要写一个`openZoosUrl_UserDefine`函数 就可以了，下面的是代码就是我修改的，可以修改商务通来源网址。

## 自定义默认的聊天窗口弹出

```javascript
<script>
function openZoosUrl_UserDefine(url, data) {
    // 修改下面的url地址即可
    var p = 'http://www.miningroadheader.com/' + '?p1=' + escape(location.href);
    if (typeof (LR_istate) != 'undefined') {
        LR_istate = 3;
    }
    var lr_url1 = url;
    if (typeof (LR_opentimeout) != 'undefined' && typeof (LR_next_invite_seconds) != 'undefined') LR_next_invite_seconds = 999999;
    if (url == 'sendnote') {
        url = LR_sysurl + 'LR/Chatwin2.aspx?siteid=' + LR_websiteid + '&cid=' + LR_cid + '&sid=' + LR_sid + '&lng=' + LR_lng + '&p=' + escape(location.href) + lr_refer5238();
    } else {
        url = ((LR_userurl0 && typeof (LR_userurl) != 'undefined') ? LR_userurl : (LR_sysurl + 'LR/Chatpre.aspx')) + '?id=' + LR_websiteid + '&cid=' + LR_cid + '&lng=' + LR_lng + '&sid=' + LR_sid + '&p=' + escape(p) + lr_refer5238();
    }
    if (typeof (LR_UserSSL) != 'undefined' && LR_UserSSL && url.charAt(4) == ':') url = url.substring(0, 4) + 's' + url.substring(4, url.length);
    if (!data) {
        if (typeof (LR_explain) != 'undefined' && LR_explain != '') {
            url += '&e=' + escape(escape(LR_explain));
        } else if (typeof (LiveAutoInvite1) != 'undefined') {
            url += '&e=' + escape(escape(LiveAutoInvite1));
        }
    }
    if (typeof (LR_username) != 'undefined') {
        url += '&un=' + escape(LR_username);
    }
    if (typeof (LR_userdata) != 'undefined') {
        url += '&ud=' + escape(LR_userdata);
    }
    if (typeof (LR_ucd) != 'undefined') {
        url += '&ucd=' + escape(LR_ucd);
    }
    url += '&msg=' + escape(LR_msg);
    if (data) url += data;
    url += '&d=' + new Date().getTime();
    if (typeof (LR_imgint) != 'undefined') url += '&imgint=' + LR_imgint;
    if (lr_url1 == 'fchatwin') {
        LR_ClientEnd = 0;
        window.location = url + '&f=1';
        return;
    }
    if (LR_sidexists != 2 && LiveReceptionCode_isonline && lr_url1 != 'bchatwin' && typeof (LR_pm003) != 'undefined' && LR_pm003 == 1) {
        LR_HideInvite();
        LR_istate = 1;
        clickopenmini = 1;
        LR_showminiDiv();
        lrminiMax();
        return;
    }

    var oWindow;
    try {
        if (LR_checkagent('opera|safari|se 2.x')) {
            oWindow = window.open(url);
        } else {
            oWindow = window.open(url, 'LRWIN_' + LR_websiteid, 'toolbar=no,width=760,height=460,resizable=yes,location=no,scrollbars=no,left=' + ((screen.width - 760) / 4) + ',top=' + ((screen.height - 460) / 4));
        }
        if (oWindow == null) {
            LR_ClientEnd = 0;
            window.location = url;
            return;
        }
        oWindow.focus();
    } catch (e) {
        if (oWindow == null) {
            LR_ClientEnd = 0;
            window.location = url;
        }
    }
    return true;
}
</script>
<script src="//kht.zoosnet.net/JS/LsJS.aspx?siteid=KHT57158997&float=1&lng=en"></script>
```

## jQuery下zoosnet代码加载 

如果你使用了jQeury，商务通代码可以这样加载,忠仕的商务通代码应该是上个年代写的，不支持异步

```javascript
<script>
window.onload=function(){
    var t=document.write;
    document.write=function(t){
        $("body").append(t)
    },
    $.getScript("https://kht.zoosnet.net/JS/LsJS.aspx?siteid=KHT57158997&float=1&lng=en",function(){
        setTimeout(function(){document.write=t},3e3)
    })
}
</script>
```
