#1/usr/bin/env bash
# uninstall script for philososhark

if [ ! -f "/usr/share/cows/shark.cow" ]; then
    printf "error:\tnothing to uninstall!\n"
    exit 2
fi

if [[ $(id -u) -ne 0 ]]; then
    printf "error:\tuninstall script must be run as root.\n"
    exit 1
fi

function removefile {
    if [ -f "$1" ]; then
        sudo rm -f $1
    fi
}

echo "bye bue. :c" | cowsay -f shark

removefile "/usr/share/fortune/sharkquotes"
removefile "/usr/share/fortune/sharkquotes.dat"
removefile "/usr/share/cows/shark.cow"
removefile "/usr/local/bin/philososhark"

printf "\n\nphilososhark successfully uninstalled.\n"
