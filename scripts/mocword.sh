#!/usr/bin/sh

cargo install mocword

download_url=https://github.com/high-moctane/mocword-data/releases/download/eng20200217/mocword.sqlite.gz

share_dir="$XDG_DATA_HOME"
if [ -z "$SDG_DATA_HOME" ]; then
    share_dir="$HOME/.local/share"
fi

curl -LO "$download_url"
gunzip mocword.sqlite.gz
mv mocword.sqlite "$share_dir/mocword"
rm -f mocword.sqlite.gz

# Set env variable (also done in profile)
share_dir="$MOCWORD_DATA"
if [ -z "$MOCWORD_DATA" ]; then
    share_dir="$HOME/.local/share"
fi

moc_data="$share_dir/mocword/mocword.sqlite" 
export MOCWORD_DATA="$moc_data"
