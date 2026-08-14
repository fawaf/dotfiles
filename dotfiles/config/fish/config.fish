# rc -- fish
# mirrors: dotfiles/zshrc

# Disable greeting
set fish_greeting ""

# Source all functions first (mirrors zshenv functions loading)
for file in $HOME/.config/fish/functions/*.fish
    if test -r $file
        source $file
    end
end

# Pre conf.d (mirrors .zsh.pre.d/*)
for file in $HOME/.config/fish/conf.d/pre/*.fish
    if test -r $file
        source $file
    end
end

# Custom pre (mirrors .zsh.custom.pre.d/*)
set CUST_PRE "$HOME/.config/fish/custom.pre.d"
if test -d $CUST_PRE
    for file in $CUST_PRE/*.fish
        if test -r $file
            source $file
        end
    end
end

# Main conf.d (mirrors .zsh.conf.d/*)
# (fish automatically sources ~/.config/fish/conf.d/*.fish, so this is for completeness)

# Custom conf.d (mirrors .zsh.custom.d/*)
set CUST_DIR "$HOME/.config/fish/custom.d"
if test -d $CUST_DIR
    for file in $CUST_DIR/*.fish
        if test -r $file
            source $file
        end
    end
end

# OS-specific dotfiles (mirrors source_os_dotfiles zshrc)
source_os_dotfiles rc

# Disable messages from other users (mirrors `mesg n` in zshrc)
if status is-interactive; and command -q mesg
    mesg n 2>/dev/null
end

# Warn when no IP was detected (mirrors zshrc)
if status is-interactive; and test -z "$HOST_IP"
    echo_color red "No IP address(es) detected"
end

# iterm2 shell integration (mirrors zshrc; fish variant)
if test -e "$HOME/.iterm2_shell_integration.fish"
    source "$HOME/.iterm2_shell_integration.fish"
end

# Post conf.d (mirrors .zsh.post.d/*)
for file in $HOME/.config/fish/conf.d/post/*.fish
    if test -r $file
        source $file
    end
end

# Custom post (mirrors .zsh.custom.post.d/*)
set CUST_POST "$HOME/.config/fish/custom.post.d"
if test -d $CUST_POST
    for file in $CUST_POST/*.fish
        if test -r $file
            source $file
        end
    end
end

# Login shell tasks (mirrors dotfiles/login -> .zlogin)
if status is-login
    set -gx LANG en_US.UTF-8

    # remove part files
    for dir in Downloads Desktop
        for file in $HOME/$dir/*.part
            test -f $file; and rm -f $file
        end
    end

    # garbage checks
    command -q uptime; and uptime >&2
    command -q klist; and klist >&2 2>/dev/null

    set -e LS_COLORS

    # custom login (mirrors .zsh.custom.login.d/*)
    set -l CUST_LOGIN "$HOME/.config/fish/custom.login.d"
    if test -d $CUST_LOGIN
        for file in $CUST_LOGIN/*.fish
            if test -r $file
                source $file
            end
        end
    end
end

# Logout tasks (mirrors dotfiles/logout -> .zlogout)
function __dotfiles_logout --on-event fish_exit
    status is-login; or return

    if test "$KILL_SSH_AGENT_ON_LOGOUT" = true
        ssh-agent -k >/dev/null 2>&1
    end

    # clear cached sudo credentials
    if command -q sudo
        sudo -k 2>/dev/null
        sudo -K 2>/dev/null
    end

    rm -f "$HOME"/.bash_history

    if test -e /usr/bin/kdestroy
        kdestroy 2>/dev/null
    end

    # custom logout (mirrors .zsh.custom.logout.d/*)
    set -l CUST_LOGOUT "$HOME/.config/fish/custom.logout.d"
    if test -d $CUST_LOGOUT
        for file in $CUST_LOGOUT/*.fish
            if test -r $file
                source $file
            end
        end
    end

    clear
end

# Change to home on login (mirrors `cd ~` in zshrc)
cd ~
