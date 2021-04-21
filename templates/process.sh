#!/usr/bin/env sh

[ ! "$1" ] && echo "Input needed: enter any program name!" && echo "usage: ./process.sh pkg[,[version][,[revision]]] ..." && exit

cur_path="$(pwd)"
pkg_path="/home/zyamalov/git/void-packages"

while [ "$1" ]; do
    pkg=$(echo "$1" | awk 'BEGIN { RS = "[ \n]+"; FS = "," } { print $1 }')
    if [ -d "$pkg" ]; then
        echo "$pkg : prepare"
        
        version=$(echo "$1" | awk 'BEGIN { RS = "[ \n]+"; FS = "," } { print $2 }')
        [ ! -z "$version" ] && sed -i -e "s/^\(version=\)[0-9\.]\+$/\1$version/" "$pkg/template"
        revision=$(echo "$1" | awk 'BEGIN { RS = "[ \n]+"; FS = "," } { print $3 }')
        [ ! -z "$revision" ] && sed -i -e "s/^\(revision=\)[0-9\.]\+$/\1$revision/" "$pkg/template"

        config=$(/usr/bin/ls "../sources/$pkg/config.h/" 2> /dev/null | grep -e "\.h$" | sort -r | head -n 1)
        patchf=$(/usr/bin/ls "../sources/$pkg/patches/" 2> /dev/null | grep -e "\.diff$" | sort -r | head -n 1)

        [ -f "$pkg/files/config.h" ] && [ ! -z "$config" ] && echo "$pkg : config.h" && rm "$pkg/files/config.h" && cp "../sources/$pkg/config.h/$config" "$pkg/files/config.h"
        [ -f "$pkg/files/patch.diff" ] && [ ! -z "$patchf" ] && echo "$pkg : patch.diff" && rm "$pkg/files/patch.diff" && cp "../sources/$pkg/patches/$patchf" "$pkg/files/patch.diff"

        rm -r "$pkg_path/srcpkgs/$pkg"
        cp -r "$pkg" "$pkg_path/srcpkgs/"

        del=$(/usr/bin/ls "$pkg_path/hostdir/binpkgs" | grep -e "^$pkg-[0-9\.]\+_[0-9]\+.*\.xbps")
        [ ! -z "$del" ] && rm "$pkg_path/hostdir/binpkgs/$del"

        cd "$pkg_path"
        ./xbps-src pkg "$pkg"
        cd "$cur_path"
    fi
    shift
done
