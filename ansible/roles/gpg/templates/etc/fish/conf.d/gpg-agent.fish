#!/usr/bin/env fish

if test -f $HOME/.gpg-agent-info
    cat $HOME/.gpg-agent-info | sed 's/=/ /' | while read key value
		set -e $key
		set -gx $key "$value"
	end
else
    eval ( gpg-agent --daemon --enable-ssh-support --write-env-file $HOME/.gpg-agent-info )
end
