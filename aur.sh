#!/bin/bash

DIR=$HOME/AUR
MODE=$1
PKG=$2

if [ -z $MODE ]
then
    echo "ERROR: You need to select a mode! Try 'aur help'!"
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
        echo "ERROR: You need to specify a package to install!"
        exit 1
    fi

    # Create necessary AUR directory
    mkdir -p $DIR
    cd $DIR

    # Clone package
    if ! git clone https://aur.archlinux.org/$PKG.git
    then
        cd $DIR
        rm -rf $DIR/$PKG

        echo "ERROR: Could not clone package!"
        exit 1
    fi
    cd $DIR/$PKG

    # Make & install package
    if ! makepkg -sri
    then
        cd $DIR
        rm -rf $DIR/$PKG

        echo "ERROR: Could not make package!"
        exit 1
    fi 

    # Create entry in AUR directory
    rm -rf $DIR/$PKG
    touch $DIR/$PKG

    exit 0
fi

if [ $MODE = uninstall ] || [ $MODE = u ]
then
    if [ $# != 2 ]
    then
        echo "ERROR: You need to specify a package to uninstall!"
        exit 1
    fi

    # Uninstall package
    if [ ! -f $DIR/$PKG ]
    then
        echo "ERROR: The package '$PKG' is not installed!"
        exit 1
    fi
    sudo pacman -R $PKG

    # Remove entry in AUR directory
    rm $DIR/$PKG -f

    exit 0
fi

if [ $MODE = query ] || [ $MODE = q ]
then
    if [ $# != 1 ]
    then
        echo "ERROR: If you want to query for specific packages, use grep!"
        exit 1
    fi

    # Print all packages line-by-line
    ls $DIR -w 1

    exit 0
fi

echo "ERROR: You've selected an invalid mode! Try 'aur help'"
exit 1