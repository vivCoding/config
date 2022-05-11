function fish_greeting
    echo -en "Welcome back "
    set_color cyan
    echo -en (whoami)
    set_color normal
    echo -en "!\n"
end
