#!/bin/bash
#
################################################################################
# Bulk add vhost, FTP, MYSQL and Web Application for LNMP/LNMPA by licess
# LNMP is a tool to auto-compile & install Nginx+MySQL+PHP+Apache on Linux
# For more information please visit http://www.lnmp.org/
# 
# Author: Ray Chang <http://www.love4026.org>
# 
# Version: 1.0.7
#
# FTP Service must be pureftpd.
#
# wget -O bulk_vhost.sh https://raw.githubusercontent.com/leadscloud/Tools/master/bulk_vhost.sh --no-check-certificate && chmod u+x bulk_vhost.sh
# 
#
# For more information please visit http://www.love4026.org/
# Code url: https://raw.githubusercontent.com/leadscloud/Tools/master/bulk_vhost.sh
# 
# Install:
#     wget -O bulk_vhost.sh http://leadscloud.github.io/soft/bulk_vhost.sh && chmod u+x bulk_vhost.sh
# 
# Last Updated: 2017-05-12
#
################################################################################
#

# Check if user is root
if [ $(id -u) != "0" ]; then
    echo "Error: You must be root to run this script, use sudo sh $0"
    exit 1
fi

function gethostip {
    hostip="$(ifconfig | grep -A 1 'eth0' | tail -1 | cut -d ':' -f 2 | cut -d ' ' -f 1)"
    if [ ! -n "$hostip" ]; then
        hostip=`hostname -I | grep -o '[0-9]\{1,3\}\.[0-9]\{1,3\}\.[0-9]\{1,3\}\.[0-9]\{1,3\}'`
    fi
    echo $hostip
}

function die {
    echo "ERROR: $1" > /dev/null 1>&2
    exit 1
}

function print_info {
    echo -n -e '\e[1;36m'
    echo -n $1
    echo -e '\e[0m'
}
function print_warn {
    echo -n -e '\e[1;33m'
    echo -n $1
    echo -e '\e[0m'
}
function print_error {
    echo -n -e '\e[1;31m'
    echo -n $1
    echo -e '\e[0m'
}

function install_lnmp_vhost {
    fcgipath="fcgi.conf"
    if [ -f /usr/local/nginx/conf/fastcgi.conf ]; then
        fcgipath="fastcgi.conf"
    elif [ -f /usr/local/nginx/conf/fcgi.conf ]; then
        fcgipath="fcgi.conf"
    fi

    if [ ! -z "$1" ]; then
        domain=$1
        moredomainame=" www.$domain"
        vhostdir="/home/wwwroot/$domain"
    fi

    if [ ! -d /usr/local/nginx/conf/vhost ]; then
        mkdir /usr/local/nginx/conf/vhost
    fi

    if [ ! -f /usr/local/nginx/conf/301.conf ]; then
        cat >>/usr/local/nginx/conf/301.conf<<EOF
#@+ 301 redirect
if ( \$request_uri ~* /index\.(html|htm|php)$ ) {
    rewrite ^(.*)index\.(html|htm|php)$ \$1 permanent;
}
if (\$host !~* ^www\.) {
    rewrite ^/(.*)$ \$scheme://www.\$host/\$1 permanent;
}
#@- 301 redirect
EOF
    fi

    if [ "$access_log" != 'y' ]; then
      al="access_log off;"
    else
      echo "Default access log file:$domain.log"
      alf="log_format  $domain  '\$remote_addr - \$remote_user [\$time_local] \"\$request\" '
             '\$status \$body_bytes_sent \"\$http_referer\" '
             '\"\$http_user_agent\" \$http_x_forwarded_for';"
      al="access_log  /home/wwwlogs/$domain.log  $domain;"
      touch /home/wwwlogs/$domain.log
    fi

    if [ -d /home/wwwroot ]; then
        mkdir -p $vhostdir
        chmod -R 755 $vhostdir
        chown -R www:www $vhostdir

        if [ -z $rewrite ]; then
            rewrite="none"
        fi
        case "$web_app" in
        wordpress)
             rewrite="wordpress"
            ;;
        typecho)
            rewrite="typecho"
            ;;
        esac

        if [ ! -f /usr/local/nginx/conf/$rewrite.conf ]; then
            touch /usr/local/nginx/conf/$rewrite.conf
        fi
        
        cat >/usr/local/nginx/conf/vhost/$domain.conf<<eof
