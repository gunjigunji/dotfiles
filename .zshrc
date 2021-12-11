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

setopt auto_cd
setopt auto_pushd

#exa
if [[ $(command -v exa) ]]; then
  alias e='exa --icons'
  alias ls='e'
  alias l='e'
fi

#neovim
if [[ $(command -v nvim) ]]; then
  alias vi='nvim'
fi

#use SyncTex on neovim
alias nvim="NVIM_LISTEN_ADDRESS=/tmp/nvimsocket nvim"
