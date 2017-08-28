# global source {{{
if [[ -f $HOME/.functions ]]
then
  source $HOME/.functions

  set_host_variables
fi
# }}}

source ~/.exports
