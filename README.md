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

### Config
```json
{
  "append": [
    "gnupg",
    "config",
    "other_dir"
  ]
}
```
* "append" - directories to not overwrite and append to

Contributors
------------
[csivanich](https://github.com/csivanich/dotfiles) for tmux configs
[csivanich](https://github.com/csivanich/dotfiles) for i3 configs
[csivanich](https://github.com/csivanich/dotfiles) for compton configs
