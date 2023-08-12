#! /usr/bin/sh

if [ -z "${DENO_INSTALL+x}" ]; then
    echo "\$DENO_INSTALL is not set, cannot install deno"
    exit 1
fi

# Installs to $DENO_INSTALL thanks to env variables set in profile.d
curl -fsSL https://deno.land/x/install/install.sh | sh
mv "$DENO_INSTALL"/bin/* "$HOME"/.local/bin
rm -r "$DENO_INSTALL"/bin

