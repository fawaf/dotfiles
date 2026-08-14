# conf.d/chmods.fish
# mirrors: dotfiles/zsh.conf.d/chmods

if test -d $HOME/.gnupg
    chmod -f 700 $HOME/.gnupg
end

if test -f $HOME/.fetchmailrc
    chmod -f 600 $HOME/.fetchmailrc
end

if test -f $HOME/.muttrc
    chmod -f 640 $HOME/.muttrc
end
