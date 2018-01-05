if [[ -f $HOME/.functions ]]
then
  source $HOME/.functions

  set_host_variables
fi

if [[ -f $HOME/.exports ]]
then
  source $HOME/.exports
fi

if [[ -f $HOME/.aliases ]]
then
  source $HOME/.aliases
fi

source $HOME/.exports-with-aliases
source $HOME/.aliases-with-exports
