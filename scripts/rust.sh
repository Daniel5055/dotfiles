#!/usr/bin/sh

source shell/profile.d/0-xdg.sh
source shell/profile.d/rust.sh

curl https://sh.rustup.rs -sSf | sh -s -- --no-modify-path -y

