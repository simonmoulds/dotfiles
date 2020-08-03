#
# Executes commands at the start of an interactive session.
#
# Authors:
#   Sorin Ionescu <sorin.ionescu@gmail.com>
#

# Source Prezto.
if [[ -s "${ZDOTDIR:-$HOME}/.zprezto/init.zsh" ]]; then
  source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"
fi

# Customize to your needs...
if [[ -r /usr/local/lib/python2.7/site-packages/powerline/bindings/zsh/powerline.zsh ]]; then
  source /usr/local/lib/python2.7/site-packages/powerline/bindings/zsh/powerline.zsh
fi

# Path
export PATH=$HOME/local/zlib:$HOME/local/openmpi:$HOME/local/netcdf:$PATH
