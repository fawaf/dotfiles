# conf.d/rationalize_dots.fish
# mirrors: dotfiles/zsh.conf.d/rationalize-dots
# zsh rebinds "." to grow ".." into "../.."; the fish idiom is an abbr
# that expands ".."-runs typed as a command into the matching cd

function __rationalize_dots
    set -l dots (string length -- $argv[1])
    echo cd (string repeat -n (math $dots - 1) ../)
end

abbr --add rationalize_dots --position command --regex '^\.\.+$' --function __rationalize_dots