$alf
server
    {
        listen       80;
        server_name $domain$moredomainame;
        index index.html index.htm index.php default.html default.htm default.php;
        root  $vhostdir;
        
        include $rewrite.conf;
        #error_page   404   /404.html;
        #location ~ .*\.(php|php5)?$
        location ~ [^/]\.php(/|$)
            {
                # comment try_files \$uri =404; to enable pathinfo
                try_files \$uri =404;
                fastcgi_pass  unix:/tmp/php-cgi.sock;
                fastcgi_index index.php;
                include $fcgipath;
                #include pathinfo.conf;
            }
        location ~ .*\.(gif|jpg|jpeg|png|bmp|swf)$
            {
                expires      30d;
            }
        location ~ .*\.(js|css)?$
            {
                expires      12h;
            }
        $al
    }
eof
        if [ "$rewrite" = "typecho" ] || [ "$web_app" = "typecho" ]; then
            sed -i -e 's/try_files/#&/' -e 's/#include pathinfo.conf/include pathinfo.conf/' /usr/local/nginx/conf/vhost/$domain.conf
        fi
        
        cur_php_version=`/usr/local/php/bin/php -r 'echo PHP_VERSION;'`

        if echo "$cur_php_version" | grep -qE "5.3.|5.4.|5.5."
        then
            cat >>/usr/local/php/etc/php.ini<<eof
[HOST=$domain]
open_basedir=$vhostdir/:/tmp/
[PATH=$vhostdir]
open_basedir=$vhostdir/:/tmp/
eof
        fi
    fi
}


function install_lnmpa_vhost {
    if [ ! -z "$1" ]; then
        domain=$1
        moredomainame=" www.$domain"
        vhostdir="/home/wwwroot/$domain"
    fi

    if [ "$access_log" != 'y' ]; then
      al="access_log off;"
    else
      alf="log_format  $domain  '\$remote_addr - \$remote_user [\$time_local] \"\$request\" '
             '\$status \$body_bytes_sent \"\$http_referer\" '
             '\"\$http_user_agent\" \$http_x_forwarded_for';"
      al="access_log  /home/wwwlogs/$domain.log  $domain;"
      touch /home/wwwlogs/$domain.log
    fi

    if [ -d /home/wwwroot ]; then
        mkdir -p $vhostdir
        chmod -R 755 $vhostdir
        chown -R www:www $vhostdir

        if [ "$rewrite" != 'none' ] && [ ! -z $rewrite ]; then
            if [ ! -f /usr/local/nginx/conf/$rewrite.conf ]; then
                echo "Create Virtul Host ReWrite file......"
                touch /usr/local/nginx/conf/$rewrite.conf
                echo "Create rewirte file successful,now you can add rewrite rule into /usr/local/nginx/conf/$rewrite.conf."
            else
                echo "You select the exist rewrite rule:/usr/local/nginx/conf/$rewrite.conf"
            fi
        fi
        
        cat >/usr/local/nginx/conf/vhost/$domain.conf<<eof
$alf
server
    {
        listen       80;
        server_name $domain$moredomainame;
        index index.html index.htm index.php default.html default.htm default.php;
        root  $vhostdir;
        location / {
            try_files \$uri @apache;
            }
        location @apache {
            internal;
            proxy_pass http://127.0.0.1:88;
            include proxy.conf;
            }
        location ~ .*\.(php|php5)?$
            {
                proxy_pass http://127.0.0.1:88;
                include proxy.conf;
            }
        location ~ .*\.(gif|jpg|jpeg|png|bmp|swf)$
            {
                expires      30d;
            }
        location ~ .*\.(js|css)?$
            {
                expires      7d;
            }
        $al
    }
eof

        cat >/usr/local/apache/conf/vhost/$domain.conf<<eof
<VirtualHost *:88>
ServerAdmin webmaster@example.com
php_admin_value open_basedir "$vhostdir:/tmp/:/var/tmp/:/proc/"
DocumentRoot "$vhostdir"
ServerName $domain
ServerAlias $moredomainame
ErrorLog "logs/$domain-error_log"
CustomLog "logs/$domain-access_log" common
</VirtualHost>
eof

        if [ "$access_log" != 'y' ]; then
            sed -i 's/ErrorLog/#ErrorLog/g' /usr/local/apache/conf/vhost/$domain.conf
            sed -i 's/CustomLog/#CustomLog/g' /usr/local/apache/conf/vhost/$domain.conf
        fi
    fi
}

