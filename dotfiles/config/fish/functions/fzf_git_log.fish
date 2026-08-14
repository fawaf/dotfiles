# functions/fzf_git_log.fish
# mirrors: fzf_git_log in dotfiles/zsh.conf.d/fzf.zsh

function fzf_git_log --description "Browse git log with fzf and show picked commits"
    set -l commits (git ll --color=always $argv | \
        fzf --ansi --no-sort --height 100% \
            --preview "echo {} | grep -o '[a-f0-9]\{7\}' | head -1 |
                       xargs -I@ sh -c 'git show --color=always @'")
    if test -n "$commits"
        set -l hashes (printf '%s\n' $commits | cut -d' ' -f2 | tr '\n' ' ' | string split -n ' ')
        git show $hashes
    end
end
