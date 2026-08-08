# functions/to_path.fish
# mirrors: dotfiles/zsh.functions.d/path

function to_path
    # Join array elements with ':' separator
    echo (string join ':' $argv)
end
