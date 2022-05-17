#! /bin/bash
_fuck=$(who am i|awk '{print $1}')
_dis=$(id -u $_fuck)
if [“$_dis” > 0]
then
export HISTSIZE=10000
export HISTTIMEFORMAT='%F %T'
export HISTFILE=/var/log/users_history/history-users-$(who am I | awk '{print $1}';exit)-$(date +%F)
export PROMPT_COMMAND='history -a'
fi
