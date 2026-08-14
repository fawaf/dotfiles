# functions/set_titlebar.fish
# mirrors: dotfiles/zsh.functions.d/terminal (set_titlebar)
# note: fish normally sets the title via fish_title (see conf.d/pre.fish);
# this is kept for manual use

function set_titlebar --description "set_titlebar short-title descriptive-title"
    switch "$TERM"
        case 'xterm*' 'screen*'
            printf '\033]0;%s\a' "$argv[2]"
        case alacritty
            printf '\e]2;%s\e\\' "$argv[2]"
        case '*'
            # don't do anything for all other terminals
    end
end