function check_mycnf() {
    if ! mysql -u root -e ";" ; then
        print_warn "Your are not set your mysql permissions"
        mysqlrootpwd=""
        read -p "Please input the root password of mysql:" mysqlrootpwd
        while ! mysql -u root -p$mysqlrootpwd  -e ";" ; do
            read -p "Can't connect to Mysql, please retry: " mysqlrootpwd
        done
        cat > ~/.my.cnf <<END
[client]
user = root
password = $mysqlrootpwd
END
        chmod 600 ~/.my.cnf
    fi
}

function get_domain_name() {
    # Getting rid of the lowest part.
    domain=${1%.*}
    lowest=`expr "$domain" : '.*\.\([a-z][a-z]*\)'`
    case "$lowest" in
    com|net|org|gov|edu|co)
        domain=${domain%.*}
        ;;
    esac
    lowest=`expr "$domain" : '.*\.\([a-z][a-z]*\)'`
    [ -z "$lowest" ] && echo "$domain" || echo "$lowest"
}
function get_password() {
    # Check whether our local salt is present.
    SALT=/var/lib/radom_salt
    if [ ! -f "$SALT" ]
    then
        head -c 512 /dev/urandom > "$SALT"
        chmod 400 "$SALT"
    fi
    password=`(cat "$SALT"; echo $1) | md5sum | base64`
    echo ${password:0:13}
}
Check_Pureftpd()
{
    if [ ! -f /usr/local/pureftpd/sbin/pure-config.pl ]; then
        echo "Pureftpd was not installed!"
        exit 1
    fi
}
function add_ftp_new {
    Check_Pureftpd
    www_uid=`id -u www`
    www_gid=`id -g www`
    ftp_account_name=`expr substr $(echo $1 | tr -d '.') 1 16`
    ftp_account_password=`cat /dev/urandom | tr -dc 'a-zA-Z0-9' | fold -w 13 | head -n 1`
        cat >/tmp/pass${ftp_account_name}<<EOF
${ftp_account_password}
${ftp_account_password}
EOF
        /usr/local/pureftpd/bin/pure-pw useradd ${ftp_account_name} -f /usr/local/pureftpd/etc/pureftpd.passwd -u ${www_uid} -g ${www_gid} -d ${vhostdir} -m < /tmp/pass${ftp_account_name}
        if [ $? -eq 0 ]; then
            echo "Created FTP User: ${ftp_account_name} Sucessfully."
            cat >> "/home/wwwlogs/$1.ftp.txt" <<END
[$1.ftp]
domainname = $1
hostip = $(gethostip)
username = $ftp_account_name
password = $ftp_account_password
END
        else
            echo "FTP User: ${ftp_account_name} already exists!"
        fi
        
        rm -f /tmp/pass${ftp_account_name}
}

