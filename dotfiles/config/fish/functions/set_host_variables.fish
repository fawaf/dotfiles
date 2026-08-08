# functions/set_host_variables.fish
# mirrors: dotfiles/zsh.functions.d/set-host-variables

function set_local_internal_host_variables
    set -gx INTERNALIP NONE
    set -gx INTERNALHOST (hostname -f)
    set -gx INTERNALDOMAIN (hostname -f)
    set -gx INTERNALHOSTNAME (hostname -s)
end

function set_local_external_host_variables
    set -gx EXTERNALIP NONE
    set -gx EXTERNALHOST (hostname -f)
    set -gx EXTERNALDOMAIN (hostname -f)
    set -gx EXTERNALHOSTNAME (hostname -s)
end

function set_local_host_variables
    set_local_internal_host_variables
    set_local_external_host_variables
end

function set_host_variables
    get_configured_ip

    if test -z "$CONFIGURED_IP"
        set_local_host_variables
    else
        if not set -q DISABLE_PUBLIC_IP_CHECK
            set -l IP_URI "https://www.aatf.us/ip"
            if command -q curl
                set -l PUBLIC_IP (curl -4 --silent --fail --max-time 2 $IP_URI 2>/dev/null)
            else
                set -l PUBLIC_IP (wget -4 --quiet --output-document=- --timeout=2 $IP_URI 2>/dev/null)
            end

            set -l LOCAL_NAMESERVER (grep nameserver /etc/resolv.conf | head -1 | awk '{print $NF}')

            if string match -qr '^[0-9]' "$PUBLIC_IP"
                set -gx EXTERNALIP $PUBLIC_IP
                set -gx EXTERNALHOST (/usr/bin/dig +short -x $EXTERNALIP @$LOCAL_NAMESERVER | head -1 | string replace -r '\.$' '')
                set -gx EXTERNALHOSTNAME (echo $EXTERNALHOST | cut -d. -f1)
                set -gx EXTERNALDOMAIN (echo $EXTERNALHOST | cut -d. -f2-)

                if not set -q DISABLE_PRIVATE_IP_CHECK
                    set -gx INTERNALIP $CONFIGURED_IP
                    if test "$EXTERNALIP" = "$INTERNALIP"
                        set -gx INTERNALHOST $EXTERNALHOST
                        set -gx INTERNALHOSTNAME $EXTERNALHOSTNAME
                        set -gx INTERNALDOMAIN $EXTERNALDOMAIN
                    else
                        set -gx INTERNALHOST (/usr/bin/dig +short -x $INTERNALIP @$LOCAL_NAMESERVER | head -1 | string replace -r '\.$' '')
                        set -gx INTERNALHOSTNAME (echo $INTERNALHOST | cut -d. -f1)
                        set -gx INTERNALDOMAIN (echo $INTERNALHOST | cut -d. -f2-)
                    end
                else
                    set_local_internal_host_variables
                end
            end
        else
            set_local_external_host_variables
        end
    end

    if test -n "$argv[1]"
        set -gx REALHOST $argv[1]
    else if test -n "$EXTERNALHOST"
        set -gx REALHOST $EXTERNALHOST
    else if test -n "$INTERNALHOST"
        set -gx REALHOST $INTERNALHOST
    else
        set -gx REALHOST (hostname -f)
    end

    set -gx HOSTNAME (hostname)
    set -gx FULL_HOSTNAME (hostname -f)
    set -gx SHORTHOST (hostname -s)
end
