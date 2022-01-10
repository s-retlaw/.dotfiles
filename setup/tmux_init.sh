if [ -d "~/.tmux.conf" ]; then
    mv ~/.tmux.conf ~/.tmux.conf_bak
fi

if [ -d "~./tmux"]; then
    mv ~/.tmux ~/.tmux_bak
fi

ln -s ~/.dotfiles/.tmux.conf ~/.tmux.conf
ln -s ~/.dotfiles/.tmux ~/.tmux

git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

echo "TMux Setup.  Press <C-A>I to install the plugins"

