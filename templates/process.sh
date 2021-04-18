#!/usr/bin/env sh

cur_path="$(pwd)"
pkg_path="/home/zyamalov/git/void-packages"

for d in *; do
    if [ -d "$d" ]; then
        echo "$d : prepare"
        config=$(/usr/bin/ls "../sources/$d/config.h/" 2> /dev/null | grep -e "\.h$" | sort -r | head -n 1)
        patchf=$(/usr/bin/ls "../sources/$d/patches/" 2> /dev/null | grep -e "\.diff$" | sort -r | head -n 1)
        # Update files (if any)
        [ -f "$d/files/config.h" ] && [ ! -z "$config" ] && echo "$d : config.h" && rm "$d/files/config.h" && cp "../sources/$d/config.h/$config" "$d/files/config.h"
        [ -f "$d/files/patch.diff" ] && [ ! -z "$patchf" ] && echo "$d : patch.diff" && rm "$d/files/patch.diff" && cp "../sources/$d/patches/$patchf" "$d/files/patch.diff"
        rm -r "$pkg_path/srcpkgs/$d"
        cp -r "$d" "$pkg_path/srcpkgs/"
    fi
done

rm "$pkg_path/hostdir/binpkgs/"*

for d in *; do
    if [ -d "$d" ]; then
        cd "$pkg_path"
        ./xbps-src pkg "$d"
        cd "$cur_path"
    fi
done

