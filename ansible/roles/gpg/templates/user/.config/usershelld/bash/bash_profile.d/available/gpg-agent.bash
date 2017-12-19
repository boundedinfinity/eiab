#!/usr/bin/env bash

env_dir=$HOME/.config/gpg
agent_config=$env_dir/gpg-agent.env

[ ! -d $env_dir ] && mkdir -p $env_dir

# start agent if not running
running_pid=$(pgrep gpg-agent)
if [ -z $running_pid ] ; then
    eval "gpg-agent --daemon --write-env-file $agent_config >/dev/null 2>&1"
    echo "Started new GPG agent"
else
    echo "Using running GPG agent"
fi

# source the config if found
if [ -f $agent_config ] ; then
    source $agent_config >/dev/null 2>&1
    export GPG_AGENT_INFO=$GPG_AGENT_INFO
fi
