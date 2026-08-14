# conf.d/os/debian/aliases.fish
# mirrors: dotfiles/zsh.debian.d/aliases

abbr --add aa 'tail --follow --retry /var/log/apache2/access.log'
abbr --add ae 'tail --follow --retry /var/log/apache2/error.log'
abbr --add ags 'sudo systemctl reload apache2'
abbr --add arl ags
abbr --add ars ags
abbr --add asc "$SUDO sudo apache2ctl -S"
abbr --add brl 'sudo systemctl reload bind9'
abbr --add brs 'sudo systemctl restart bind9'
abbr --add cmail 'cat /var/log/mail.log'
abbr --add cs 'cat /var/log/syslog'
abbr --add drs 'sudo systemctl restart isc-dhcp-server'
abbr --add prl 'sudo systemctl reload postfix'
abbr --add prs 'sudo systemctl restart postfix'
abbr --add sa 'tail --follow --retry /var/log/apache2/ssl_access.log'
abbr --add se 'tail --follow --retry /var/log/apache2/ssl_error.log'
abbr --add td 'tail --follow --retry /var/log/dhcp.log'
abbr --add tmail 'tail --follow --retry /var/log/mail.log'
abbr --add tm 'top -o +%MEM -d 1'
abbr --add tna 'tail --follow --retry /var/log/named/*.log'
abbr --add tn 'tail --follow --retry /var/log/named/named.log'
abbr --add tq 'tail --follow --retry /var/log/named/query.log'
abbr --add ts 'tail --follow --retry /var/log/syslog'
abbr --add update "$SUDO apt update && $SUDO apt full-upgrade --assume-yes"
abbr --add www 'cd /var/www'
