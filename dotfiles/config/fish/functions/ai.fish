# functions/ai.fish
# mirrors: dotfiles/zsh.functions.d/functions - ai()

function ai --description "Get current host related info"
    printf "You are logged in on host: %s\n" (hostname)
    echo
    printf "Additional system information: %s\n" (uname -a)
    echo
    printf "Users logged on: %s\n" (w -h)
    echo
    printf "Current date and time: %s\n" (date)
    echo
    printf "Machine uptime statistics: %s\n" (uptime)
    echo "==================================================================================================="
    echo "network info"
    echo

    if test -z "$HOST_IP" -a -z "$EXTERNALIP"
        printf "Not connected to the internet\n"
        return
    end
    if test "$EXTERNALIP" = "$HOST_IP"
        printf "IP Address: %s\n" $HOST_IP
    else
        printf "External IP Address: %s\n" $EXTERNALIP
    end
    if test "$HOST_IP" != "$EXTERNALIP" -a -n "$HOST_IP"
        printf "Internal IP Address: %s\n" $HOST_IP
    end
end
