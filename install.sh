#!/usr/bin/env bash
# install script for philososhark

function hasprog {
    [ -x "$(command -v $1)" ]
}

function pkinstall {
    echo "$1 not found, installing..."
    if hasprog "apt"; then 
        sudo apt install $1
    elif hasprog "apt-get"; then 
        sudo apt-get install $1
    elif hasprog "pacman"; then 
        sudo pacman -Sy $1
    else
        printf "error:\tcannot detect package manager, please install $1 yourself.\n"
        exit 2
    fi
}

function fileinstall {
    if [ -f "$2" ]; then
        sudo rm -f $2
    fi
    sudo cp $1 $2
}

# we need root, check for that
if [[ $(id -u) -ne 0 ]]; then
    printf "error:\tinstall script must be run as root.\n"
    exit 1
fi

# make sure both cowsay and fortune are installed
if ! hasprog "cowsay"; then
    pkinstall "cowsay";
fi

if ! hasprog "fortune"; then
    pkinstall "fortune-mod";
fi

# create a new data pointer
if [ -f "sharkquotes.dat" ]; then
    rm "sharkquotes.dat"
fi
strfile "sharkquotes" "sharkquotes.dat"

# install all our files
mkdir -p "/usr/share/fortune"
fileinstall "sharkquotes" "/usr/share/fortune/sharkquotes"
fileinstall "sharkquotes.dat" "/usr/share/fortune/sharkquotes.dat"

mkdir -p "/usr/local/share/cows"
fileinstall "shark.cow" "/usr/share/cows/shark.cow"

fileinstall "philososhark" "/usr/local/bin/philososhark"
