#!/usr/bin/sh

source shell/profile.d/0-xdg.sh
source shell/profile.d/mocword.sh

# Necessary for vim extension
cargo install mocword

# Downloading mocword data
download_url=https://github.com/high-moctane/mocword-data/releases/download/eng20200217/mocword.sqlite.gz
curl -LO "$download_url"

# Unzip, move to directory, and delete zip
gunzip mocword.sqlite.gz
mkdir -p "$XDG_DATA_HOME/mocword"
mv mocword.sqlite "$XDG_DATA_HOME/mocword/mocword.sqlite"
rm -f mocword.sqlite.gz

