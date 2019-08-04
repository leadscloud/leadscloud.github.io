#!/bin/bash
set -ev
export TZ='Asia/Shanghai'

# 使用 rsync同步到 VPS
# rsync -rv --delete -e 'ssh -o stricthostkeychecking=no -p 22' public/ root@182.92.100.67:/home/wwwroot/love4026.org
# rsync -rv --delete -e 'ssh -o stricthostkeychecking=no -p 22' public/ root@45.55.78.23:/home/wwwroot/love4026.org

# 先 clone 再 commit，避免直接 force commit
git clone -b master git@github.com:leadscloud/leadscloud.github.io.git .deploy_git

cd .deploy_git
git checkout master
mv .git/ ../public/
cd ../public

git add .
git commit -m "Site updated: `date +"%Y-%m-%d %H:%M:%S"`"

# 同时 push 一份到自己的服务器上
#git remote add vps git@love4026.org:hexo.git

#git push vps master:master --force --quiet
git push origin master:master --force --quiet

# 主动提交到baidu
curl -H 'Content-Type:text/plain' --data-binary @baidu_urls.txt "http://data.zz.baidu.com/urls?site=www.love4026.org&token=${baidu_submit_token}" -v

wget --quiet --post-file='baidu_urls.txt' --output-document - 'http://data.zz.baidu.com/urls?site=www.love4026.org&token=${baidu_submit_token}'
