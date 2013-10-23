#!/bin/sh

DIR=$(dirname $(readlink -f $0))

# bash configs
if [ -e $HOME/.bashrc ]; then
    rm $HOME/.bashrc
fi
ln -s $DIR/.bashrc $HOME/

if [ -e $HOME/.bash_aliases ]; then
    rm $HOME/.bash_aliases
fi
ln -s $DIR/.bash_aliases $HOME/

touch $HOME/.bash_includes

# vim configs
if [ -d $HOME/.vim ]; then
    rm -r $HOME/.vim
fi
ln -s $DIR/.vim $HOME/

# git configs
if [ -e $HOME/.gitconfig ]; then
    rm $HOME/.gitconfig
fi
ln -s $DIR/.gitconfig $HOME/

read -p "What global git username do you wish to use? " GIT_USER
git config --global user.name "$GIT_USER"

read -p 'What global git email do you wish to use? ' GIT_EMAIL
git config --global user.email "$GIT_EMAIL"

# xmonad
if [ -d $HOME/.xmonad ]; then
    rm -r $HOME/.xmonad
fi
ln -s $DIR/.xmonad $HOME/

if [ -e $HOME/.gnomerc ]; then
    rm $HOME/.gnomerc
fi
ln -s $DIR/.gnomerc $HOME/

# terminator config
mkdir -p $HOME/.config
if [ -d $HOME/.config/terminator ]; then
    rm -r $HOME/.config/terminator
fi

ln -s $DIR/.config/terminator $HOME/.config/

# sublime config
mkdir -p $HOME/.config/sublime-text-2/Packages/User
if [ -e $HOME/.config/sublime-text-2/Packages/User/Preferences.sublime-settings ]; then
    rm $HOME/.config/sublime-text-2/Packages/User/Preferences.sublime-settings
fi
ln -s $DIR/.config/sublime-text-2/Packages/User/Preferences.sublime-settings $HOME/.config/sublime-text-2/Packages/User/
