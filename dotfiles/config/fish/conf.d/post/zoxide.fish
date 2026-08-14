# conf.d/post/zoxide.fish
# mirrors: dotfiles/zsh.post.d/zoxide
# aka z

if not set -q DISABLE_ZOXIDE
    if command -q zoxide
        zoxide init fish | source

        for pth in $CDPATH
            zoxide add $pth 2>/dev/null
        end
    end
end
