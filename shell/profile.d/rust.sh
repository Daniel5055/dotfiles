export RUSTUP_HOME="$XDG_CONFIG_HOME/rustup"
export CARGO_HOME="$XDG_CACHE_HOME/cargo"

export PATH="$CARGO_HOME/bin:$PATH"

[ -f "$CARGO_HOME/env" ] && source "$CARGO_HOME/env"

