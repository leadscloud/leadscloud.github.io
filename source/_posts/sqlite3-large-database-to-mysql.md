---
title: sqlite3数据库转换为mysql数据库
id: 20190919
categories:
  - 技术
date: 2019-09-19 09:01:00
tags: sqlite3
---

## 安装screen

`yum install -y screen`

### 创建一个新的窗口

`screen -S sqlite`

## 创建sqlite3-to-mysql.py

由于sqlite3导出后的sql语句与mysql的sql语句还是有较大区别的，所以我们需要一个脚本处理一下。

```python
#! /usr/bin/env python
import re
import fileinput
from optparse import OptionParser
import sys


IGNOREDPREFIXES = [
    'PRAGMA',
    'BEGIN TRANSACTION;',
    'COMMIT;',
    'DELETE FROM sqlite_sequence;',
    'INSERT INTO "sqlite_sequence"',
]


def _replace(line):
    if any(line.lower().startswith(prefix.lower()) for prefix in IGNOREDPREFIXES):
        return

    line = re.sub("AUTOINCREMENT", "AUTO_INCREMENT", line, flags=re.IGNORECASE)
    line = re.sub("boolean", "TINYINT(1)", line, flags=re.IGNORECASE)
    line = re.sub("boolean DEFAULT 't'", "TINYINT(1) DEFAULT 1", line, flags=re.IGNORECASE)
    line = re.sub("boolean DEFAULT 'f'", "TINYINT(1) DEFAULT 0", line, flags=re.IGNORECASE)
    line = re.sub("DEFAULT 't'", "DEFAULT 1", line, flags=re.IGNORECASE)
    line = re.sub("DEFAULT 'f'", "DEFAULT 0", line, flags=re.IGNORECASE)
    # line = re.sub(",'t'", ",1", line, flags=re.IGNORECASE)    
    # line = re.sub(",'f'", ",0", line, flags=re.IGNORECASE)
    line = re.sub("TINYINT(1) DEFAULT 0 NOT NULL", "TINYINT(1) NOT NULL DEFAULT 0", line, flags=re.IGNORECASE)
    line = re.sub("TINYINT(1) DEFAULT 1 NOT NULL", "TINYINT(1) NOT NULL DEFAULT 1", line, flags=re.IGNORECASE)
    line = re.sub("varchar ", "varchar(255) ", line, flags=re.IGNORECASE)
    line = re.sub("varchar,", "varchar(255),", line, flags=re.IGNORECASE)
    line = re.sub("varchar\)", "varchar(255))", line, flags=re.IGNORECASE)
    return line


def _backticks(line, in_string):
    """Replace double quotes by backticks outside (multiline) strings

    >>> _backticks('''INSERT INTO "table" VALUES ('"string"');''', False)
    ('INSERT INTO `table` VALUES (\\'"string"\\');', False)

    >>> _backticks('''INSERT INTO "table" VALUES ('"Heading''', False)
    ('INSERT INTO `table` VALUES (\\'"Heading', True)

    >>> _backticks('''* "text":http://link.com''', True)
    ('* "text":http://link.com', True)

    >>> _backticks(" ');", True)
    (" ');", False)

    """
    new = ''
    for c in line:
        if not in_string:
            if c == "'":
                in_string = True
            elif c == '"':
                new = new + '`'
                continue
        elif c == "'":
            in_string = False
        new = new + c
    return new, in_string


def _process(opts, lines):
    if opts.database:
        yield '''\
drop database if exists {d};
create database {d} character set utf8;
grant all on {d}.* to {u}@'%' identified by '{p}';
use {d};\n'''.format(d=opts.database, u=opts.username, p=opts.password)
    yield "SET sql_mode='NO_BACKSLASH_ESCAPES';\n"

    in_string = False
    for line in lines:
        if not in_string:
            line = _replace(line)
            if line is None:
                continue
        line, in_string = _backticks(line, in_string)
        yield line


def main():
    op = OptionParser()
    op.add_option('-d', '--database')
    op.add_option('-u', '--username')
    op.add_option('-p', '--password')
    opts, args = op.parse_args()

    lines = (l for l in fileinput.input(args))
    for line in _process(opts, lines):
        # sys.stdout.write(line)
        print line,


if __name__ == "__main__":
    main()

```

## 执行脚本

```
sqlite3 test.db .dump | python sqlite3-to-mysql.py -u m_user -p m_password -d m_database | mysql -u root -p --default-character-set=utf8
```

对于比较大的数据库，会耗时较长，所以一定要放在screen下执行，防止意外断开连接。

## screen的使用

如果意外断开ssh链接，怎么重新登入？

```
screen -ls
```
会显示会话列表


重新连接会话id
```
screen -r 12865
```


## 附：mysql数据库导出导入

导出

```
mysqldump -u user -p database | gzip > database.sql.gz
```

导入

```
gunzip < database.sql.gz | mysql -u user -p database
```

## 参考链接

http://www.redmine.org/boards/2/topics/12793
https://www.cnblogs.com/mchina/archive/2013/01/30/2880680.html