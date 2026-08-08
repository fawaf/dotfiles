# functions/echo_color.fish
# mirrors: dotfiles/zsh.functions.d/text

function echo_color
    set -l color $argv[1]
    set -l message $argv[2]

    switch $color
        case red
            set_color red
            echo $message
            set_color normal
        case green
            set_color green
            echo $message
            set_color normal
        case '*'
            echo $message
    end
end
