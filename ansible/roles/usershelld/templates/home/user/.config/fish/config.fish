# User specific aliases and functions

for i in {{ usershelld_home }}/fish/login.d/enabled/*.fish
    if test -r $i
        source $i
    end
end

function --on-process-exit %self usershelld_exit 
    for i in {{ usershelld_home }}/fish/logout.d/enabled/*.fish
        if test -r $i
            source $i
        end
    end
end
