# To the extent possible under law, the author(s) have dedicated all copyright
# and related and neighboring rights to this software to the public domain
# worldwide. This software is distributed without any warranty. You should have
# received a copy of the CC0 Public Domain Dedication along with this software.
# If not, see <http://creativecommons.org/publicdomain/zero/1.0/>.

# base-files version 4.2-4

# ~/.profile: executed by the command interpreter for login shells.

# The latest version as installed by the Cygwin Setup program can
# always be found at /etc/defaults/etc/skel/.profile

# Modifying /etc/skel/.profile directly will prevent
# setup from updating it.

# The copy in your home directory (~/.profile) is yours, please
# feel free to customise it to create a shell
# environment to your liking.  If you feel a change
# would be benificial to all, please feel free to send
# a patch to the cygwin mailing list.

# User dependent .profile file

# Set user-defined locale
export LANG=$(locale -uU)

# This file is not read by bash(1) if ~/.bash_profile or ~/.bash_login
# exists.
#
# if running bash
if [ -n "${BASH_VERSION}" ]; then
  if [ -f "${HOME}/.bashrc" ]; then
    source "${HOME}/.bashrc"
  fi
fi

ssh_agent_running=0
if [ -f "${HOME}/.ssh_agent" ]; then
  source "${HOME}/.ssh_agent"
  if ps -p $SSH_AGENT_PID | grep -q /usr/bin/ssh-agent ; then
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
