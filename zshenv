if [[ -f $HOME/.functions ]]
then
  source $HOME/.functions

  set_host_variables
fi

if [[ -f $HOME/.aliases ]]
then
  source $HOME/.aliases
fi

if [[ -f $HOME/.exports ]]
then
  source ~/.exports
fi
