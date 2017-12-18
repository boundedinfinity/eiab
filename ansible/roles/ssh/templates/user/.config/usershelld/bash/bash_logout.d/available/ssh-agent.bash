#!/usr/bin/env bash

env_dir=$HOME/.config/ssh
agent_config=$env_dir/ssh-agent.env

killagent() {
    reason=$1
    echo "kill ssh-agent: $reason"
    pkill ssh-agent
    rm -rf $agent_config
    unset SSH_AGENT_PID
}

# kill the agent if more than one is running
agent_count=$(pgrep ssh-agent | wc -l)
if [ $agent_count -gt 1 ] ; then
    killagent "multiple agents running"
fi

# source the config if found
if [ -f $agent_config ] ; then
    source $agent_config > /dev/null
fi

# kill the agent if running agent doesn't match the config PID
if [ -n $SSH_AGENT_PID ] ; then
    running_pid=$(pgrep ssh-agent)
    if [[ $running_pid && ${running_pid-x} ]] ; then
        if [ $running_pid -ne $SSH_AGENT_PID ] ; then
            killagent "running agent PID doesn't match config PID"
        fi
    fi
    unset running_pid
fi

# kill the agent if this is the last login session
session_count=$(who | grep $USER | wc -l)
if [ $session_count -eq 1 ] ; then
    killagent "last login session"
fi
