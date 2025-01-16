[![FOSSA Status](https://app.fossa.com/api/projects/git%2Bgithub.com%2Ffawaf%2Fdotfiles.svg?type=shield)](https://app.fossa.com/projects/git%2Bgithub.com%2Ffawaf%2Fdotfiles?ref=badge_shield)

dotfiles
========

horribly terribibble garbage dotfiles

Requirements
------------
see [requirements.txt](https://github.com/fawaf/dotfiles/blob/main/requirements.txt) file

Install
-------
1. clone the repo (`git clone https://github.com/fawaf/dotfiles.git PATH_TO_DOTFILES`)
2. execute `PATH_TO_DOTFILES/setup`

### Config ###
```yaml
---
not_dotfiles:
  - somedir
append:
  config:
  gnupg:
  other_dir:
    - append
    - in
    - these
    - subdirs
```
- "append" - directories to not overwrite, but only append to

Contributors
------------
### [csivanich](https://github.com/csivanich/dotfiles) ###
- tmux configs
- i3 configs
- compton configs
- X configs
- dunst configs
- zsh configs

### [helmuthdu](https://github.com/helmuthdu/dotfiles) ###
- shell functions

### [oh my zsh](https://github.com/ohmyzsh/ohmyzsh) ###
- various functions

### git aliases ###
- https://gist.github.com/grant-h/761d753011b8df8ec417
- https://gist.github.com/jessesquires/d0f3fc99be8208394a450ce86443ce7d
- sarah riley

License
------------
[![FOSSA Status](https://app.fossa.com/api/projects/git%2Bgithub.com%2Ffawaf%2Fdotfiles.svg?type=large)](https://app.fossa.com/projects/git%2Bgithub.com%2Ffawaf%2Fdotfiles?ref=badge_large)

Links
----------
- http://gentoo-wiki.com/Talk:Screen
- http://www.gentoo.org/doc/en/zsh.xml
- http://aperiodic.net/phil/prompt/
- http://www.cs.elte.hu/zsh-manual/zsh_15.html
- http://www.cs.elte.hu/zsh-manual/zsh_16.html
- http://grml.org/zsh/zsh-lovers.html
- http://wiki.archlinux.org/index.php/Zsh
- http://zshwiki.org/home/examples/compquickstart
