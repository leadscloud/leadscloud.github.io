#!/bin/bash

fordidden_url='http://bbs.shibang.cn/forbidden-word/output.php?type=txt'
for i in $(wget -O- -q $fordidden_url);
do
    echo $i;
    # if [[ $i =~ $regex ]]; then
    #echo ${BASH_REMATCH[1]}
    #fi
done