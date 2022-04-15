mkdir -p ~/.config 2>/dev/null

if [ -d "~/.config/nvim" ]; then
    mv ~/.config/nvim ~/.config/nvim_bak
fi

ln -s ~/.dotfiles/.config/nvim ~/.config/nvim    


