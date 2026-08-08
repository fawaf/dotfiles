# conf.d/exports.fish
# mirrors: dotfiles/zsh.conf.d/exports

# ============================================================
# less
# ============================================================
set -gx LESS "--RAW-CONTROL-CHARS --LONG-PROMPT --IGNORE-CASE"
set -gx LESS_TERMCAP_mb \e'[1;32m'
set -gx LESS_TERMCAP_md \e'[1;31m'
set -gx LESS_TERMCAP_so \e'[01;44;37m'
set -gx LESS_TERMCAP_us \e'[01;34m'
set -gx LESS_TERMCAP_me \e'[0m'
set -gx LESS_TERMCAP_se \e'[0m'
set -gx LESS_TERMCAP_ue \e'[0m'
set -gx GROFF_NO_SGR 1

# ============================================================
# regular exports
# ============================================================
set -gx BASH_COMP_DEBUG_FILE /tmp/bash_debug.log
set -gx BAT_PAGER most
set -gx BAT_THEME ansi
set -gx CASE_SENSITIVE true
set -gx CC gcc
set -gx DISABLE_FIG true
set -gx EDITOR nvim
set -gx FZF_DEFAULT_COMMAND 'fd --type f --color=never'
set -gx FZF_CTRL_T_COMMAND $FZF_DEFAULT_COMMAND
set -gx FZF_ALT_C_COMMAND 'fd . $(git rev-parse --show-toplevel) --type d --exclude .git --color=never'
set -gx FZF_ALT_C_OPTS "--preview 'cd {} && basename {} && tree -C .' --delimiter $HOME/ --with-nth 2"
set -gx FZF_CTRL_T_OPTS "--preview 'bat --color=always --line-range :500 {}'"
set -gx GOPATH $HOME/go
set -gx LYNX_CFG_FILE $HOME/.lynxrc
set -gx LYNX_CFG $HOME/.lynxrc
set -gx MYSQL_PS1 '\u@\h using database \d \n(\c) > '
set -gx PAGER most
set -gx SUDO /usr/bin/sudo
set -gx SVN_EDITOR nvim
set -gx TERMINAL alacritty
set -gx TF_LOG debug
set -gx TF_LOG_PATH /tmp/terraform.log
set -gx VISUAL nvim
set -gx WWW_HOME https://www.google.com
set -gx XDG_CONFIG_HOME $HOME/.config
set -gx OPENSSL_CONF $XDG_CONFIG_HOME/openssl.cnf
set -gx NVM_DIR $HOME/.nvm

# ============================================================
# PATH construction (mirrors zsh exports path array)
# ============================================================
# fish manages PATH natively via fish_add_path; build it here
set -l paths \
    $GOPATH/bin \
    $HOME/bin \
    $HOME/.cargo/bin \
    $HOME/.krew/bin \
    $HOME/.local/android/platform-tools \
    $HOME/.local/android/tools \
    $HOME/.local/bin \
    $HOME/.rvm/bin \
    /bin \
    /sbin \
    /opt/aws/bin \
    /opt/local/bin \
    /opt/local/sbin \
    /snap/bin \
    /sw/bin \
    /sw/sbin \
    /usr/local/bin \
    /usr/local/sbin \
    /usr/bin \
    /usr/sbin \
    /usr/texbin \
    /usr/X11/bin \
    /opt/X11/bin

for p in $paths
    if test -d $p
        fish_add_path --append $p
    end
end

# homebrew
if test (uname) = Linux
    set -gx HOMEBREW /home/linuxbrew/.linuxbrew
else
    set -gx HOMEBREW /opt/homebrew
end
set -gx HOMEBREW_BIN $HOMEBREW/bin/brew
if test -f $HOMEBREW_BIN
    eval ($HOMEBREW_BIN shellenv)
end
if test -d $HOMEBREW/bin
    fish_add_path --prepend $HOMEBREW/sbin $HOMEBREW/bin
end

# GOPATH bin
if test -d $GOPATH/bin
    fish_add_path --prepend $GOPATH/bin
end

# ============================================================
# MANPATH
# ============================================================
set -gx MANPATH \
    /usr/local/share/man \
    /usr/share/man \
    /sw/share/man \
    /opt/local/share/man \
    $HOME/.local/share/man

# ============================================================
# KUBECONFIG (mirrors kubernetes section)
# ============================================================
set -l kubeconfigs $HOME/.kube/config
for c in $HOME/.kube/*.yaml
    if test -f $c
        set -a kubeconfigs $c
    end
end
set -gx KUBECONFIG (string join ':' $kubeconfigs)

# ============================================================
# CDPATH (mirrors zsh cdpath)
# ============================================================
# fish handles cdpath via $cdpath or $CDPATH
set -gx CDPATH . $HOME ..

# ============================================================
# OS-specific exports
# ============================================================
source_os_dotfiles exports
