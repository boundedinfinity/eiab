# ~/.bash_logout

# User specific logout procedures

for i in {{ usershelld_home }}/bash/bash_logout.d/enabled/*.bash ; do
    if [ -r "$i" ]; then
        if [ "${-#*i}" != "$-" ]; then
            . "$i"
        else
            . "$i" >/dev/null
        fi
    fi
done
