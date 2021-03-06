#! /bin/bash

install_redis(){

    if [ $(whereis -b redis | tr ' ' '\n' | wc -l) -gt 1 ];then
        echo "redis has intalled in this machine";install
    else
        local url_path=$(get_ini redis src)
        local dir_name=$(get_ini global dlPath)/$(get_ini redir dir)
        if [ ! -d $dir_name ];then 
            mkdir -p $dir_name 2> /dev/null
        fi
        if [ $? -eq 0 ];then
            cd $dir_name;
			wget $url_path 
			tar xzf redis-3.2.3.tar.gz
			cd redis-3.2.3	
			make
            echo "Redis Complete install";
			install
        else
            echo "install redis faild"
        fi
    fi
}
