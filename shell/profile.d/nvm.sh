config_dir="$HOME/.config"

if ! [ -z "${XDG_CONFIG_HOME+x}" ]; then
    config_dir="$XDG_CONFIG_HOME"
fi

export NVM_DIR="$config_dir/nvm"

[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

