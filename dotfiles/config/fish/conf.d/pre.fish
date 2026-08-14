# conf.d/pre.fish
# mirrors: dotfiles/zsh.conf.d/pre (preexec/precmd)

# tab title (mirrors preexec + set_titlebar)
# fish sets the terminal title natively via fish_title before each
# prompt and command
function fish_title
    set -l cmd (status current-command)
    if test "$cmd" = fish
        set cmd (prompt_pwd)
    end
    echo "$TAB_TITLE_PREFIX$cmd"
end

# clean prompt toggle (mirrors rp); fish_prompt checks $RP
function rp
    if set -q RP
        set -e RP
    else
        set -g RP 1
    end
    clear
end

# mirrors precmd exporting THEME_MODE every prompt
if test (uname -s) = Darwin
    function __update_theme_mode --on-event fish_prompt
        set -gx THEME_MODE (defaults read -g AppleInterfaceStyle 2>/dev/null)
    end
end
