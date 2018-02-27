---
title: exclude-internal-traffic-from-google-analytics-reports
tags:
  - Google Analytics
id: 313114
categories:
  - 前端设计
date: 2011-03-10 06:06:10
---

如果您要在报告中排除内部点击量，可以过滤特定的 IP 地址或 IP 地址段。 也可以使用 Cookie 来过滤特定用户的访问次数。 我们将在下面说明如何操作。    
要按 IP 地址来进行排除，请执行以下步骤：

1.  在&quot;Analytics（分析）设置&quot;页上点击**过滤器管理器**2.  为该过滤器输入**过滤器名称**3.  从**过滤器类型**下拉列表中，选择**排除来自某 IP 地址的所有点击量**4.  **IP 地址**字段会自动显示一个示例 IP 地址。 请输入正确的值。 输入 IP 地址时，请务必使用[正则表达式](http://www.google.com/support/googleanalytics/bin/answer.py?answer=55582&amp;hl=zh_CN)。 例如，如果要过滤的 IP 地址是：  

176.168.1.1    
那么 **IP 地址**值就是：     
176\.168\.1\.1     
您也可以输入 IP 地址段， 例如：     
**地址段**： 176.168.1.1-25 和 10.0.0.1-14     
**IP 地址值**： ^176\.168\.1\.([1-9]|1[0-9]|2[0-5])$|^10\.0\.0\.([1-9]|1[0-4])$     
如果在查找 IP 地址段的正确表达式时需要帮助，请使用我们的工具：     
[http://www.google.com/support/googleanalytics/bin/answer.py?answer=55572 &amp;hl=zh_CN](http://www.google.com/support/googleanalytics/bin/answer.py?answer=55572)

1.  在**可用网站配置文件**框中选择要应用此过滤器的配置文件2.  点击**添加**将选中的配置文件移动到**选定的网站配置文件**列表中3.  点击**完成**保存此过滤器，或点击**取消**返回上一页  

**通过 Cookie 排除点击量**

**注：** 这是之前方法的一个高级替代方式。

要排除来自动态 IP 地址的点击量，您可以使用 JavaScript 函数在内部计算机上设置 Cookie。 之后，便可以滤除具有此 Cookie 的所有访问者，使其不出现在 Google Analytics（分析）报告中。

通过 Cookie 排除点击量的具体方法如下：    
1\. 在您的域名上创建包含以下代码的**新页面**，注意不是把你网站上的所有页面都加上这个代码，而是仅仅新建一个页面，用这个页面在你电脑上创建cookies而已：     
&#160; &lt;body onLoad=&quot;javascript:pageTracker._setVar('test_value');&quot;&gt;     
（请注意，该代码与网站每一页的 Google Analytics（分析）跟踪代码放在一起。）     
2\. 要设置 Cookie，请从您想在报告中排除的所有计算机上访问新创建的页面。     
3\. 创建&quot;排除&quot;过滤器以便删除来自具有此 Cookie 的访问者的数据。 请按照 [http://www.google.com/support/googleanalytics/bin/answer.py?answer=55494&amp;hl=zh_CN](http://www.google.com/support/googleanalytics/bin/answer.py?answer=55494&amp;hl=zh_CN)     
上的说明操作 使用下列设置创建过滤器：     
过滤器类型： 自定义过滤器 &gt; 排除     
过滤字段： 用户定义     
过滤模式： test_value     
区分大小写： 否