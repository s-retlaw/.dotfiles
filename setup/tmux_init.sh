if [ -d "~/.tmux_conf" ]; then
    mv ~/.tmux_conf ~/.tmux_conf_bak
fi

if [ -d "~./tmux"]; then
    mv ~/.tmux ~/.tmux_bak
fi

ln -s ~/dotfiles/.tmux_conf ~/.tmux_conf
ln -s ~/dotfiles/.tmux ~/.tmux

git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

echo "TMux Setup.  Press <C-A>I to install the plugins"

