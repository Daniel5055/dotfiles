#!/usr/bin/sh

source shell/profile.d/0-xdg.sh
source shell/profile.d/asdf.sh

# Not really XDG friendly, so keep in custom asdf directory
# Plugins installed in XDG_DATA_HOME
git clone https://github.com/asdf-vm/asdf.git "$ASDF_DIR" --branch v0.13.1

# Also done in bashrc from then on
. "$ASDF_DIR/asdf.sh"

# Installing the necessary plugins from .tool-versions
cat asdf/tool-versions | cut -d' ' -f1 | grep "^[^\#]" | xargs -i asdf plugin add  {}

# Installing tool versions from .tool-version file
asdf install

