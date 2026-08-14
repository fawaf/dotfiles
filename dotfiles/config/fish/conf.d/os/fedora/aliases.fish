# conf.d/os/fedora/aliases.fish
# mirrors: dotfiles/zsh.fedora.d/aliases

abbr --add brs 'sudo systemctl restart named'
abbr --add brl 'sudo systemctl reload named'
abbr --add cmail "$SUDO cat /var/log/maillog"
abbr --add cs "$SUDO cat /var/log/messages"
abbr --add faa "$SUDO tail --follow --retry /var/log/httpd/access.log"
abbr --add fae "$SUDO tail --follow --retry /var/log/httpd/error.log"
abbr --add fsa "$SUDO tail --follow --retry /var/log/httpd/ssl_access.log"
abbr --add fse "$SUDO tail --follow --retry /var/log/httpd/ssl_error.log"
abbr --add fsr "$SUDO tail --follow --retry /var/log/httpd/ssl_request.log"
abbr --add llc lsl
abbr --add lsl 'ls --lcontext'
abbr --add prs 'sudo systemctl restart postfix'
abbr --add prl 'sudo systemctl reload postfix'
abbr --add tmail "$SUDO tail --follow --retry /var/log/maillog"
abbr --add tse "$SUDO tail --follow --retry /var/log/secure"
abbr --add ts "$SUDO tail --follow --retry /var/log/messages"
abbr --add update "$SUDO yum update --assumeyes"
