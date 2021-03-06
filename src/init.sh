#! /bin/bash

opshPath=~+

env_init(){
    if [ $envInit -eq 0 ]; then 
    clear
    echo -e "Environment expansion initialization...wait a moment..."
    sleep 3s
    yum install \
    epel-release man gcc gdb \
    qwt curl-devel expat-devel \
    gettext-devel zlib-devel \
	gcc perl-ExtUtils-MakeMaker \
    unzip gcc-c++ autoconf automake \
    libjpeg libjpeg-devel libpng libpng-devel \
	freetype freetype-devel libxml2 \
    libxml2-devel zlib zlib-devel glibc \
    glibc-devel glib2 glib2-devel \
	bzip2 bzip2-devel ncurses ncurses-devel \
    curl curl-devel e2fsprogs e2fsprogs-devel \
    krb5 krb5-devel libidn libidn-devel \
    openssl openssl-devel openldap \
    openldap-devel nss_ldap openldap-clients \
    openldap-servers gd gd2 gd-devel gd2-devel \
    perl-CPAN pcre-devel php-mcrypt libmcrypt \
    libmcrypt-devel wget libevent cmake libtool \
    readline-devel -y
    envInit=1
    fi
}

install(){
    usage;
    case $? in
    1)
        :;;#install_all;;
    2)
        install_apache;;
    3)
        install_nginx;;
    4)
        install_php;;
    5)
        install_mysql;;
    6)
        install_redis;;
    7)
        install_memcache;;
    8)
        install_git;;
    9)
        install_lua;;
    10)
        install_vim;;
    11)
        install_influxdb;;
    *)
        install;;
    esac
}

usage(){
    sc "Do you want to install these for provide web service ?" g
    sc "(2:apache 3:nginx 4:php 5:mysql 6:redis 7:memcache 8:git 9:lua 10:vim 11:influxdb)" g
    echo -n $(sc "Please choose your choice[2-10][n/N]:" g) 
    read choose && ([[ $choose == 'n' ]] || [[ $choose == 'N' ]]) && exit
    env_init;
    return $choose
}

sc(){
    case $2 in 
    blue|b)
        echo -e "\e[1;34m $1 \e[0m";;
    red|r)
        echo -e "\e[1;31m $1 \e[0m";;
    yellow|y)
        echo -e "\e[1;33m $1 \e[0m";;
    green|g)
        echo -e "\e[1;32m $1 \e[0m";;
    *)      
        echo -e "\e[1;37m $1 \e[0m";;
    esac
}

ft(){
    rows=$(stty -a | head -n 1 | tr ';' ' ' | awk '{print $5}')
    cols=$(stty -a | head -n 1 | tr ';' ' ' | awk '{print $7}')
    let cols-=2
    case $1 in
    line|l)
        str=$(printf "%-${cols}s" "-");echo "+${str// /-}";;
    text|t)
        str=$(printf  "%5s" $2);echo "+${str}";;
    *)
        echo -e "\t\t $2";;
    esac
}
get_ini(){
    echo $(sed -n "/\[$1\]/, /\[.*\]/p" $opshPath/conf/opsh.ini | grep -v "\[.*\]" | grep -w "^$2\s" | awk '{print $3}' | tr -d '\n')
}

init(){
    install 
}

. $opshPath/conf/env_detection.sh
. $opshPath/src/ascii_logo.sh
. $opshPath/src/install_php.sh
. $opshPath/src/install_apache.sh
. $opshPath/src/install_nginx.sh
. $opshPath/src/install_redis.sh
. $opshPath/src/install_memcache.sh
. $opshPath/src/install_mysql.sh
. $opshPath/src/install_influxdb.sh
. $opshPath/src/install_git.sh
. $opshPath/src/install_lua.sh
. $opshPath/src/install_vim.sh

