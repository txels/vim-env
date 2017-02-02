# My VIM setup

Version 2, using Vundle as a submodule

## Getting started

Clone repo and submodules:

```
git clone git@github.com:txels/vim-env.git
cd vim-env
git submodule init
git submodule update
./setup
vim
```

Within vim, install/update bundles:

```
:BundleInstall!
```

Fonts for Powerline:

```
mkdir ~/.fonts
pushd ~/.fonts
git clone https://github.com/scotu/ubuntu-mono-powerline.git
fc-cache -vf ~/.fonts
```
