#!/usr/bin/env fish

set env_dir $HOME/.config/ssh
set agent_config_bash $env_dir/ssh-agent.bash
set agent_config_fish $env_dir/ssh-agent.fish
set -e SSH_AGENT_PID
set -e SSH_AUTH_SOCK

function killagent
    set reason $argv
    echo "kill ssh-agent: $reason"
    pkill ssh-agent
    rm -rf $agent_config_bash
    rm -rf $agent_config_fish
    set -e SSH_AGENT_PID
end

function source_config
    # generate fish style file from bash style file
    if test -f $agent_config_bash
        if not test -f $agent_config_fish
            for l in (cat $agent_config_bash)
                if echo $l | grep 'export' > /dev/null
                    set ll (echo $l | tr '=' ' ' | sed 's|;.*||')
                    echo "set -gx $ll" >> $agent_config_fish
                end
            end
        end
    end

    # source and export
    if test -f $agent_config_fish
        source $agent_config_fish
    end
end

# kill the agent if more than one is running
set agent_count (pgrep ssh-agent | wc -l)
if test $agent_count -gt 1
    killagent "multiple agents running"
end

# source the config if found
source_config

# kill the agent if running agent doesn't match the config PID
if test -n "$SSH_AGENT_PID"
    set running_pid (pgrep ssh-agent)
    if test -n "$running_pid"
        if test $running_pid -ne $SSH_AGENT_PID
            killagent "running agent PID doesn't match config PID"
        end
    end
end

# kill the agent if this is the last login session
set running_pid (pgrep ssh-agent)
set session_count (who | grep $USER | wc -l)
if test -n "$running_pid"
    if test $session_count -eq 1
        killagent "last login session"
    end
end
