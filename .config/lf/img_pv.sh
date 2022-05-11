#!/bin/bash

# File preview handler for lf.

set -C -f
IFS="$(printf '%b_' '\n')"; IFS="${IFS%_}"

image() {
	if [ -f "$1" ] && [ -n "$DISPLAY" ] && [ -z "$WAYLAND_DISPLAY" ] && command -V ueberzug >/dev/null 2>&1; then
        printf '{"action": "add", "identifier": "PREVIEW", "x": "%s", "y": "%s", "width": "%s", "height": "%s", "scaler": "contain", "path": "%s"}\n' "$4" "$5" "$(($2-1))" "$(($3-1))" "$1" > "$FIFO_UEBERZUG"
	else
        mediainfo "$6"
    fi
}

ifub() {
	[ -n "$DISPLAY" ] && [ -z "$WAYLAND_DISPLAY" ] && command -V ueberzug >/dev/null 2>&1
}

# Note that the cache file name is a function of file information, meaning if
# an image appears in multiple places across the machine, it will not have to
# be regenerated once seen.

case "$(file --dereference --brief --mime-type -- "$1")" in
	image/* )
        image "$1" "$2" "$3" "$4" "$5" "$1"
        ;;
	text/html)
        if command -v lynx &> /dev/null; then
            echo "Rendering with lynx"
            lynx -width="$4" -display_charset=utf-8 -dump "$1"
        else
            echo "lynx not found! Using cat instead"
            cat $1
        fi
        ;;
	text/troff)
        echo "Rendering with man"
        man ./ "$1" | col -b
        ;;
	text/* | */xml | application/json)
        if command -v bat &> /dev/null; then
            echo "Rendering with bat" 
            bat --terminal-width "$(($4-2))" -f "$1"
        else
            echo "bat not found! Using cat instead"
            cat $1
        fi
        ;;
	application/zip)
        if command -v atool &> /dev/null; then
            echo "Rendering with atool"
            atool --list -- "$1"
        else
            echo "atool not found!"
        fi
        ;;
	audio/* | application/octet-stream)
        if command -v mediainfo &> /dev/null; then
            echo "Rendering with mediainfo" 
            mediainfo "$1" || exit 1
        else
            echo "mediainfo not found!"
        fi
        ;;
	video/* )
		CACHE="${XDG_CACHE_HOME:-$HOME/.cache}/lf/thumb.$(stat --printf '%n\0%i\0%F\0%s\0%W\0%Y' -- "$(readlink -f "$1")" | sha256sum | cut -d' ' -f1)"
		[ ! -f "$CACHE" ] && ffmpegthumbnailer -i "$1" -o "$CACHE" -s 0
		image "$CACHE" "$2" "$3" "$4" "$5" "$1"
		;;
    */pdf)
		CACHE="${XDG_CACHE_HOME:-$HOME/.cache}/lf/thumb.$(stat --printf '%n\0%i\0%F\0%s\0%W\0%Y' -- "$(readlink -f "$1")" | sha256sum | cut -d' ' -f1)"
		[ ! -f "$CACHE.jpg" ] && pdftoppm -jpeg -f 1 -singlefile "$1" "$CACHE"
		image "$CACHE.jpg" "$2" "$3" "$4" "$5" "$1"
		;;
    *opendocument* )
        if command -v odt2txt &> /dev/null; then
            echo "Rendering with odt2txt"
            odt2txt "$1"
        else
            echo "odt2txt not found!"
        fi
        ;;
	application/pgp-encrypted)
        gpg -d -- "$1"
        ;;
esac
exit 1
