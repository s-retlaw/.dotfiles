mv ~/.tmux_conf ~/.tmux_conf_bak 
mv ~/.tmux ~/.tmux_bak

ln -s ~/.tmux_conf ~/dotfiles/.tmux_conf
ln -s ~/.tmux ~/dotfiles/.tmux 

git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

echo "TMux Setup.  Press <C-A>I to install the plugins"

