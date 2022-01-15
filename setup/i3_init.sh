if [ -d "~/.config/i3" ]; then
    mv ~/.config/i3 ~/.config/i3_bak
fi

ln -s ~/.dotfiles/.config/i3 ~/.config/i3    


