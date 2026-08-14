# conf.d/key_bindings.fish
# mirrors: dotfiles/zsh.conf.d/key_bindings (+ menu, which is zsh-only)
# zsh-only bits skipped: magic-space, push-line, menuselect bindings
# (fish's pager handles menu selection natively)

if status is-interactive
    # fish re-runs this whenever a keymap is (re)set, so fzf bindings
    # survive the fish_vi_key_bindings reset below
    function fish_user_key_bindings
        if functions -q fzf_key_bindings
            fzf_key_bindings
        end
        if functions -q fzf-file-widget
            bind \co fzf-file-widget
            bind -M insert \co fzf-file-widget
        end

        # mirrors bindkey '^r' history-incremental-search-backward
        bind -M insert \cr history-pager 2>/dev/null

        # mirrors bindkey "^[l"/"^[h" and alt-arrow word movement
        bind -M insert \el forward-word
        bind -M insert \eh backward-word
        bind -M insert \e\[1\;3C forward-word
        bind -M insert \e\[1\;3D backward-word
    end

    # mirrors bindkey -v
    fish_vi_key_bindings
end
