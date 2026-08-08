# functions/take.fish
# mirrors: dotfiles/zsh.functions.d/functions - take()

function take --description "mkdir -p and cd into the directory"
    mkdir -p $argv && cd $argv[-1]
end
