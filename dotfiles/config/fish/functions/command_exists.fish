# functions/command_exists.fish
# mirrors: dotfiles/zsh.functions.d/commands

function command_exists
    command -q $argv[1]
end