function add_ftp {
    if [ ! -f /usr/local/pureftpd/sbin/pure-config.pl ]; then
        echo "Pureftpd was not installed!"
        exit 1
    fi
    check_mycnf
    ftpusername=`expr substr $(echo $1 | tr -d '.') 1 16`
    # ftppwd=`get_password "$ftpusername@ftp"`
    ftppwd=`cat /dev/urandom | tr -dc 'a-zA-Z0-9' | fold -w 13 | head -n 1`
    wwwuid=`id -u www`
    wwwgid=`id -g www`
    mysql -u root 2>/tmp/sql_error <<EOF
INSERT INTO ftpusers.users VALUES ('$ftpusername',MD5('$ftppwd'), $wwwuid, $wwwgid, '$vhostdir', 100, 50, 1000, 1000, '*', 'by shell script added, $(date +"%Y-%m-%d")', '1', 0, 0);
EOF
    if [ $? -ne 0 ]; then
        if cat /tmp/sql_error | grep -q "Duplicate entry"; then
            dirname=$(echo "SELECT Dir FROM ftpusers.users WHERE User='$ftpusername';" | mysql -u root | tr -s '\n' ' ' | cut -d ' ' -f 2 )
            if [ "$dirname" = "$vhostdir" ]; then
                print_warn 'FTP user is exsit!'
                if [ ! -f "/home/wwwlogs/$1.ftp.txt" ]; then
                    echo "UPDATE ftpusers.users SET Password=MD5('$ftppwd') WHERE  User='$ftpusername';" | mysql -u root
                    if [ $? -ne 0 ]; then
                        echo "UPDATE User '$ftpusername' failure!"
                    else
                        cat >> "/home/wwwlogs/$1.ftp.txt" <<END
[$1.ftp]
domainname = $1
hostip = $(gethostip)
username = $ftpusername
password = $ftppwd
END
                    fi
                else
                    cat "/home/wwwlogs/$1.ftp.txt"
                fi
            else
                newstr=$(echo $1 | tr -d '.-')
                newstr=${newstr:0:12}`date +%s%N | md5sum | head -c 4`
                ftpusername=`expr substr $(echo $newstr | tr -d '.-') 1 16`
                mysql -u root 2>/tmp/sql_error <<EOF
    INSERT INTO ftpusers.users VALUES ('$ftpusername',MD5('$ftppwd'), $wwwuid, $wwwgid, '$vhostdir', 100, 50, 1000, 1000, '*', 'by shell script added, $(date +"%Y-%m-%d")', '1', 0, 0);
EOF
                if [ $? -ne 0 ]; then
                   print_error "Add ftp user failure! `cat /tmp/sql_error`"
                else
                    cat >> "/home/wwwlogs/$1.ftp.txt" <<END
    [$1.ftp]
    domainname = $1
    hostip = $(gethostip)
    username = $ftpusername
    password = $ftppwd
END
                fi
                
            fi
            
        fi
    else
        cat >> "/home/wwwlogs/$1.ftp.txt" <<END
[$1.ftp]
domainname = $1
hostip = $(gethostip)
username = $ftpusername
password = $ftppwd
END
    fi
    #rm -rf /tmp/sql_error
}

function add_mysql {
    check_mycnf
    # Setting up the MySQL database
    dbname=`echo $1 | tr . _`
    userid=`get_domain_name $1`
    userid=$userid$(date +"%y%m%d")
    # MySQL userid cannot be more than 15 characters long
    userid="${userid:0:15}"
    # passwd=`get_password "$userid@mysql"`
    passwd=`cat /dev/urandom | tr -dc 'a-zA-Z0-9' | fold -w 13 | head -n 1`

    echo "CREATE DATABASE IF NOT EXISTS \`$dbname\` CHARACTER SET utf8 COLLATE utf8_general_ci;" | mysql
    echo "GRANT ALL PRIVILEGES ON \`$dbname\`.* TO \`$userid\`@localhost IDENTIFIED BY '$passwd';" | \
        mysql

    if [ $? -ne 0 ]; then
        print_error "Add mysql database failure!"
    else
        cat >> "/home/wwwlogs/$1.mysql.txt" <<END
[$1.mysql]
dbname = $dbname
username = $userid
password = $passwd
END
    fi
}


