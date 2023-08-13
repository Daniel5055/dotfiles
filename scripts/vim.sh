#!/usr/bin/sh

# Install vim plugins
vim -u vim/vimrc.plug +PlugInstall +qall &> /dev/null

