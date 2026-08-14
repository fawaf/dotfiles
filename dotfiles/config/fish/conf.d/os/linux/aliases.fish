# conf.d/os/linux/aliases.fish
# mirrors: dotfiles/zsh.linux.d/aliases

abbr --add ags 'sudo systemctl reload httpd'
abbr --add am alsamixer
abbr --add arl ags
abbr --add ars ags
abbr --add asc "$SUDO httpd -S"
abbr --add chl 'tail --follow --retry /var/log/chef/client.log'
abbr --add chmod 'chmod --verbose'
abbr --add cp 'cp --interactive --verbose'
abbr --add i6l "$SUDO ip6tables --list"
abbr --add iln "$SUDO iptables --list --table nat --numeric"
abbr --add ilnv "$SUDO iptables --list --table nat --numeric --verbose"
abbr --add il "$SUDO iptables --list --numeric"
abbr --add ilvn "$SUDO iptables --list --verbose --numeric"
abbr --add ilv "$SUDO iptables --list --verbose"
abbr --add ks 'kill -SIGUSR1'
abbr --add maims 'maim --select'
abbr --add maimsc 'maim --select | xclip -target image/png'
abbr --add nrl 'sudo systemctl reload nginx'
abbr --add nrs 'sudo systemctl restart nginx'
abbr --add nss 'sudo systemctl start nginx'
abbr --add nrt 'sudo nginx -t'
abbr --add ns 'netstat -tln'
abbr --add nsp "$SUDO netstat --tcp --listening --numeric --program"
abbr --add nspu "$SUDO netstat --tcp --listening --numeric --program --udp"
abbr --add psf 'ps afjwwwwwx'
abbr --add psw 'ps afuwwwwwx'
abbr --add rsync 'rsync --iconv=utf8,utf8 --archive --verbose --compress --hard-links --progress --timeout=5 --rsh=ssh'
abbr --add scrots "scrot --select --exec 'mv \$f /tmp/'"
abbr --add t 'top -o +%CPU -d 1'
abbr --add ud update
abbr --add ur "$SUDO ufw reload"
abbr --add us "$SUDO ufw status"
abbr --add usn "$SUDO ufw status numbered"
abbr --add www 'cd /var/www'
