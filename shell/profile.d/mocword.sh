share_dir="$MOCWORD_DATA"
if [ -z "$MOCWORD_DATA" ]; then
    share_dir="$HOME/.local/share"
fi

moc_data="$share_dir/mocword/mocword.sqlite" 

if [ -f $moc_data ]; then
    export MOCWORD_DATA="$moc_data"
fi

