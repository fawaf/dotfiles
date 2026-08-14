# conf.d/prompt.fish
# mirrors: dotfiles/zsh.conf.d/prompt + zsh.pre.d/colors
# Fish uses fish_prompt / fish_right_prompt functions for the prompt.

# Call set_host_variables on startup (mirrors prompt.fish calling set_host_variables)
set_host_variables

function fish_prompt
    set -l last_status $status

    # Clean prompt mode (mirrors the RP check in zsh.conf.d/pre precmd;
    # toggled by the rp function)
    if set -q RP
        echo -n (date)" $USER@"(hostname -s):(prompt_pwd)"% "
        return
    end

    # Colors
    set -l reset (set_color normal)
    set -l red (set_color red)
    set -l green (set_color green)
    set -l blue (set_color blue)
    set -l cyan (set_color cyan)
    set -l magenta (set_color magenta)
    set -l yellow (set_color yellow)
    set -l bold_yellow (set_color --bold yellow)
    set -l bg_red (set_color --background red)

    # User color: root=yellow-on-red, else green
    if test $USER = root
        set user_str "$bg_red$bold_yellow$USER$reset"
    else
        set user_str "$green$USER$reset"
    end

    # Host display
    set host_str "$blue$REALHOST$reset"

    # Directory (truncated to 15 chars like %15~ in zsh)
    set dir_str "$red"(prompt_pwd --full-length-dirs 1)"$reset"

    # Git info (mirrors vcs_info)
    set git_str ""
    if command -q git
        set -l branch (git symbolic-ref --short HEAD 2>/dev/null)
        if test -n "$branch"
            set -l git_dirty ""
            if not git diff --quiet 2>/dev/null
                set git_dirty "*"
            end
            set git_str " | vcs: $blue"git"$reset | branch: $green$branch$git_dirty$reset"
        end
    end

    # Show internal host if different from external (mirrors PS1 with INTERNALHOST)
    set host_extra ""
    if test -n "$INTERNALHOST" -a -n "$EXTERNALHOST" -a "$INTERNALHOST" != "$EXTERNALHOST"
        set host_extra " ($INTERNALHOST)"
    end

    # Prompt char: # for root, % for user
    if test $USER = root
        set prompt_char "$red#$reset"
    else
        set prompt_char "$magenta%$reset"
    end

    echo -n "$user_str@$host_str$host_extra | dir: $dir_str$git_str"
    echo ""
    echo -n "$prompt_char "
end

function fish_right_prompt
    set -l last_status $status
    set -l reset (set_color normal)
    set -l red (set_color red)
    set -l cyan (set_color cyan)

    # Exit status (mirrors %(?..$PR_RED [%?]$PR_NO_COLOR) in RPS1)
    set status_str ""
    if test $last_status -ne 0
        set status_str "$red[$last_status]$reset "
    end

    # Date/time (mirrors %D{%Y-%m-%d %H:%M:%S %Z} (%D{%Y.%V}))
    set date_str "$cyan"(date '+%Y-%m-%d %H:%M:%S %Z')" ("(date '+%Y.%V')")"$reset

    echo -n "$status_str$date_str"
end

# Custom prompt override if present
set -l CUST_PROMPT "$HOME/.config/fish/custom.d/prompt.fish"
if test -f $CUST_PROMPT
    source $CUST_PROMPT
end
