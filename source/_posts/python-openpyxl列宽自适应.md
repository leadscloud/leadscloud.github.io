---
title: python-openpyxl列宽自适应
id: 313773
categories:
  - 个人日志
date: 2014-03-15 13:04:36
tags:
---

使用此命令可以设置列宽：

 worksheet.column_dimensions['A'].width = 25

则A列的宽度为25

<pre class="lang:default decode:true " >column_widths = []
for row in data:
    for i, cell in enumerate(row):
        if len(column_widths) &gt; i:
            if len(cell) &gt; column_widths[i]:
                column_widths[i] = len(cell)
        else:
            column_widths += [len(cell)]

for i, column_width in enumerate(column_widths):
    worksheet.column_dimensions[get_column_letter(i+1)].width = column_width</pre> 

来源： [Python openpyxl column width size adjust](http://stackoverflow.com/questions/13197574/python-openpyxl-column-width-size-adjust)