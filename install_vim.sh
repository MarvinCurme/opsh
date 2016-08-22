#! /bin/bash
wget -c http://prdownloads.sourceforge.net/ctags/ctags-5.8.tar.gz
tar zxvf ctags-5.8.tar.gz
cd ctags-5.8
./configure && make && make install
cd ..
. ./install_lua.sh
wget -c ftp://ftp.vim.org/pub/vim/unix/vim-7.4.tar.bz2
tar jxf vim-7.4.tar.bz2
cd vim74/
sed -i '/luaL_optlong/s/luaL_optlong/(long)luaL_optinteger/' src/if_lua.c
./configure --with-features=huge \
    --enable-cscope \
    --enable-rubyinterp \
    --enable-largefile \
    --enable-multibyte \
    --disable-netbeans \
    --enable-luainterp \
    --with-lua-prefix=/usr/local \
    --enable-pythoninterp \
    --enable-cscope --prefix=/usr
make && make install
curl https://raw.githubusercontent.com/spf13/spf13-vim/3.0/bootstrap.sh -l > spf13-vim.sh && sh spf13-vim.sh
cd ..
sed '$r ~/.vimrc.local' conf/vimrc >> ~/.vimrc.local
