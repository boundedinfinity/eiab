#!/usr/bin/env bash

if [ -f "${HOME}/.gpg-agent-info" ]; then
    source "${HOME}/.gpg-agent-info"
    export GPG_AGENT_INFO
    export SSH_AUTH_SOCK
    export SSH_AGENT_PID
else
    eval $( gpg-agent --daemon --enable-ssh-support --write-env-file ${HOME}/.gpg-agent-info )
fi
