#!/usr/bin/sh

# Sourcing adds the asdf command and deno bin for vim
. "$ASDF_DIR/asdf.sh"

# Install vim plugins
vim +PlugInstall +qall > /dev/null

