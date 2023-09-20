#!/usr/bin/bash

# SauceCodePro

tmp_dir=/tmp/SauceCodePro
tar_dir="$tmp_dir/SauceCodePro.tar.xz"
font_dir="${XDG_DATA_HOME-$HOME/.local/share}/fonts"
fonts=(
    "SauceCodeProNerdFontMono-BoldItalic.ttf"
    "SauceCodeProNerdFontMono-Bold.ttf"
    "SauceCodeProNerdFontMono-Italic.ttf"
    "SauceCodeProNerdFontMono-Regular.ttf"
)

mkdir -p "$tmp_dir"
mkdir -p "$font_dir"

# Download and extract to tmp directory
curl -LJ https://github.com/ryanoasis/nerd-fonts/releases/download/v3.0.2/SourceCodePro.tar.xz -o "$tar_dir"
tar -xf "$tar_dir" -C "$tmp_dir"

# Move the required fonts
for font in ${fonts[@]}; do
    mv "$tmp_dir/$font" "$font_dir/$font"
done

# Cleanup
rm -rf "$tmp_dir"

