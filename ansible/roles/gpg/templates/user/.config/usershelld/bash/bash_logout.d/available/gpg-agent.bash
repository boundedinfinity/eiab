#!/usr/bin/env bash

# set -x 

env_dir=$HOME/.config/gpg
agent_config=$env_dir/gpg-agent.env

killagent() {
    reason=$1
    echo "kill gpg-agent: $reason"
    pkill gpg-agent
    rm -rf $agent_config
    unset GPG_AGENT_INFO
}

# kill the agent if more than one is running
agent_count=$(pgrep gpg-agent | wc -l)
if [ $agent_count -gt 1 ] ; then
    killagent "multiple agents running"
fi

# kill the agent if this is the last login session
running_pid=$(pgrep gpg-agent)
session_count=$(who | grep $USER | wc -l)
if [[ $running_pid && ${running_pid-x} ]] ; then
    if [  $session_count -eq 1 ] ; then
        killagent "last login session"
    fi
fi
