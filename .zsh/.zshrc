# Lines configured by zsh-newuser-install
HISTFILE=~/.zsh/history/${TTY#/dev/}
HISTSIZE=1000
SAVEHIST=1000
setopt appendhistory beep extendedglob nomatch
unsetopt autocd
bindkey -e
# End of lines configured by zsh-newuser-install

eval $(dircolors)
zmodload -i zsh/stat && disable stat

# The following lines were added by compinstall

zstyle ':completion:*' completer _expand _complete _ignored _match _list
zstyle ':completion:*' completions 1
zstyle ':completion:*' condition 1
zstyle ':completion:*' expand prefix suffix
zstyle ':completion:*' format 'Completing %d:'
zstyle ':completion:*' glob 1
zstyle ':completion:*' group-name ''
zstyle ':completion:*' ignore-parents parent pwd .. directory
zstyle ':completion:*' insert-unambiguous true
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*' list-prompt '%SAt %l: Hit TAB for more, or the character to insert%s'
zstyle ':completion:*' list-suffixes true
zstyle ':completion:*' match-original only
zstyle ':completion:*' matcher-list '' '+m:{[:lower:]}={[:upper:]}' '+m:{[:lower:][:upper:]}={[:upper:][:lower:]}' '+r:|[._-]=* r:|=*'
zstyle ':completion:*' menu select=long
zstyle ':completion:*' original true
zstyle ':completion:*' preserve-prefix '//[^/]##/'
zstyle ':completion:*' select-prompt '%SScrolling active: current selection at %l%s'
zstyle ':completion:*' squeeze-slashes true
zstyle ':completion:*' substitute 1
zstyle ':completion:*' use-compctl true
zstyle ':completion:*' verbose true
zstyle :compinstall filename '/home/shea/.zsh/.zshrc'

autoload -Uz compinit
compinit
# End of lines added by compinstall

GIT_PS1_SHOWDIRTYSTATE=1
GIT_PS1_SHOWSTASHSTATE=1
GIT_PS1_SHOWUNTRACKEDFILES=1
GIT_PS1_SHOWUPSTREAM="verbose"
GIT_PS1_SHOWCOLORHINTS=1
SCD_HISTFILE=${ZDOTDIR}/scd/history
ZSH_TMUX_AUTOSTART=true
ZSH_TMUX_AUTOSTART_ONCE=true
ZSH_TMUX_AUTOCONNECT=true
ZSH_TMUX_AUTOQUIT=$ZSH_TMUX_AUTOSTART
ZSH_TMUX_FIXTERM=true
ZSH_TMUX_ITERM2=false
ZSH_TMUX_FIXTERM_WITHOUT_256COLOR="screen"
ZSH_TMUX_FIXTERM_WITH_256COLOR="screen-256color"

source /usr/local/share/zsh/antigen.zsh
# Load the oh-my-zsh's library.
antigen use oh-my-zsh

# Bundles from the default repo (robbyrussell's oh-my-zsh).
antigen bundle colored-man-pages
antigen bundle colorize
antigen bundle common-aliases
antigen bundle copybuffer
antigen bundle copydir
antigen bundle copyfile
antigen bundle dotenv
antigen bundle emoji
antigen bundle emoji-clock
antigen bundle encode64
antigen bundle fancy-ctrl-z
#antigen bundle git
antigen bundle git-extras
antigen bundle git-flow-avh
antigen bundle git-prompt
antigen bundle git-remote-branch
#antigen bundle gitfast
antigen bundle gitignore
antigen bundle gpg-agent
antigen bundle man
antigen bundle safe-paste
antigen bundle scd
antigen bundle systemadmin
antigen bundle themes
antigen bundle tmux
antigen bundle urltools
antigen bundle vim-interaction
antigen bundle web-search

# Syntax highlighting bundle.
antigen bundle zsh-users/zsh-syntax-highlighting

antigen bundle arialdomartini/oh-my-git
antigen theme Shea690901/oh-my-git-themes oppa-lana-style-nerdfonts

# Tell Antigen that you're done.
antigen apply

# Load the theme.
#theme jtriley

ssh_agent_running=0
if [ -f "${HOME}/.ssh_agent" ]; then
  source "${HOME}/.ssh_agent"
  if ps -p $SSH_AGENT_PID | grep -q ssh-agent ; then
    ssh_agent_running=1
  fi
fi

if echo $- | grep -q i ; then
  if [ $ssh_agent_running -eq 0 ]; then
    /usr/bin/ssh-agent > "${HOME}/.ssh_agent"
    source "${HOME}/.ssh_agent"
    for x in ${HOME}/.ssh/*.pub
    do
      ssh-add ${x%%.pub}
    done
  fi
fi
unset ssh_agent_running x

export LANG=de_DE.UTF-8
export EDITOR='vim'

alias vi=vim

alias l='less -r'                               # raw control characters
alias grep='grep --color'                       # show differences in colour
alias egrep='egrep --color=auto'                # show differences in colour
alias fgrep='fgrep --color=auto'                # show differences in colour

# Some shortcuts for different directory listings
alias ls='ls --color=auto'                      # classify files in colour
alias dir='ls --color=auto --format=vertical'
alias vdir='ls --color=auto --format=long'
alias ll='ls -lag'                              # long list
