# conf.d/pre/dux.fish
# mirrors: dotfiles/zsh.pre.d/0-dux.zsh

if status is-interactive; and not set -q DISABLE_DUX
    if test (id -u) -ne 0
        if not env | grep --quiet SSH_C
            if not string match -q '*tty*' (tty); or test (uname -s) = Darwin
                if not set -q TMUX
                    ~/bin/dux; or echo "Failed to run Dux (returned with $status)"

                    echo -n "Exiting in 3 "
                    sleep 1
                    echo -n "2 "
                    sleep 1
                    echo -n "1 "
                    sleep 1

                    exit 0
                end
            end
        end
    end
end
