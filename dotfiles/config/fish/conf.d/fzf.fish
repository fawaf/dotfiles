# conf.d/fzf.fish
# mirrors: dotfiles/zsh.conf.d/fzf.zsh
# FZF_* exports live in conf.d/exports.fish; ^o binding is applied in
# conf.d/key_bindings.fish via fish_user_key_bindings

if status is-interactive; and command -q fzf
    fzf --fish | source

    set -gx FZF_COMPLETION_OPTS '+c -x'
    set -gx FZF_DEFAULT_OPTS '
  --height 75% --multi
  --bind ctrl-f:page-down,ctrl-b:page-up
'

    abbr --add ffe fzf_find_edit
end
