# User specific aliases and functions

for i in {{ usershelld_home }}/fish/login.d/enabled/*.fish
    if test -r $i
        source $i
    end
end

function on_exit --on-process-exit %self
    for i in {{ usershelld_home }}/fish/logout.d/enabled/*.fish
        if test -r $i
            source $i
        end
    end
end
