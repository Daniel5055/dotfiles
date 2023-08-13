# Run in dotfiles dir
source shell/profile.d/0-xdg.sh
source shell/profile.d/nvm.sh

# Should install to XDG_CONFIG_HOME
# Also specifying not to touch configs
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.4/install.sh | PROFILE=/dev/null bash

