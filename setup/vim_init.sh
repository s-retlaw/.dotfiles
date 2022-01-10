if [ -d "~/.vim" ]; then
    mv ~/.vim ~/.vim_bak
fi

ln -s ~/.dotfiles/.vim ~/.vim    


