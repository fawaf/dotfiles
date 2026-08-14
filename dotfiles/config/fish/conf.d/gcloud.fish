# conf.d/gcloud.fish
# mirrors: dotfiles/zsh.conf.d/gcloud
# the sdk only ships path.fish.inc (no fish completion file)

if command -q brew
    set -l sdk_dir (brew --prefix)/share/google-cloud-sdk

    if test -d $sdk_dir; and test -f $sdk_dir/path.fish.inc
        source $sdk_dir/path.fish.inc
    end
end
