# functions/open_command.fish
# mirrors: dotfiles/zsh.functions.d/functions - open_command()

function open_command --description "Open a file with the appropriate application"
    set -l ostype (uname -s | tr '[A-Z]' '[a-z]')

    switch $ostype
        case darwin
            open $argv
        case cygwin
            cygstart $argv
        case linux
            if string match -q '*icrosoft*' (uname -r)
                # WSL
                set -l wpath (wslpath -w $argv[1] 2>/dev/null; or echo $argv[1])
                cmd.exe /c start '' $wpath
            else
                nohup xdg-open $argv &>/dev/null
            end
        case msys
            start "" $argv
        case '*'
            echo "Platform $ostype not supported"
            return 1
    end
end
