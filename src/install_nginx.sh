#! /bin/bash
install_nginx(){
    if [ $(whereis -b nginx | tr ' ' '\n' | wc -l) -gt 1 ];then
        echo "nginx has intalled in this machine";install
    else
        local url_path=$(get_ini nginx src)
        local dir_name=$(get_ini global dlPath)/$(get_ini nginx dir)
        [ ! -d $dir_name ] && mkdir -p $dir_name 2> /dev/null 
            
        if [ $? -eq 0 ];then
            cd $dir_name;
			wget $url_path 
			tar xzf nginx-1.10.1.tar.gz
			cd nginx-1.10.1	
			./configure \
                --prefix=$(get_ini global prefix)/$(get_ini nginx dir)
            --sbin-path=$(get_ini global prefix)/$(get_ini nginx dir)/sbin \
                --conf-path= $(get_ini global prefix)/$(get_ini nginx dir)/conf \
			--error-log-path=/var/log/nginx/error.log \
			--pid-path=/var/run/nginx/nginx.pid \
			--user=nginx \
			--group=nginx \
			--with-http_ssl_module \
			--with-http_flv_module \
			--with-http_gzip_static_module \
			--http-proxy-temp-path=/var/tmp/nginx/proxy \
			--http-fastcgi-temp-path=/var/tmp/nginx/fcgi \
			--with-http_stub_status_module
			make && make install
            ln -s $opshPath/init.d/nginx /etc/init.d/nginx
            sed -i '65,71s/#//' $(get_ini global prefix)/$(get_ini nginx dir)/conf/nginx.conf
			sed -i '/fastcgi_param/s/\/scripts/$document_root/' $(get_ini global prefix)/$(get_ini nginx dir)/conf/nginx.conf
			mkdir -p /var/tmp/nginx/client
            echo "Nginx Complete install";
			install
        else
            echo "install Nginx faild"
        fi
    fi
	
}
