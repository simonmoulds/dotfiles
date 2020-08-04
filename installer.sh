#!/bin/bash

BASEDIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# ###################### #
# emacs
# ###################### #

ln -s -f "${BASEDIR}"/emacs_d/ "${HOME}"/.emacs.d

# ###################### #
# zsh
# ###################### #

# N.B. the zprezto directory is a fork of the original repo
# (https://github.com/sorin-ionescu/prezto.git). To download the
# forked repo including all submodules, then link to upstream, do
# the following (https://stackoverflow.com/a/4438292):

# git submodule add https://github.com/simonmoulds/prezto.git "${ZDOTDIR:-$HOME}"/dotfiles/prezto
# cd "${ZDOTDIR:-$HOME}"/dotfiles/prezto/
# git submodule update --init --recursive
# git remote add upstream https://github.com/sorin-ionescu/prezto.git
# git remote -v
# git fetch upstream
# cd "${ZDOTDIR:-$HOME}"/dotfiles

# NB to remove submodules, see the following gist:
# https://gist.github.com/simonmoulds/3d6d07f0703bfe5a9ccc6744668b9187

# this is a bit convoluted but it preserves the original
# file structure of the prezto repository
for FILE in zshrc zlogin zlogout zprofile zshenv zpreztorc
do    
    cp -f "${BASEDIR}"/"${FILE}" "${BASEDIR}"/prezto/runcoms
done

if [ -d "${HOME}"/.zprezto ]
then    
    rm -rf "${HOME}"/.zprezto
fi
cp -rf "${BASEDIR}"/prezto "${HOME}"/.zprezto

ln -s -f "${HOME}"/.zprezto/runcoms/zpreztorc ~/.zpreztorc
ln -s -f "${HOME}"/.zprezto/runcoms/zshrc ~/.zshrc
ln -s -f "${HOME}"/.zprezto/runcoms/zlogin ~/.zlogin
ln -s -f "${HOME}"/.zprezto/runcoms/zlogout ~/.zlogout
ln -s -f "${HOME}"/.zprezto/runcoms/zprofile ~/.zprofile
ln -s -f "${HOME}"/.zprezto/runcoms/zshenv ~/.zshenv

# ###################### #
# tmux
# ###################### #

# git submodule add https://github.com/simonmoulds/.tmux.git tmux
# cd tmux
# git submodule update --init --recursive
# cd ..
if [ -d "${HOME}"/.tmux ]
then    
    rm -rf "${HOME}"/.tmux
fi
cp -rf tmux "${HOME}"/.tmux
ln -s -f "${HOME}"/.tmux/.tmux.conf "${HOME}"/.tmux.conf
ln -s -f "${HOME}"/.tmux/.tmux.conf.local "${HOME}"/.tmux.conf.local

# ###################### #
# git
# ###################### #

ln -s -f "${BASEDIR}"/gitconfig "${HOME}"/.gitconfig
