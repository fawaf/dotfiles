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

# Change to home on login (mirrors `cd ~` in zshrc)
cd ~
