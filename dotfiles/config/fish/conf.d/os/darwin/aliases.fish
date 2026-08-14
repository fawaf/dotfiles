# conf.d/os/darwin/aliases.fish
# mirrors: dotfiles/zsh.darwin.d/aliases

abbr --add catn 'cat -n'
abbr --add cdd "cd $HOME/Desktop"
abbr --add chmod 'chmod -v'
abbr --add cp 'cp -i -v'
abbr --add gls 'gls --group-directories-first --color=auto'
abbr --add 'l@' 'ls -l -@'
abbr --add lao 'ls -l --all -O'
abbr --add le 'ls -l -e'
abbr --add 'le@' 'ls -l -e --all -@'
abbr --add lea 'ls -l -e --all'
abbr --add llo 'ls -l -O'
abbr --add ln 'ln -v'
abbr --add ls 'gls --group-directories-first --color=auto'
abbr --add mv 'mv -i -v'
abbr --add rm 'rm -i -v'
abbr --add rmf 'rm -rfv'
abbr --add rsync 'rsync --archive --verbose --compress --hard-links --progress --timeout=5 --rsh=ssh'
abbr --add t 'top -o -cpu -s 1'
abbr --add tar gtar
abbr --add ua 'uname -a'
abbr --add unlink 'unlink -iv'

# mirrors `unalias rmdir`
abbr --erase rmdir 2>/dev/null
