# conf.d/os/suse/aliases.fish
# mirrors: dotfiles/zsh.suse.d/aliases-suse

abbr --add aa 'tail --follow --retry /var/log/apache2/access.log'
abbr --add ae 'tail --follow --retry /var/log/apache2/error.log'
abbr --add ags 'sudo service apache2 graceful'
abbr --add arl 'sudo service apache2 reload'
abbr --add ars ags
abbr --add asc "$SUDO apache2ctl -S"
abbr --add brl 'sudo service bind9 reload'
abbr --add brs 'sudo service bind9 restart'
abbr --add faa 'tail --follow --retry /var/log/apache2/fawong.com/access.log'
abbr --add fae 'tail --follow --retry /var/log/apache2/fawong.com/error.log'
abbr --add fsa 'tail --follow --retry /var/log/apache2/fawong.com/ssl_access.log'
abbr --add fse 'tail --follow --retry /var/log/apache2/fawong.com/ssl_error.log'
abbr --add kaa 'tail --follow --retry /var/log/apache2/kirinas.com/access.log'
abbr --add kae 'tail --follow --retry /var/log/apache2/kirinas.com/error.log'
abbr --add ksa 'tail --follow --retry /var/log/apache2/kirinas.com/ssl_access.log'
abbr --add kse 'tail --follow --retry /var/log/apache2/kirinas.com/ssl_error.log'
abbr --add sa 'tail --follow --retry /var/log/apache2/ssl_access.log'
abbr --add se 'tail --follow --retry /var/log/apache2/ssl_error.log'
abbr --add t 'top -o +%CPU -d 1'
abbr --add update "$SUDO zypper refresh && $SUDO zypper upgrade"
abbr --add www 'cd /var/www'
abbr --add xaa 'tail --follow --retry /var/log/apache2/xilef.org/access.log'
abbr --add xae 'tail --follow --retry /var/log/apache2/xilef.org/error.log'
abbr --add xsa 'tail --follow --retry /var/log/apache2/xilef.org/ssl_access.log'
abbr --add xse 'tail --follow --retry /var/log/apache2/xilef.org/ssl_error.log'
