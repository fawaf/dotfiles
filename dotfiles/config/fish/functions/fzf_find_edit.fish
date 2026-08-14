# functions/fzf_find_edit.fish
# mirrors: fzf_find_edit in dotfiles/zsh.conf.d/fzf.zsh

function fzf_find_edit --description "Pick a file with fzf and edit it"
    set -l file (fzf --no-multi --preview 'bat --color=always --line-range :500 {}')
    if test -n "$file"
        $EDITOR $file
    end
end
