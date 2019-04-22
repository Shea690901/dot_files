# ~/.profile: executed by the command interpreter for login shells.
# This file is not read by bash(1), if ~/.bash_profile or ~/.bash_login
# exists.
# see /usr/share/doc/bash/examples/startup-files for examples.
# the files are located in the bash-doc package.

# the default umask is set in /etc/profile; for setting the umask
# for ssh logins, install and configure the libpam-umask package.
#umask 022


# Set user-defined locale
export LANG="de_DE.utf8"

# This file is not read by bash(1) if ~/.bash_profile or ~/.bash_login
# exists.
#
# if running bash
if [ -n "$BASH_VERSION" ]; then
  # include .bashrc if it exists
  if [ -f "$HOME/.bashrc" ]; then
    . "$HOME/.bashrc"
  fi
fi

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

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/bin" ] ; then
    PATH="$HOME/bin:$PATH"
fi

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/.local/bin" ] ; then
    PATH="$HOME/.local/bin:$PATH"
fi
