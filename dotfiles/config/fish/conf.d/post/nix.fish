# conf.d/post/nix.fish
# mirrors: dotfiles/zsh.post.d/nix (nix ships a fish variant that also
# handles PATH)

set -l nix_daemon /nix/var/nix/profiles/default/etc/profile.d/nix-daemon.fish
if test -e $nix_daemon
    source $nix_daemon
end
