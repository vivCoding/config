#!/bin/bash

# File preview handler for lf.

set -C -f
IFS="$(printf '%b_' '\n')"; IFS="${IFS%_}"

ifub() {
	[ -n "$DISPLAY" ] && [ -z "$WAYLAND_DISPLAY" ] && command -V ueberzug >/dev/null 2>&1
}

# Note that the cache file name is a function of file information, meaning if
# an image appears in multiple places across the machine, it will not have to
# be regenerated once seen.

case "$(file --dereference --brief --mime-type -- "$1")" in
	image/* )
        if command -v mediainfo &> /dev/null; then
            echo "Rendering with mediainfo" 
            mediainfo "$1" || exit 1
        else
            echo "mediainfo not found!"
        fi
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
        if command -v mediainfo &> /dev/null; then
            echo "Rendering with mediainfo" 
            mediainfo "$1" || exit 1
        else
            echo "mediainfo not found!"
        fi
        ;;
    */pdf)
        if command -v mediainfo &> /dev/null; then
            echo "Rendering with mediainfo" 
            mediainfo "$1" || exit 1
        else
            echo "mediainfo not found!"
        fi
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
