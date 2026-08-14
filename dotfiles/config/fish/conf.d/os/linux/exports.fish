# conf.d/os/linux/exports.fish
# mirrors: dotfiles/zsh.linux.d/exports
# guarded because fish may define these itself

if not set -q GID
    set -gx GID (id -g)
end
if not set -q UID
    set -gx UID (id -u)
end
