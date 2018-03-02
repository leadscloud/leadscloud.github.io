---
title: python openpyxl列宽自适应
id: 313773
categories:
  - 技术
date: 2014-03-15 13:04:36
tags: [python, openpyxl]
---

使用此命令可以设置列宽：

```
 worksheet.column_dimensions['A'].width = 25
```

则A列的宽度为25

```
column_widths = []
for row in data:
    for i, cell in enumerate(row):
        if len(column_widths) > i:
            if len(cell) > column_widths[i]:
                column_widths[i] = len(cell)
        else:
            column_widths += [len(cell)]

for i, column_width in enumerate(column_widths):
    worksheet.column_dimensions[get_column_letter(i+1)].width = column_width

```

来源： [Python openpyxl column width size adjust](http://stackoverflow.com/questions/13197574/python-openpyxl-column-width-size-adjust)