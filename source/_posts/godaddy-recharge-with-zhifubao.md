---
title: GoDaddy使用支付宝跨境汇款进行预充值
tags:
  - godaddy
id: 20191028
categories:
  - 技术
date: 2019-10-28 13:14:00
---

Godaddy是流行的域名注册，虽然有些垃圾，但注册域名有时还是可以的。它有API可使用，以购买域名，大部分域名还是可以购买的。

但如果你账户中没有余额，是无法使用API购买的，这篇文章介绍如何向Godaddy中预充值。

> 注意：使用Godaddy的API买域名是无法使用优惠券的。
>
> API有时也会买域名失败，虽然大部分情况下会自动退款，但也有不退款的情况发生，对于我来说.co.za的域名发生过这种情况，你需要特别提醒godaddy给你处理。
>
> 这种充值方式是没有发票的，在Godaddy中账户中，你无法找到对应的billing记录。只会在Good As Gold中显示一个收据编号，然后一个充值提示，不会和买域名时一样，会生成一个详情的订单记录。

## 向GoDaddy中预存款，以使用API注册域名

Godaddy中有一个Good As Gold付款方式。在 账户设定，付款方式中可以看到。 

https://account.godaddy.com/payment-methods 

![image-20191028141636275](/wp-content/uploads/2019/image-20191028141636275.png)

你可以参考以下链接阅读Godaddy的帮助，通过向godaddy的银行账号转账，以达到预存款目的。这个账号，在下面的支付宝中会使用。

  https://sg.godaddy.com/zh/help/good-as-gold-727 

![image-20191028140809338](/wp-content/uploads/2019/image-20191028140809338.png)

**收款银行名称**：JPMorganChase Bank
**银行地址：**270 Park Avenue, New York, NY 10017
**账户名称**：GoDaddy.com, LLC
**账号**：580706823
**汇款路径号码**：021000021
**ACH 汇款路径号码**：124001545
**Swift 代码**：CHASUS33
**参考：客户编号** 



## 支付宝付款流程图

先在支付宝里搜索**上银汇款**，打开上银汇款，如下界面，最低100美元起步。

手续费是每次50，无论你汇多少，它都是按次收费的，所以单次可以多汇一点，会省点手续费。

> 支付宝美元汇款，不支持信用卡，只能是银行卡或余额宝。

![image-20191028135048071](/wp-content/uploads/2019/image-20191028135048071.png)

我已经添加了联系人，如果你是第一次汇款，需要按godaddy的帮助说明，添加godaddy的银行账号

https://sg.godaddy.com/zh/help/good-as-gold-727 

![image-20191028135201586](/wp-content/uploads/2019/image-20191028135201586.png)

选择**计算机网络服务费**

![image-20191028135210797](/wp-content/uploads/2019/image-20191028135210797.png)

下面这一项，需要手动填写，并且要注意不要弄错，否则会失败。

交易对方名称：GoDaddy.com, LLC

具体购汇项目：域名购买

附言：这个是你的Godaddy账号 (Customer id)

登陆你的Godaddy账号，可以点击右上角你的头像，会看到Customer id

附言，只需要填写customer id，不要有其它的任何字符，否则会失败。

![image-20191028135836822](/wp-content/uploads/2019/image-20191028135836822.png)

![image-20191028135219882](/wp-content/uploads/2019/image-20191028135219882.png)

![image-20191028135227517](/wp-content/uploads/2019/image-20191028135227517.png)

![image-20191028135236330](/wp-content/uploads/2019/image-20191028135236330.png)

![image-20191028135245963](/wp-content/uploads/2019/image-20191028135245963.png)

![image-20191028135254666](/wp-content/uploads/2019/image-20191028135254666.png)

![image-20191028135302802](/wp-content/uploads/2019/image-20191028135302802.png)

第一次充值后，需要5-7个工作日，但也可能2-3天就可以。

之后再充值2-3天就会到账，但一般不会超过7个工作日。