#!/bin/bash

AURDIR=$HOME/AUR
MODE=$1
PKG=$2

NORMAL="\033[0;0m"
SUCCESS="\033[1;32m"
ERROR="\033[1;31m"

if [ -z $MODE ]
then
    echo -e "${ERROR}ERROR${NORMAL}: You need to select a mode! Try 'aur help'!"
    exit 1
fi

if [ $MODE = help ]
then
    echo "With this command you can easily install packages from AUR."
    echo "There are three modes: install, uninstall, and query."
    echo "The modes can be specified via their initial character."
    exit 0
fi

if [ $MODE = install ] || [ $MODE = i ]
then
    if [ $# != 2 ]
    then
        echo -e "${ERROR}ERROR${NORMAL}: You need to specify a package to install!"
        exit 1
    fi

    # Create necessary AUR directory
    mkdir -p $AURDIR
    cd $AURDIR

    # Clone package
    if ! git clone https://aur.archlinux.org/$PKG.git
    then
        cd $AURDIR
        rm -rf $AURDIR/$PKG

        echo -e "${ERROR}ERROR${NORMAL}: Could not clone package!"
        exit 1
    fi
    cd $AURDIR/$PKG

    # Make & install package
    if ! makepkg -sri
    then
        cd $AURDIR
        rm -rf $AURDIR/$PKG

        echo -e "${ERROR}ERROR${NORMAL}: Could not make package!"
        exit 1
    fi 

    # Create entry in AUR directory
    rm -rf $AURDIR/$PKG
    touch $AURDIR/$PKG

    exit 0
fi

if [ $MODE = uninstall ] || [ $MODE = u ]
then
    if [ $# != 2 ]
    then
        echo -e "${ERROR}ERROR${NORMAL}: You need to specify a package to uninstall!"
        exit 1
    fi

    # Uninstall package
    if [ ! -f $AURDIR/$PKG ]
    then
        echo -e "${ERROR}ERROR${NORMAL}: The package '$PKG' is not installed!"
        exit 1
    fi
    sudo pacman -R $PKG

    # Remove entry in AUR directory
    rm $AURDIR/$PKG -f

    exit 0
fi

if [ $MODE = query ] || [ $MODE = q ]
then
    if [ $# != 1 ]
    then
        echo -e "${ERROR}ERROR${NORMAL}: If you want to query for specific packages, use grep!"
        exit 1
    fi

    # Print all packages line-by-line
    ls $AURDIR -w 1

    exit 0
fi

echo -e "${ERROR}ERROR${NORMAL}: You've selected an invalid mode! Try 'aur help'"
exit 1
