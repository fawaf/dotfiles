# functions/get_configured_ip.fish + networking helpers
# mirrors: dotfiles/zsh.functions.d/networking
# named after get_configured_ip so fish can autoload it (set_host_variables
# calls it before config.fish has sourced the functions dir)

function get_configured_ip
    if not command -q ifconfig
        return
    end

    set -l NIC ""

    if set -q OVERRIDE_NIC
        set NIC $OVERRIDE_NIC
    else if set -q OVERRIDE_INTERFACE
        set NIC $OVERRIDE_INTERFACE
    else
        set -l os_info (uname -a)
        if string match -q '*grsec*' $os_info
            return
        else if string match -q -i '*cygwin*' $os_info
            set -gx HOST_IP (ifconfig | grep -i "ipv4 address" | head -1 | cut -d: -f2 | cut -d'(' -f1 | string trim)
            return
        else if string match -q -i '*darwin*' $os_info
            set -l IFACE_PREFIX en
            for i in (seq 0 9)
                set -l iface "$IFACE_PREFIX$i"
                if ifconfig $iface 2>/dev/null | grep -qw active; and ifconfig $iface 2>/dev/null | grep -qw inet
                    set -gx HOST_IP (ifconfig $iface | grep -w inet | tail -1 | awk '{print $2}')
                    set -gx CONFIGURED_IP $HOST_IP
                    return
                end
            end
        else if string match -q -i '*linux*' $os_info
            set NIC (ip addr | grep -v NO-CARRIER | grep -E '<.*,?UP,?.*>' | grep -v lo | head -1 | cut -d' ' -f2 | cut -d: -f1)
        else
            echo "Unsupported OS while determining host IP"
        end
    end

    set -gx INTERFACE $NIC

    if test -n "$NIC"
        set -gx HOST_IP (ifconfig $NIC | grep -w inet | grep -v 127.0 | head -1 | awk '{print $2}')
    end

    if test -z "$HOST_IP"
        return
    else
        if string match -q '*addr*' $HOST_IP
            set -gx CONFIGURED_IP (echo $HOST_IP | cut -d: -f2)
        else
            set -gx CONFIGURED_IP $HOST_IP
        end
    end
end

function octet
    shuf --head-count 1 --input-range 0-255
end

function generate-ip --description "Generate a random IP address"
    echo (octet).(octet).(octet).(octet)
end

function gen-ip
    generate-ip
end

function rand-ip
    generate-ip
end

function random-ip
    generate-ip
end
