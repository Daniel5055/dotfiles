#! /usr/bin/sh

# Sourcing env
. shell/profile.d/0-xdg.sh
. shell/profile.d/deno.sh

if [ -z "${DENO_INSTALL+x}" ]; then
    echo "\$DENO_INSTALL is not set, cannot install deno"
    exit 1
fi

# Installs to $DENO_INSTALL thanks to env variables set in profile.d
curl -fsSL https://deno.land/x/install/install.sh | sh

# Move binary
mv "$DENO_INSTALL"/bin/* "$XDG_BIN_HOME"
rm -rf "$DENO_INSTALL"/bin