function install_wordpress {
    check_mycnf
    INSTALL_DIR="/home/wwwroot/$1"
    if [ ! -d "/tmp/wordpress.$$" ]; then
        # Downloading the WordPress' latest and greatest distribution.
        mkdir /tmp/wordpress.$$
        wget -O - http://wordpress.org/latest.tar.gz --no-check-certificate | \
            tar zxf - -C /tmp/wordpress.$$
    fi
    cp -r /tmp/wordpress.$$/wordpress/* $INSTALL_DIR
    cd $INSTALL_DIR
    # Install wordpress plugins
    array=(fv-all-in-one-seo-pack.zip yet-another-related-posts-plugin.3.5.1.zip disabler.2.1.zip google-sitemap-plugin.1.08.zip wptouch.1.9.40.zip)
    length=${#array[@]}
    for ((i=0; i<$length; i++))
    do
    plugin_url=http://downloads.wordpress.org/plugin/${array[$i]}
    wget $plugin_url
    unzip -n ${array[$i]} -d $INSTALL_DIR/wp-content/plugins
    rm -rf ${array[$i]}
    echo "${array[$i]} OK"
    done
    echo "wordpress plugins installed"

    chown -R www:www $INSTALL_DIR
    chmod -R 755 $INSTALL_DIR
    if [ ! -n "$dbname" ]; then
        add_mysql $1
    fi
    # Setting wp-config.php 
    cp "/home/wwwroot/$1/wp-config-sample.php" "/home/wwwroot/$1/wp-config.php"
    sed -i "s/database_name_here/$dbname/; s/username_here/$userid/; s/password_here/$passwd/" \
        "/home/wwwroot/$1/wp-config.php"
    sed -i "31a define(\'WP_CACHE\', true);"  "/home/wwwroot/$1/wp-config.php"
    # Grab WordPress Salt Keys
    wget -O /tmp/wp.keys -q https://api.wordpress.org/secret-key/1.1/salt/
    sed -i '/#@-/r /tmp/wp.keys' "/home/wwwroot/$1/wp-config.php"
    sed -i "/#@+/,/#@-/d" "/home/wwwroot/$1/wp-config.php"
    rm /tmp/wp.keys
    # chown -R www:www "/home/wwwroot/$1/wp-config.php"
}

function install_typecho {
    check_mycnf
    if [ ! -d "/tmp/typecho.$$" ]; then
        # Downloading typecho build version
        mkdir /tmp/typecho.$$
        wget -O - "http://leadscloud.github.io/soft/typecho.tar.gz" | \
            tar zxf - -C /tmp/typecho.$$
    fi
    cp -r /tmp/typecho.$$/build/* "/home/wwwroot/$1"
    cp -r /tmp/typecho.$$/build/.[!.]* "/home/wwwroot/$1"
    chown -R www "/home/wwwroot/$1"
    chmod -R 755 "/home/wwwroot/$1"
}

function install_empirecms {
    check_mycnf
    if [ ! -d "/tmp/empirecms.$$" ]; then
        # Downloading the EmpireCMS
        mkdir /tmp/empirecms.$$
        wget -O - http://leadscloud.github.io/soft/empirecms-7.0-utf8.tar.gz | \
            tar zxf - -C /tmp/empirecms.$$
    fi
    cp -r /tmp/empirecms.$$/* "/home/wwwroot/$1"
    # Test mysql setting
    if [ ! -n "$dbname" ]; then
        add_mysql $1
    fi
    sed -i "s/value=\"username\"/value=\"$userid\"/; s/value=\"empirecms\"/value=\"$dbname\"/; s/id=\"mydbpassword\"/& value=\"$passwd\"/" \
        "/home/wwwroot/$1/e/install/index.php"
    sed -i "s/想[^<]*/请尽忙完成安装，以免被人窥探到数据库信息/" "/home/wwwroot/$1/e/install/index.php"
    chown -R www:www "/home/wwwroot/$1"
    chmod -R 755 "/home/wwwroot/$1"
    cat >> "/home/wwwroot/$1/$1.mysql.txt" <<END
[$1.empirecms.install.url]
# Please enter the url in your brower and install it ASAP
http://www.$1/e/install/index.php?enews=setdb&f=4
END
}

