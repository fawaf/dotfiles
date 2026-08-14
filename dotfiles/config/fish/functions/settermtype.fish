# functions/settermtype.fish
# mirrors: dotfiles/zsh.functions.d/terminal (settermtype)
# If ncurses is installed, use tput to gracefully degrade termtypes.

function settermtype --description "Pick the first terminal type ncurses recognizes"
    if not command -q tput
        return
    end

    # keep the current TERM if ncurses already knows it
    if test -n "$TERM"; and tput -T "$TERM" longname >/dev/null 2>/dev/null
        return
    end

    set -l terminal_types xterm-256color xterm-color xtermc xterm \
        screen.xterm-256color vscreen-256color-bce screen \
        screen-256color screen-bce \
        tmux-256color tmux \
        t100 dumb

    for termtype in $terminal_types
        if tput -T $termtype longname >/dev/null 2>/dev/null
            set -gx TERM $termtype
            break
        end
    end
end
