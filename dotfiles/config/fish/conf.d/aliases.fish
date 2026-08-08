# conf.d/aliases.fish
# mirrors: dotfiles/zsh.conf.d/aliases

# Core aliases
abbr --add a alias
abbr --add c clear
abbr --add d dir
abbr --add e exit
abbr --add h htop
abbr --add l ls
abbr --add m mutt
abbr --add p pwd
abbr --add q exit

abbr --add eb 'exec bash'
abbr --add ef 'exec fish'
abbr --add es 'exec startx'

# cat / bat
abbr --add cat bat
abbr --add catn 'bat --number'

# cd
abbr --add cd z
abbr --add 'cd..' 'cd ..'
abbr --add dc cd

# chmod / chown
abbr --add chown 'chown --verbose'
abbr --add chmod 'chmod --verbose'

# crontab
abbr --add ce 'crontab -e'
abbr --add cl 'crontab -l'

# df / du
abbr --add dh 'df --human-readable'

# diff
abbr --add diff 'diff --unified'

# dir / ls core
abbr --add dir ls
abbr --add sl ls
abbr --add ls 'ls --group-directories-first --color=auto'
abbr --add l1 'ls -1'
abbr --add la 'ls --all'
abbr --add lal lla
abbr --add lf 'ls --classify'
abbr --add lh llh
abbr --add ll 'ls -l'
abbr --add lla 'ls --all -l'
abbr --add llh 'ls --human-readable -l'
abbr --add llr 'ls -l --recursive'
abbr --add llra 'ls -l --recursive --all'
abbr --add llrh 'ls -l --recursive --human-readable'
abbr --add ln 'ln --verbose'
abbr --add lns 'ln --symbolic'
abbr --add lr 'ls --recursive'
abbr --add lra 'ls --recursive --all'
abbr --add lss 'ls --size'
abbr --add lsss 'ls -S --size'
abbr --add lt 'ls --almost-all -C --classify --no-group -l -t --human-readable --reverse'

# reverse/time sorted ls
abbr --add lltr 'ls -l -t --reverse'
abbr --add ltr 'ls -t --reverse'

# find
abbr --add fna "find . -not -path '*.svn/*' -not -path '*.git/*'"
abbr --add fng "find . -not -path '*.git/*'"
abbr --add fns "find . -not -path '*.svn/*'"

# grep
abbr --add grep 'grep --line-number --color'
abbr --add gerp grep
abbr --add grpe grep

# htop
abbr --add ht 'htop --delay 10 --sort-key PERCENT_CPU'

# kill
abbr --add ka killall
abbr --add ki kill

# kubectl
abbr --add kc kubectl
abbr --add kct kctx
abbr --add kctx 'kubie ctx'
abbr --add kn 'kubie ns'

# less
abbr --add lessn 'less --LINE-NUMBERS'

# ln
abbr --add lookup 'dig +noall +answer'

# make
abbr --add mc 'make clean'
abbr --add mcp 'mvn clean package'

# misc
abbr --add fiel file
abbr --add fcx 'fortune | cowsay | xclip'
abbr --add g gr
abbr --add how "how $EDITOR"
abbr --add hsot host
abbr --add lo locusts

# mosh
abbr --add mosh 'mosh --ssh=/usr/bin/ssh'
abbr --add motd 'cat /etc/motd'
abbr --add mls 'screen -list; echo; tmux list-sessions'

# mv / rm
abbr --add mv 'mv --interactive --verbose'
abbr --add vm mv
abbr --add rm 'rm --interactive --verbose'
abbr --add rmdir 'rmdir --verbose'
abbr --add rmf 'rm --recursive --force --verbose'
abbr --add cp 'cp --interactive --verbose'

# openssl
abbr --add oct 'openssl crl -noout -text'
abbr --add oqm 'openssl req -noout -modulus'
abbr --add orm 'openssl rsa -noout -modulus'
abbr --add ort 'openssl req -noout -text'
abbr --add osc 'openssl s_client'
abbr --add oxm 'openssl x509 -noout -modulus'
abbr --add oxt 'openssl x509 -noout -text'
abbr --add rssl "ruby -r 'openssl' -e 'puts OpenSSL::X509::DEFAULT_CERT_FILE'"

# ping
abbr --add pb 'ping -c 5 berkeley.edu'
abbr --add pg 'ping -c 5 google.com'
abbr --add pgp gpg

# process
abbr --add psa 'ps axuwwwww'
abbr --add psf 'ps afjwwwwwx'
abbr --add psw 'ps afuwwwwwx'
abbr --add t 'top -o +%CPU -d 1'

# proxy
abbr --add proh 'home -D localhost:9050'
abbr --add prol 'leela -D localhost:9050'
abbr --add pros prol

# public ip
abbr --add pubip publicip
abbr --add publicip 'curl --ipv4 --location --silent --fail --max-time 2 http://www.aatf.us/ip'

# quit
abbr --add quit exit

# rails
abbr --add rdm 'rails db:migrate'
abbr --add rdr 'rails db:reset'
abbr --add rds 'rails db:seed'
abbr --add rs 'rails server'

# screen / tmux
abbr --add s 'screen -r'
abbr --add sls 'screen -list'
abbr --add ta 'tmux attach'
abbr --add tls 'tmux list-sessions'
abbr --add screen 'screen -t (hostname)'

# scp / rsync
abbr --add scp 'echo "use rsync!\n\nrsync"'
abbr --add scpi 'scp -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no'
abbr --add rsync 'rsync --iconv=utf8,utf8 --archive --verbose --compress --hard-links --progress --timeout=5 --rsh=ssh'

# ssh
abbr --add sshi 'ssh -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no'
abbr --add sa "source $HOME/.keychain/$SHORTHOST-sh"
abbr --add esc "$EDITOR $HOME/.ssh/config"

# sudo
abbr --add sudo 'sudo --preserve-env'
abbr --add suod sudo

# terraform
abbr --add tf terraform
abbr --add tfmt 'terraform fmt'
abbr --add tgfmt 'terragrunt hcl format'

# time
abbr --add day 'date +%d'
abbr --add week 'date +%Y.%V.'
abbr --add timestamp 'date +%Y%m%d_%H%M%S'

# uname
abbr --add ua 'uname --all'
abbr --add ut uptime
abbr --add up ut
abbr --add ud update
abbr --add u users

# unalias / untar
abbr --add un unalias
abbr --add untar 'tar xvf'

# vi / vim
abbr --add vi vim
abbr --add vim nvim
abbr --add vimotd "$SUDO $EDITOR /etc/motd"

# watch
abbr --add watch 'watch --interval 0'

# wget
abbr --add wget 'wget --content-disposition'

# whcih (typo)
abbr --add whcih which

# mosh hosts
abbr --add uwave 'mosh uwave'
abbr --add wlk 'mosh wlk'
abbr --add sexi leela
abbr --add si li

# brew
abbr --add brewup 'brewupdate && brewupgrade'
abbr --add brewupdate 'brew update'
abbr --add brewupgrade 'brew upgrade --yes'

# update dotfiles
abbr --add update-dotfiles "$HOME/.dotfiles/setup"

# custom aliases (mirrors aliases-custom)
set -l CUST_DIR "$HOME/.config/fish/custom.d"
abbr --add ba "$EDITOR $CUST_DIR/aliases.fish && source $CUST_DIR/aliases.fish"
abbr --add ee "$EDITOR $CUST_DIR/exports.fish && source $CUST_DIR/exports.fish"
abbr --add zp "$EDITOR $CUST_DIR/prompt.fish && source $CUST_DIR/prompt.fish"

# OS-specific aliases
source_os_dotfiles aliases