function show_help {
    cat <<END
Usage: `basename $0` [OPTION]...
Bulk add virtual host, Include FTP, MYSQL, Web Application
Web application include wordpress, typecho, empirecms
When your first run, you need to enter the password of mysql
System Requirements:
   1. web server is LNMP/LNMPA, LNMPA is a tool to auto-compile & install Nginx+MySQL+PHP+Apache on Linux
      this script is only suitable licess's LNMP
      LNMP Official Website: http://lnmp.org/install.html
   2. FTP Server must be Pureftpd. Install method: http://lnmp.org/faq/ftpserver.html
Options:
  -d domain           domain list, multiple domains must use double quotes.
                          such as, $0 -d "domain1.com domain2.com"
                          suggest you do not use the domain start with www
  -f                  add ftp account
  -m                  add mysql account
  -a webapp           install web application, include [wordpress,typecho,empirecms], default none
  -r                  add redirect rule, only LNMP need it, include [typecho,wordpress,301] or your custom rule, default none
  -l                  enable host log history, default disable logging
  -e                  remove vhost, and remove content file, vhost config, Example: 
                          $0 -e "domain1.com domain2.com domain3.com"
  -h                  show help
Example:
  `basename $0` -d "love4026.org sbmzhcn.com" -fm                  quick add a domain with ftp,mysql
  `basename $0` -d love4026.org -fm -a wordpress                   quick add a domain with ftp,mysql and wordpress
  `basename $0` -d love4026.org -fm -a wordpress -r wordpress      in LNMP,you will need nginx rewrite rule,can not use .htaccess
  `basename $0` -d love4026.org -fml                               quick add a domain with ftp,mysql,and turn on logging
When you are finished add, in your wwwlogs will auto add a file which contain your account information.
for example, when add domain love4026.org with ftp and mysql option, script will create two files:
    1. /home/wwwlogs/love4026.org.ftp.txt
    2. /home/wwwlogs/love4026.org.mysql.txt
Author: Ray.
Website: <https://leadscloud.github.io>.
Email: <sbmzhcn@gmail.com>.
If you have any questions, please contact me!
More information at: <https://github.com/leadscloud/Tools>.
END
    exit 1
}

if [ "$#" = "1" ] && [ "$1" = "--help" ] || [ "$#" = "0" ]; then
    show_help
fi

if [ "$#" = "2" ] && [ "$1" = "--remove" ]; then
    # Test
    check_mycnf
    echo "Now removing vhost: $2, contain ftp,mysql,vhost ..."
    dbname=`echo $2 | tr . _`
    ftpusername=`expr substr $(echo $2 | tr -d '.') 1 16`
    rm -rf "/home/wwwroot/$2"
    echo "DROP DATABASE $dbname" | mysql
    echo "DELETE FROM ftpusers.users WHERE User='$ftpusername'" | mysql
    rm -rf "/usr/local/nginx/conf/vhost/$2.conf"
    rm -rf "/usr/local/apache/conf/vhost/$2.conf"
    print_info "Remove $2 complete!"
    exit 1
fi

while getopts "d:r:lfma:ht:e:" arg #选项后面的冒号表示该选项需要参数
do
    case $arg in
    d) # domain list
        domainlist=$OPTARG
    ;;
    r) # allow rewrite
        if [ -z "$1" ];
            rewrite="none"
        then
            rewrite=$OPTARG
        fi
    ;;
    l) # enable access log
        access_log="y"
    ;;
    f) # add ftp
        check_mycnf
        add_ftp="y"
    ;;
    m) # add mysql
        check_mycnf
        add_mysql="y"
    ;;
    a) # install web app
        check_mycnf
        web_app=$OPTARG
    ;;
    t) # send mail to
        mail_to=$OPTARG
    ;;
    e) # remove vhost
        deletelist=$OPTARG
    ;;
    h) # help
        show_help
    ;;
    ?)  #当有不认识的选项的时候arg为?
        echo "unkonw argument"
        exit 1
    ;;
    esac
done


