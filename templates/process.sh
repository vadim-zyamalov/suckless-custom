#!/usr/bin/env sh

check2 () {
    [ "$1" = "-s" -o "$1" = "--sources" ] && echo "$2" && echo "$USAGE" && exit 1
    [ "$1" = "-t" -o "$1" = "--templates" ] && echo "$2" && echo "$USAGE" && exit 1
    [ "$1" = "-v" -o "$1" = "--void" ] && echo "$2" && echo "$USAGE" && exit 1
}

USAGE="usage: ./process.sh (-s|--sources) SOURCES (-t|--templates) TEMPLATES (-v|--void) XBPS_SRC pkg[,[version][,[revision]]] ..."
cur_path=$(pwd)

[ $# -eq 0 ] && echo "ERROR: Empty input!" && echo "$USAGE" && exit 1

while [ $# -gt 0 ]; do
    case $1 in
        -s|--sources)
            check2 "$2" "ERROR: No sources dir provided"
            src_path="$(cd "$2"; pwd)"
            shift 2
            ;;
        -t|--templates)
            check2 "$2" "ERROR: No templates dir provided"
            tmp_path="$(cd "$2"; pwd)"
            shift 2
            ;;
        -v|--void)
            check2 "$2" "ERROR: No void-packages dir provided"
            pkg_path="$(cd "$2"; pwd)"
            shift 2
            ;;
        *)
            break
            ;;
    esac
done

[ -z "$src_path" ] && echo "ERROR: No sources path!" && echo "$USAGE" && exit 1
[ -z "$tmp_path" ] && echo "ERROR: No templates path!" && echo "$USAGE" && exit 1
[ -z "$pkg_path" ] && echo "ERROR: No void-packages path!" && echo "$USAGE" && exit 1

[ -z "$1" ] && echo "ERROR: No packages!" && echo "$USAGE" && exit 1

cd "$pkg_path"
git fetch
git pull

cd "$tmp_path"

while [ "$1" ]; do
    pkg=$(echo "$1" | awk 'BEGIN { RS = "[ \n]+"; FS = "," } { print $1 }')
    if [ -d "$pkg" ]; then
        echo "$pkg : prepare"
        
        version=$(echo "$1" | awk 'BEGIN { RS = "[ \n]+"; FS = "," } { print $2 }')
        [ ! -z "$version" ] && sed -i -e "s/^\(version=\)[0-9\.]\+$/\1$version/" "$tmp_path/$pkg/template"
        revision=$(echo "$1" | awk 'BEGIN { RS = "[ \n]+"; FS = "," } { print $3 }')
        [ ! -z "$revision" ] && sed -i -e "s/^\(revision=\)[0-9\.]\+$/\1$revision/" "$tmp_path/$pkg/template"

        config=$(/usr/bin/ls "$src_path/$pkg/config.h/" 2> /dev/null | grep -e "\.h$" | sort -r | head -n 1)
        patchf=$(/usr/bin/ls "$src_path/$pkg/patches/" 2> /dev/null | grep -e "\.diff$" | sort -r | head -n 1)

        [ -f "$tmp_path/$pkg/files/config.h" ] && [ ! -z "$config" ] && echo "$pkg : config.h" && rm "$tmp_path/$pkg/files/config.h" && cp "$src_path/$pkg/config.h/$config" "$tmp_path/$pkg/files/config.h"
        [ -f "$tmp_path/$pkg/files/patch.diff" ] && [ ! -z "$patchf" ] && echo "$pkg : patch.diff" && rm "$tmp_path/$pkg/files/patch.diff" && cp "$src_path/$pkg/patches/$patchf" "$tmp_path/$pkg/files/patch.diff"

        cd "$pkg_path"
        
        [ -d "$pkg_path/srcpkgs/$pkg" ] && mv "$pkg_path/srcpkgs/$pkg" "$pkg_path/srcpkgs/${pkg}.bak"
        cp -r "$tmp_path/$pkg" "$pkg_path/srcpkgs/"

        del=$(/usr/bin/ls "$pkg_path/hostdir/binpkgs" | grep -e "^$pkg-[0-9\.]\+_[0-9]\+.*\.xbps")
        [ ! -z "$del" ] && rm "$pkg_path/hostdir/binpkgs/$del"

        ./xbps-src pkg "$pkg"

        rm -rf "$pkg_path/srcpkgs/$pkg"
        [ -d "$pkg_path/srcpkgs/${pkg}.bak" ] && mv "$pkg_path/srcpkgs/${pkg}.bak" "$pkg_path/srcpkgs/$pkg"
        cd "$tmp_path"
    fi
    shift
done

cd "$cur_path"

