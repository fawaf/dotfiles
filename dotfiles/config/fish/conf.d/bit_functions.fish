# conf.d/bit_functions.fish
# mirrors: dotfiles/zsh.conf.d/bit_functions
# skipped from the zsh original:
#   - extract: a better port already exists in functions/extract.fish
#   - status systemd wrapper: `status` is a fish builtin and must not be shadowed

# BETTER GIT COMMANDS (by helmuthdu)
function bit
    switch "$argv[1]"
        case --init
            set -l NAME (git config --global user.name)
            set -l EMAIL (git config --global user.email)
            set -l GHUSER (git config --global github.user)
            set -l GEDITOR (git config --global core.editor)

            test -z "$NAME"; and read --prompt-str "Name: " NAME
            test -z "$EMAIL"; and read --prompt-str "Email: " EMAIL
            test -z "$GHUSER"; and read --prompt-str "Username: " GHUSER
            test -z "$GEDITOR"; and read --prompt-str "Editor: " GEDITOR

            git config --global user.name $NAME
            git config --global user.email $EMAIL
            git config --global github.user $GHUSER
            git config --global color.ui true
            git config --global color.status auto
            git config --global color.branch auto
            git config --global color.diff auto
            git config --global diff.color true
            git config --global core.filemode true
            git config --global push.default matching
            git config --global core.editor $GEDITOR
            git config --global format.signoff true
            git config --global alias.reset 'reset --soft HEAD^'
            git config --global alias.graph 'log --graph --oneline --decorate'
            git config --global alias.compare 'difftool --dir-diff HEAD^ HEAD'
            if command -q meld
                git config --global diff.guitool meld
                git config --global merge.tool meld
            else if command -q kdiff3
                git config --global diff.guitool kdiff3
                git config --global merge.tool kdiff3
            end
            git config --global --list
        case a add
            if test "$argv[2]" = --all
                git add -A
            else
                git add $argv[2]
            end
        case b branch
            switch "$argv[2]"
                case feature
                    if not git branch | grep -q unstable
                        echo "creating unstable branch..."
                        git branch unstable
                        git push origin unstable
                    end
                    git checkout -b feature --track origin/unstable
                case hotfix
                    git checkout -b hotfix master
                case master
                    git checkout master
                case '*'
                    if not git branch | grep -q $argv[2]
                        echo "creating $argv[2] branch..."
                        git branch $argv[2]
                        git push origin $argv[2]
                    end
                    git checkout $argv[2]
            end
        case c commit
            if test "$argv[2]" = --undo
                git reset --soft 'HEAD^'
            else
                git commit -am "$argv[2]"
            end
        case C cherry-pick
            git checkout -b patch master
            git pull $argv[3] $argv[4]
            git checkout master
            git cherry-pick $argv[2]
            git log
            git branch -D patch
        case d delete
            if not git branch | grep -q $argv[2]
                echo "No branch founded."
            else
                git branch -D $argv[2]
                git push origin --delete $argv[2]
            end
        case l log
            git log --graph --oneline --decorate
        case m merge
            switch "$argv[2]"
                case --fix
                    git mergetool
                case feature
                    if git branch | grep -q feature
                        git checkout unstable
                        git difftool -g -d unstable..feature
                        git merge --no-ff feature
                        git branch -d feature
                        git commit -am "$argv[3]"
                    else
                        echo "No unstable branch founded."
                    end
                case hotfix
                    if git branch | grep -q hotfix
                        git checkout -b unstable origin
                        git merge --no-ff hotfix
                        git commit -am "hotfix: v$argv[3]"
                        git checkout -b master origin
                        git merge hotfix
                        git commit -am "Hotfix: v$argv[3]"
                        git branch -d hotfix
                        git tag -a $argv[3] -m "Release: v$argv[3]"
                        git push --tags
                    else
                        echo "No hotfix branch founded."
                    end
                case '*'
                    if git branch | grep -q $argv[2]
                        git checkout -b master origin
                        git difftool -g -d master..$argv[2]
                        git merge --no-ff $argv[2]
                        git branch -d $argv[2]
                        git commit -am "$argv[3]"
                    else
                        echo "No unstable branch founded."
                    end
            end
        case p push
            git push origin $argv[2]
        case P pull
            if test "$argv[2]" = --force
                git fetch --all
                git reset --hard origin/master
            else
                git pull origin $argv[2]
            end
        case r release
            git checkout origin/master
            git merge --no-ff origin/unstable
            git branch -d unstable
            git tag -a $argv[2] -m "Release: v$argv[2]"
            git push --tags
        case '*'
            echo "Usage: bit [options]"
            echo "  --init                                              # Autoconfigure git options"
            echo "  a, [add] <files> [--all]                            # Add git files"
            echo "  c, [commit] <text> [--undo]                         # Add git files"
            echo "  C, [cherry-pick] <number> <url> [branch]            # Cherry-pick commit"
            echo "  b, [branch] feature|hotfix|<name>                   # Add/Change Branch"
            echo "  d, [delete] <branch>                                # Delete Branch"
            echo "  l, [log]                                            # Display Log"
            echo "  m, [merge] feature|hotfix|<name> <commit>|<version> # Merge branches"
            echo "  p, [push] <branch>                                  # Push files"
            echo "  P, [pull] <branch> [--foce]                         # Pull files"
            echo "  r, [release]                                        # Merge unstable branch on master"
            return 1
    end
end

# TOP 10 COMMANDS
# copyright 2007 - 2010 Christopher Bratusek
function top10
    history | awk '{a[$1]++ } END{for(i in a){print a[i] " " i}}' | sort -rn | head
