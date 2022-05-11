if status is-interactive
    # Commands to run in interactive sessions can go here
end

alias vim lvim
alias lf lfub

# nightlight
if test -z "$REDSHIFT_TEMP"
    set -Ux REDSHIFT_TEMP 6500
end
redshift -P -O $REDSHIFT_TEMP > /dev/null 2> /dev/null

export PATH=/home/vuser/.local/bin:/usr/local/sbin:/usr/local/bin:/usr/bin:/usr/bin/site_perl:/usr/bin/vendor_perl:/usr
export EDITOR=lvim
