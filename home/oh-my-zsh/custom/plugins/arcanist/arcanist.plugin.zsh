#!/bin/zsh

ARCANIST_HOME=${ARCANIST_HOME:-$HOME/.arcanist}

function __install_arcanist {
    git clone https://github.com/phacility/libphutil.git $ARCANIST_HOME/libphutil
    git clone https://github.com/phacility/arcanist.git $ARCANIST_HOME/arcanist
}

if [[ ! -d $ARCANIST_HOME ]]; then
    __install_arcanist
fi

export PATH="$PATH:$ARCANIST_HOME/arcanist/bin"
