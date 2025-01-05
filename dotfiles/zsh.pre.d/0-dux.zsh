if [[ -z "$DISABLE_DUX" ]]
then
  if [[ "$UID" -ne 0 ]]
  then
    if ! env | grep SSH
    then
      if [[ ! "$(tty)" =~ "tty" ]] || [[ "$(uname -s)" == "Darwin" ]]
      then
        if [[ -z "$TMUX" ]]
        then
            ~/bin/dux || echo "Failed to run Dux (returned with $?)"

            echo -n "Exiting in 3 "
            sleep 1
            echo -n "2 "
            sleep 1
            echo -n "1 "
            sleep 1

            exit 0
        fi
      fi
    fi
  fi
fi