for domain in $domainlist; do
    if [ ! -z "$domain" ]; then
        # if [ -f "/usr/local/nginx/conf/vhost/$domain.conf" ]; then
        #     print_warn "$domain is exist! Please install it manual"
        #     break
        # fi
        if [ -x /etc/init.d/httpd ]; then
            install_lnmpa_vhost $domain
        else
            install_lnmp_vhost $domain
        fi
        # add ftp account
        if [ "$add_ftp" == 'y' ]; then
            if [ ! -d /home/wwwroot/default/ftp/ ]; then
                add_ftp_new $domain
            else
                add_ftp $domain
            fi
            
        fi
        # add mysql account
        if [ "$add_mysql" == 'y' ]; then
            add_mysql $domain
        fi
        # install web application
        case "$web_app" in
        wordpress)
            install_wordpress $domain
            ;;
        typecho)
            install_typecho $domain
            ;;
        empirecms)
            install_empirecms $domain
            ;;
        esac

        print_info "Add vhost for domain:$domain successful"
        echo "================================================" | tee -a /tmp/all_domain_ftp_mysql.txt
        if [ -f "/home/wwwlogs/$domain.ftp.txt" ]; then
            cat "/home/wwwlogs/$domain.ftp.txt" | tee -a /tmp/all_domain_ftp_mysql.txt
        fi
        if [ -f "/home/wwwlogs/$domain.mysql.txt" ]; then
            cat "/home/wwwlogs/$domain.mysql.txt" 2>/dev/null | tee -a /tmp/all_domain_ftp_mysql.txt
        fi
        echo "Created by script in $(date +"%Y-%m-%d %T %:z")" | tee -a /tmp/all_domain_ftp_mysql.txt
        echo "================================================" | tee -a /tmp/all_domain_ftp_mysql.txt
        echo "" >>/tmp/all_domain_ftp_mysql.txt
        sed -i "\$aCreated by script in $(date +"%Y-%m-%d %T %:z")"  "/home/wwwlogs/$domain.ftp.txt" 2>/dev/null
        sed -i "\$aCreated by script in $(date +"%Y-%m-%d %T %:z")"  "/home/wwwlogs/$domain.mysql.txt" 2>/dev/null
    fi
done

for domain in $deletelist; do
    if [ ! -z "$domain" ]; then
        if [ -d "/home/wwwroot/$domain" ]; then
            rm -rf /home/wwwroot/$domain
        fi
        if [ -d "/home/wwwroot/default/$domain" ]; then
            rm -rf /home/wwwroot/$domain
        fi
        if [ -f /usr/local/nginx/conf/$rewrite.conf ]; then
            rm -rf /usr/local/nginx/conf/$rewrite.conf
        fi
        if [ -f /usr/local/apache/conf/$rewrite.conf ]; then
            rm -rf /usr/local/apache/conf/$rewrite.conf
        fi
    fi
done

# Save log and send with mail
cat /tmp/all_domain_ftp_mysql.txt >> /root/all_domain_ftp_mysql.txt
if [ ! -z "$mail_to" ]; then
    if [ -f /etc/centos-release ]; then
        if [ -z "`service sendmail 2>/dev/null`" ]; then
            yum -y install sendmail
            yum -y install mailx
        else
            #checking if service is running 
            ps -e | grep sendmail > /dev/null 
            servicestat=$(echo $?)   
            if [ "$servicestat" != 0 ]; then
               service sendmail start
            fi
        fi
    fi
    cat /tmp/all_domain_ftp_mysql.txt | mail -s "域名Vhost信息 send by script" "$mail_to"
    echo "email have sent to $mail_to"
fi
rm -rf /tmp/all_domain_ftp_mysql.txt

# remove web app content
if [ -d "/tmp/$web_app.$$" ] && [ "$web_app" != "" ]; then
    rm -rf "/tmp/$web_app.$$"
fi

echo ""
if [ -x /etc/init.d/php-fpm ]; then
    /etc/init.d/php-fpm restart
fi
echo "Test Nginx configure file......"
/usr/local/nginx/sbin/nginx -t
echo ""
echo "Restart Nginx......"
/usr/local/nginx/sbin/nginx -s reload
if [ -x /etc/init.d/httpd ]; then
    echo "Restart Apache......"
    /etc/init.d/httpd restart
fi