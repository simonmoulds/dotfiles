#!/bin/bash

BASEDIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# clean
rm -rf ~/.emacs.d
rm -rf ~/.zprezto
rm -rf ~/.tmux
rm -r ~/.zpreztorc
rm -r ~/.zshrc ~/.zlogin ~/.zlogout ~/.zprofile ~/.zshenv
rm -r ~/.tmux.conf
rm -r ~/.gitconfig

# emacs
ln -s ${BASEDIR}/emacs_d/ ~/.emacs.d

# zsh

# N.B. the zprezto directory is a fork of the original repo
# (https://github.com/sorin-ionescu/prezto.git). To download and
# pull changes from upstream, do the following:

# > git clone --recursive https://github.com/simonmoulds/prezto.git "${ZDOTDIR:-$HOME}/dotfiles/zprezto
# > git remote add upstream https://github.com/sorin-ionescu/prezto.git
# > git remote -v
# > git fetch upstream

# > git clone --recursive https://github.com/simonmoulds/prezto.git "${ZDOTDIR:-$HOME}"/dotfiles/zprezto

for f in zshrc zlogin zlogout zprofile zshenv zpreztorc
do    
    cp -rf ${BASEDIR}/${f} ${BASEDIR}/prezto/runcoms
done

cp -rf ${BASEDIR}/prezto ~/.zprezto

ln -s ~/.zprezto/runcoms/zpreztorc ~/.zpreztorc
ln -s ~/.zprezto/runcoms/zshrc ~/.zshrc
ln -s ~/.zprezto/runcoms/zlogin ~/.zlogin
ln -s ~/.zprezto/runcoms/zlogout ~/.zlogout
ln -s ~/.zprezto/runcoms/zprofile ~/.zprofile
ln -s ~/.zprezto/runcoms/zshenv ~/.zshenv

# tmux
ln -s ${BASEDIR}/tmux/ ~/.tmux
ln -s ${BASEDIR}/tmux_conf ~/.tmux.conf

# git
ln -s ${BASEDIR}/gitconfig ~/.gitconfig
