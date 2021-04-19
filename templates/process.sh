#!/usr/bin/env sh

[ ! "$1" ] && echo "Input needed: enter any program name!" && exit

cur_path="$(pwd)"
pkg_path="/home/zyamalov/git/void-packages"

while [ "$1" ]; do
    if [ -d "$1" ]; then
        echo "$1 : prepare"

        config=$(/usr/bin/ls "../sources/$1/config.h/" 2> /dev/null | grep -e "\.h$" | sort -r | head -n 1)
        patchf=$(/usr/bin/ls "../sources/$1/patches/" 2> /dev/null | grep -e "\.diff$" | sort -r | head -n 1)

        [ -f "$d/files/config.h" ] && [ ! -z "$config" ] && echo "$1 : config.h" && rm "$1/files/config.h" && cp "../sources/$1/config.h/$config" "$1/files/config.h"
        [ -f "$d/files/patch.diff" ] && [ ! -z "$patchf" ] && echo "$1 : patch.diff" && rm "$1/files/patch.diff" && cp "../sources/$1/patches/$patchf" "$1/files/patch.diff"

        rm -r "$pkg_path/srcpkgs/$1"
        cp -r "$1" "$pkg_path/srcpkgs/"

        del=$(/usr/bin/ls "$pkg_path/hostdir/binpkgs" | grep -e "^$1-[0-9\.]\+_[0-9]\+.*\.xbps")
        [ ! -z "$del" ] && rm "$pkg_path/hostdir/binpkgs/$del"

        cd "$pkg_path"
        ./xbps-src pkg "$1"
        cd "$cur_path"
    fi
    shift
done
