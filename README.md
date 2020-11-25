[![FOSSA Status](https://app.fossa.com/api/projects/git%2Bgithub.com%2Ffawaf%2Fdotfiles.svg?type=shield)](https://app.fossa.com/projects/git%2Bgithub.com%2Ffawaf%2Fdotfiles?ref=badge_shield)

dotfiles
========

my terribibble dotfiles

Requirements
------------
* slop
* fileutils
* json

Install
-------
1. clone the repo (`git clone https://github.com/gnowxilef/dotfiles.git PATH_TO_DOTFILES`)
2. execute `PATH_TO_DOTFILES/setup.rb`

### Config ###
```json
{
  "append": [
    "gnupg",
    "config",
    "other_dir"
  ]
}
```
* "append" - directories to not overwrite, but only append to

Contributors
------------
### [csivanich](https://github.com/csivanich/dotfiles) ###
* tmux configs
* i3 configs
* compton configs
* X configs
* dunst configs
* zsh configs

### [helmuthdu](https://github.com/helmuthdu/dotfiles) ###
* shell functions


## License
[![FOSSA Status](https://app.fossa.com/api/projects/git%2Bgithub.com%2Ffawaf%2Fdotfiles.svg?type=large)](https://app.fossa.com/projects/git%2Bgithub.com%2Ffawaf%2Fdotfiles?ref=badge_large)