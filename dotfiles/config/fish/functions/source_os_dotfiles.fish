# functions/source_os_dotfiles.fish
# mirrors: dotfiles/zsh.functions.d/source-os-dotfiles

function source_os_dotfiles
    set -l TYPE $argv[1]
    set -l KERNEL_NAME (uname | tr '[A-Z]' '[a-z]')
    set -l BASE "$HOME/.config/fish/conf.d/os"

    # cygwin reports e.g. cygwin_nt-10.0
    if string match -q 'cygwin*' $KERNEL_NAME
        set KERNEL_NAME cygwin
    end

    # source kernel-specific file
    set -l kernel_file "$BASE/$KERNEL_NAME/$TYPE.fish"
    if test -f $kernel_file
        source $kernel_file
    end

    # source linux-distro-specific files
    if test "$KERNEL_NAME" = linux
        if test -f /etc/debian_version
            set -l f "$BASE/debian/$TYPE.fish"
            test -f $f && source $f
        end
        if test -f /etc/SuSE-release
            set -l f "$BASE/suse/$TYPE.fish"
            test -f $f && source $f
        end
        if test -f /etc/redhat-release
            set -l f "$BASE/fedora/$TYPE.fish"
            test -f $f && source $f
        end
    end
end
