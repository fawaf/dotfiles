if [[ -f $HOME/.functions ]]
then
  source $HOME/.functions
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