end

# UP
# Goes up as many dirs as the number passed as argument, 1 by default
function goup
    set -l limit $argv[1]
    test -z "$limit"; and set limit 1

    set -l d ""
    for i in (seq $limit)
        set d "$d/.."
    end
    set d (string replace -r '^/' '' -- $d)
    test -z "$d"; and set d ..

    cd $d
end

# ARCHIVE COMPRESS
function compress
    if test -n "$argv[1]"
        set -l file $argv[1]
        switch $file
            case '*.tar.bz2'
                tar cjf $file $argv[2..-1]
            case '*.tar.gz'
                tar czf $file $argv[2..-1]
            case '*.tar'
                tar cf $file $argv[2..-1]
            case '*.tgz'
                tar czf $file $argv[2..-1]
            case '*.zip'
                zip $file $argv[2..-1]
            case '*.rar'
                rar $file $argv[2..-1]
        end
    else
        echo "usage: compress <foo.tar.gz> ./foo ./bar"
    end
end

# CONVERT TO ISO
function to_iso
    if test (count $argv) -eq 0; or test "$argv[1]" = --help; or test "$argv[1]" = -h
        echo "Converts raw, bin, cue, ccd, img, mdf, nrg cd/dvd image files to ISO image file."
        echo "Usage: to_iso file1 file2..."
    end
    for i in $argv
        if not test -f $i
            echo "'$i' is not a valid file; jumping it"
        else
            echo -n "converting $i..."
            set -l OUT (echo $i | cut -d '.' -f 1)
            switch $i
                case '*.raw'
                    bchunk -v $i $OUT.iso
                case '*.bin' '*.cue'
                    bin2iso $i $OUT.iso
                case '*.ccd' '*.img'
                    ccd2iso $i $OUT.iso
                case '*.mdf'
                    mdf2iso $i $OUT.iso
                case '*.nrg'
                    nrg2iso $i $OUT.iso
                case '*'
                    echo "to_iso don't know de extension of '$i'"
            end
            if test $status -ne 0
                echo_color red "ERROR!"
            else
                echo_color green "done!"
            end
        end
    end
end

# REMIND ME, ITS IMPORTANT!
# usage: remindme <time> <text>
# e.g.: remindme 10m "omg, the pizza"
function remindme
    fish -c "sleep $argv[1]; and zenity --info --text '$argv[2]'" &
end

# SIMPLE CALCULATOR
# usage: calc <equation>
function calc
    if command -q bc
        echo "scale=3; $argv" | bc -l
    else
        awk "BEGIN { print $argv }"
    end
end

# FIND A FILE WITH A PATTERN IN NAME
function ff
    find . -type f -iname "*$argv*" -ls
end

# FIND A FILE WITH PATTERN $1 IN NAME AND EXECUTE $2 ON IT
function fe
    set -l cmd $argv[2]
    test -z "$cmd"; and set cmd file
    find . -type f -iname "*$argv[1]*" -exec $cmd '{}' \;
end

# MOVE FILENAMES TO LOWERCASE
function lowercase
    for file in $argv
        set -l filename (basename -- $file)
        set -l dirname (dirname -- $file)
        set -l nf (echo $filename | tr A-Z a-z)
        set -l newname "$dirname/$nf"
        if test "$nf" != "$filename"
            mv -- $file $newname
            echo "lowercase: $file --> $newname"
        else
            echo "lowercase: $file not changed."
        end
    end
end

# SWAP 2 FILENAMES AROUND, IF THEY EXIST
# (from Uzi's bashrc)
function swap
    set -l TMPFILE tmp.$fish_pid

    if test (count $argv) -ne 2
        echo "swap: 2 arguments needed"
        return 1
    end
    if not test -e $argv[1]
        echo "swap: $argv[1] does not exist"
        return 1
    end
    if not test -e $argv[2]
        echo "swap: $argv[2] does not exist"
        return 1
    end

    mv $argv[1] $TMPFILE
    mv $argv[2] $argv[1]
    mv $TMPFILE $argv[2]
end

# FINDS DIRECTORY SIZES AND LISTS THEM FOR THE CURRENT DIRECTORY
function dirsize
    du -shx * .[a-zA-Z0-9_]* 2>/dev/null | grep -E '^ *[0-9.]*[MG]' | sort -n >/tmp/list
    grep -E '^ *[0-9.]*M' /tmp/list
    grep -E '^ *[0-9.]*G' /tmp/list
    rm -rf /tmp/list
end

# FIND AND REMOVE EMPTY DIRECTORIES
function fared
    read --prompt-str "Delete all empty folders recursively [y/N]: " OPT
    test "$OPT" = y; and find . -type d -empty -exec rm -fr '{}' \; 2>/dev/null
end

# FIND AND REMOVE ALL DOTFILES
function farad
    read --prompt-str "Delete all dotfiles recursively [y/N]: " OPT
    test "$OPT" = y; and find . -name '.*' -type f -exec rm -rf '{}' \;
end

# ENTER AND LIST DIRECTORY
function cd --wraps cd --description "cd, then list the directory"
    builtin cd $argv
    and if status is-interactive
        ls -hrt --color 2>/dev/null; or ls
    end
end

# SYSTEMD SUPPORT
if command -q systemctl
    function start
        sudo systemctl start $argv[1].service
    end
    function restart
        sudo systemctl restart $argv[1].service
    end
    function stop
        sudo systemctl stop $argv[1].service
    end
    function enable
        sudo systemctl enable $argv[1].service
    end
    function disable
        sudo systemctl disable $argv[1].service
    end
end
