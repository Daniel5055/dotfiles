#! /usr/bin/sh

# Run in dotfiles dir
source shell/profile.d/0-xdg.sh
source shell/profile.d/deno.sh

if [ -z "${DENO_INSTALL+x}" ]; then
    echo "\$DENO_INSTALL is not set, cannot install deno"
    exit 1
fi

# Installs to $DENO_INSTALL thanks to env variables set in profile.d
curl -fsSL https://deno.land/x/install/install.sh | sh
mv "$DENO_INSTALL"/bin/* "$HOME"/.local/bin
rm -r "$DENO_INSTALL"/bin

