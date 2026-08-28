#!/bin/bash
PATH=/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin:~/bin
export PATH

# view nginx /usr/local/nginx/sbin/nginx -V

# Check if user is root
if [ $(id -u) != "0" ]; then 
    echo "Error: You must be root to run this script, please use root to install lnmp"
    exit 1
fi

clear
echo "========================================================================="
echo "Upgrade Nginx with http_sub_module substitutions4nginx for LNMP"
echo "========================================================================="
echo "This script is just used for LNMP"
echo "LNMP is tool to auto-compile & install Nginx+MySQL+PHP on Linux "
echo "For more information about LNMP please visit http://www.lnmp.org/"
echo "========================================================================="

nv=`/usr/local/nginx/sbin/nginx -v 2>&1`
old_nginx_version=`echo $nv | cut -c22-`
#echo $old_nginx_version
substitutions=`/usr/local/nginx/sbin/nginx -V 2>&1`
InstalledSubstitutions=`echo $substitutions | grep -q 'substitutions4nginx'`

if [ "$1" != "--help" ]; then

function upgrade_nginx()
{
	#set nginx version

	nginx_version=""
	echo "Current Nginx Version:$old_nginx_version"
	echo "Please input nginx version you want:"
	echo "You can get version number from http://nginx.org/en/download.html"
	read -p "(example: 1.2.7 ):" nginx_version
	if [ "$nginx_version" = "" ]; then
		echo "Error: You must input nginx version!!"
		exit 1
	fi
	echo "==========================="

	echo "You want to upgrade nginx version to $nginx_version"

	echo "==========================="

	get_char()
	{
	SAVEDSTTY=`stty -g`
	stty -echo
	stty cbreak
	dd if=/dev/tty bs=1 count=1 2> /dev/null
	stty -raw
	stty echo
	stty $SAVEDSTTY
	}
	echo ""
	echo "Press any key to start...or Press Ctrl+c to cancel"
	char=`get_char`

	echo "============================check files=================================="
	if [ -s nginx-$nginx_version.tar.gz ]; then
		echo "nginx-$nginx_version.tar.gz [found]"
	else
		echo "Error: nginx-$nginx_version.tar.gz not found!!!download now......"
		wget -c http://nginx.org/download/nginx-$nginx_version.tar.gz
		if [ $? -eq 0 ]; then
			echo "Download nginx-$nginx_version.tar.gz successfully!"
		else
			echo "WARNING!May be the nginx version you input was wrong,please check!"
			echo "Nginx Version input was:"$nginx_version
			sleep 5
			exit 1
		fi	
	fi
	echo "============================check files=================================="
	if [ -s substitutions4nginx.tar.gz ]; then
		echo "substitutions4nginx.tar.gz [found]"
	else
		echo "Error: substitutions4nginx.tar.gz not found!!!download now......"
		wget -c http://soft.shibangsoft.com/substitutions4nginx.tar.gz
		if [ $? -eq 0 ]; then
			echo "Download substitutions4nginx.tar.gz successfully!"
		else
			echo "WARNING!May be the download url is not vaild,please download it manual!"
			sleep 5
			exit 1
		fi
	fi
	echo "============================check files=================================="
	echo "Stoping MySQL..."
	/etc/init.d/mysql stop
	echo "Stoping PHP-FPM..."
	/etc/init.d/php-fpm stop
	if [ -s /etc/init.d/memceached ]; then
		echo "Stoping Memcached..."
		/etc/init.d/memcacehd stop
	fi

	rm -rf nginx-$nginx_version/
	rm -rf substitutions4nginx-read-only/

	tar zxvf nginx-$nginx_version.tar.gz
	tar zxvf substitutions4nginx.tar.gz
	cd nginx-$nginx_version/
	./configure --user=www --group=www --prefix=/usr/local/nginx --with-http_stub_status_module --with-http_ssl_module --with-http_gzip_static_module --with-ipv6 --with-pcre --with-http_sub_module --add-module=../substitutions4nginx-read-only
	make


	mv /usr/local/nginx/sbin/nginx /usr/local/nginx/sbin/nginx.old
	cp objs/nginx /usr/local/nginx/sbin/nginx
	/usr/local/nginx/sbin/nginx -t
	make upgrade
	echo "Upgrade completed!"
	
	echo "Program will display Nginx Version......"
	/usr/local/nginx/sbin/nginx -V
	cd ../

	echo "Restarting Nginx..."
	/etc/init.d/nginx restart

	echo "Starting MySQL..."
	/etc/init.d/mysql start
	echo "Starting PHP-FPM..."
	/etc/init.d/php-fpm start
	if [ -s /etc/init.d/memceached ]; then
		echo "Starting Memcached..."
		/etc/init.d/memcacehd start
	fi
	echo "========================================================================="
	echo "You have successfully upgrade from $old_nginx_version to $nginx_version"
	echo "http_sub_module substitutions4nginx have been configure"
	echo "========================================================================="
	echo "Use /usr/local/nginx/sbin/nginx -V show the configure arguments:"
	echo "--with-http_sub_module --add-module=../substitutions4nginx-read-only"
	echo "========================================================================="
}

	if [ ! $InstalledSubstitutions ]; then
		echo "You have installed substitutions4nginx, continue upgrade ngninx? (n/y)"
		read allow_upgrade
		if [ "$allow_upgrade" == "y" ]; then
			upgrade_nginx
		fi
	else
		echo "Your are not install substitutions4nginx!"
		upgrade_nginx
	fi

	echo ""
	echo "substitutions4nginx have installed for your nginx!"
	echo "Do you want to add sensitive word substitution rules? (y/n)"
	echo "this rules will effect all domain on your VPS"
	read add_substitution
	if [ "$add_substitution" != 'n' ]; then
		cd /usr/local/nginx/conf/
		if grep -q "^[ \t]*subs_filter" "nginx.conf"; then
			echo "You've added some rules, Do you want to comment it? (y/n)"
			read allow_comment
			if [ "$allow_comment" != 'n' ]; then
				echo "comment exist rules..."
				sed -i 's/^[ \t]*sub[s]*_filter/#&/' nginx.conf
			fi
 		fi
 		echo "dowloading substitution rules..."
 		wget -N http://soft.shibangsoft.com/subs_filter.conf
 		if [ $? -eq 0 ]; then
			echo "Download subs_filter.conf successfully!"
		else
			echo "WARNING!Download failure, please download it manual!"
			touch subs_filter.conf
		fi
		sed -i '/include.*vhost/a\include subs_filter.conf;' nginx.conf
		
		/usr/local/nginx/sbin/nginx -t
		/etc/init.d/nginx reload
		echo "Add substitution rules completed!"
		echo "========================================================================="
		echo "substitution rules successfully installed to nginx"
		echo "Now your VPS was globally enabled, if you want to enable specified site"
		echo "please use below command:"
		echo "cd /usr/local/nginx/conf/"
		echo "sed -i 's/^[ \t]*sub[s]*_filter/#&/' nginx.conf"
		echo "cd /usr/local/nginx/conf/vhost/"
		echo "sed -i '/^access_log/a\include subs_filter.conf;' domainname.com.conf"
		echo "========================================================================="
	fi
	
	
fi